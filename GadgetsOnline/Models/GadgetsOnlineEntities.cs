using GadgetsOnline.Models;
using Npgsql;
using System;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace GadgetsOnline.Models
{
    /// <summary>
    /// PostgreSQL provider configuration for GadgetsOnlineEntities.
    /// Registers the Npgsql provider services and connection factory for EF6.
    /// </summary>
    public class GadgetsOnlineEntitiesPostgreSqlConfiguration : DbConfiguration
    {
        public GadgetsOnlineEntitiesPostgreSqlConfiguration()
        {
            SetProviderServices("Npgsql", NpgsqlServices.Instance);
            SetDefaultConnectionFactory(new NpgsqlConnectionFactory());
        }
    }

    [DbConfigurationType(typeof(GadgetsOnlineEntitiesPostgreSqlConfiguration))]
    public class GadgetsOnlineEntities : DbContext
    {
        // Default constructor using connection string name from config
        public GadgetsOnlineEntities() : base("name=GadgetsOnlineEntities")
        {
            // Enable lazy loading by default (alternative to AutoInclude)
            this.Configuration.LazyLoadingEnabled = true;
            this.Configuration.ProxyCreationEnabled = true;
        }

        // Constructor with explicit connection string
        public GadgetsOnlineEntities(string dbConn) : base(dbConn)
        {
            this.Configuration.LazyLoadingEnabled = true;
            this.Configuration.ProxyCreationEnabled = true;
        }

        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }

        // ---------------------------------------------------------------------------
        // DateTime UTC compatibility: ensures DateTime values are stored/read as UTC
        // so that Npgsql does not throw on timestamp-without-timezone mismatches.
        // ---------------------------------------------------------------------------
        public override int SaveChanges()
        {
            FixDateTimeKinds();
            return base.SaveChanges();
        }

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            FixDateTimeKinds();
            return base.SaveChangesAsync(cancellationToken);
        }

        private void FixDateTimeKinds()
        {
            var entries = ChangeTracker.Entries()
                .Where(e => e.State == EntityState.Added || e.State == EntityState.Modified);

            foreach (var entry in entries)
            {
                foreach (var property in entry.CurrentValues.PropertyNames)
                {
                    var value = entry.CurrentValues[property];
                    if (value is DateTime dateTime && dateTime.Kind != DateTimeKind.Utc)
                    {
                        entry.CurrentValues[property] = DateTime.SpecifyKind(dateTime, DateTimeKind.Utc);
                    }
                }
            }
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // ------------------------------------------------------------------
            // Product  →  gadgetsonline_dbo.products
            // ------------------------------------------------------------------
            var product = modelBuilder.Entity<Product>();
            product.ToTable("products", "gadgetsonline_dbo");
            product.Property(e => e.ProductId).HasColumnName("productid");
            product.Property(e => e.CategoryId).HasColumnName("categoryid");
            product.Property(e => e.Name).HasColumnName("name");
            product.Property(e => e.Price).HasColumnName("price");
            product.Property(e => e.ProductArtUrl).HasColumnName("productarturl");

            // ------------------------------------------------------------------
            // Category  →  gadgetsonline_dbo.categories
            // ------------------------------------------------------------------
            var category = modelBuilder.Entity<Category>();
            category.ToTable("categories", "gadgetsonline_dbo");
            category.Property(e => e.CategoryId).HasColumnName("categoryid");
            category.Property(e => e.Name).HasColumnName("name");
            category.Property(e => e.Description).HasColumnName("description");

            // Relationship: Category has many Products
            category.HasMany(c => c.Products)
                .WithRequired(p => p.Category)
                .HasForeignKey(p => p.CategoryId);

            // ------------------------------------------------------------------
            // Cart  →  gadgetsonline_dbo.carts
            // ------------------------------------------------------------------
            var cart = modelBuilder.Entity<Cart>();
            cart.ToTable("carts", "gadgetsonline_dbo");
            cart.Property(e => e.RecordId).HasColumnName("recordid");
            cart.Property(e => e.CartId).HasColumnName("cartid");
            cart.Property(e => e.ProductId).HasColumnName("productid");
            cart.Property(e => e.Count).HasColumnName("count");
            cart.Property(e => e.DateCreated).HasColumnName("datecreated");

            // Relationship: Cart requires one Product
            cart.HasRequired(c => c.Product)
                .WithMany()
                .HasForeignKey(c => c.ProductId);

            // ------------------------------------------------------------------
            // Order  →  gadgetsonline_dbo.orders
            // ------------------------------------------------------------------
            var order = modelBuilder.Entity<Order>();
            order.ToTable("orders", "gadgetsonline_dbo");
            order.Property(e => e.OrderId).HasColumnName("orderid");
            order.Property(e => e.OrderDate).HasColumnName("orderdate");
            order.Property(e => e.Username).HasColumnName("username");
            order.Property(e => e.FirstName).HasColumnName("firstname");
            order.Property(e => e.LastName).HasColumnName("lastname");
            order.Property(e => e.Address).HasColumnName("address");
            order.Property(e => e.City).HasColumnName("city");
            order.Property(e => e.State).HasColumnName("state");
            order.Property(e => e.PostalCode).HasColumnName("postalcode");
            order.Property(e => e.Country).HasColumnName("country");
            order.Property(e => e.Phone).HasColumnName("phone");
            order.Property(e => e.Email).HasColumnName("email");
            order.Property(e => e.Total).HasColumnName("total");

            // Relationship: Order has many OrderDetails
            order.HasMany(o => o.OrderDetails)
                .WithRequired(od => od.Order)
                .HasForeignKey(od => od.OrderId);

            // ------------------------------------------------------------------
            // OrderDetail  →  gadgetsonline_dbo.orderdetails
            // ------------------------------------------------------------------
            var orderDetail = modelBuilder.Entity<OrderDetail>();
            orderDetail.ToTable("orderdetails", "gadgetsonline_dbo");
            orderDetail.Property(e => e.OrderDetailId).HasColumnName("orderdetailid");
            orderDetail.Property(e => e.OrderId).HasColumnName("orderid");
            orderDetail.Property(e => e.ProductId).HasColumnName("productid");
            orderDetail.Property(e => e.Quantity).HasColumnName("quantity");
            orderDetail.Property(e => e.UnitPrice).HasColumnName("unitprice");

            // Relationship: OrderDetail requires one Product
            orderDetail.HasRequired(od => od.Product)
                .WithMany()
                .HasForeignKey(od => od.ProductId);
        }
    }
}
