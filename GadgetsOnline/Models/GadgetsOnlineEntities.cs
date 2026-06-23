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
    // PostgreSQL EF6 provider configuration
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

        // DateTime compatibility: normalize all DateTime values to UTC before persisting
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
            // ---------------------------------------------------------------
            // Product — table: gadgetsonline_dbo.products
            // ---------------------------------------------------------------
            var productEntity = modelBuilder.Entity<Product>();
            productEntity.ToTable("products", "gadgetsonline_dbo");
            productEntity.Property(e => e.ProductId).HasColumnName("productid");
            productEntity.Property(e => e.CategoryId).HasColumnName("categoryid");
            productEntity.Property(e => e.Name).HasColumnName("name");
            productEntity.Property(e => e.Price).HasColumnName("price");
            productEntity.Property(e => e.ProductArtUrl).HasColumnName("productarturl");

            // ---------------------------------------------------------------
            // Category — table: gadgetsonline_dbo.categories
            // ---------------------------------------------------------------
            var categoryEntity = modelBuilder.Entity<Category>();
            categoryEntity.ToTable("categories", "gadgetsonline_dbo");
            categoryEntity.Property(e => e.CategoryId).HasColumnName("categoryid");
            categoryEntity.Property(e => e.Name).HasColumnName("name");
            categoryEntity.Property(e => e.Description).HasColumnName("description");

            // Preserve existing relationship configuration
            categoryEntity.HasMany(c => c.Products)
                .WithRequired(p => p.Category)
                .HasForeignKey(p => p.CategoryId);

            // ---------------------------------------------------------------
            // Cart — table: gadgetsonline_dbo.carts
            // ---------------------------------------------------------------
            var cartEntity = modelBuilder.Entity<Cart>();
            cartEntity.ToTable("carts", "gadgetsonline_dbo");
            cartEntity.Property(e => e.RecordId).HasColumnName("recordid");
            cartEntity.Property(e => e.CartId).HasColumnName("cartid");
            cartEntity.Property(e => e.ProductId).HasColumnName("productid");
            cartEntity.Property(e => e.Count).HasColumnName("count");
            cartEntity.Property(e => e.DateCreated).HasColumnName("datecreated");

            // Preserve existing relationship configuration
            cartEntity.HasRequired(c => c.Product)
                .WithMany()
                .HasForeignKey(c => c.ProductId);

            // ---------------------------------------------------------------
            // Order — table: gadgetsonline_dbo.orders
            // ---------------------------------------------------------------
            var orderEntity = modelBuilder.Entity<Order>();
            orderEntity.ToTable("orders", "gadgetsonline_dbo");
            orderEntity.Property(e => e.OrderId).HasColumnName("orderid");
            orderEntity.Property(e => e.OrderDate).HasColumnName("orderdate");
            orderEntity.Property(e => e.Username).HasColumnName("username");
            orderEntity.Property(e => e.FirstName).HasColumnName("firstname");
            orderEntity.Property(e => e.LastName).HasColumnName("lastname");
            orderEntity.Property(e => e.Address).HasColumnName("address");
            orderEntity.Property(e => e.City).HasColumnName("city");
            orderEntity.Property(e => e.State).HasColumnName("state");
            orderEntity.Property(e => e.PostalCode).HasColumnName("postalcode");
            orderEntity.Property(e => e.Country).HasColumnName("country");
            orderEntity.Property(e => e.Phone).HasColumnName("phone");
            orderEntity.Property(e => e.Email).HasColumnName("email");
            orderEntity.Property(e => e.Total).HasColumnName("total");

            // Preserve existing relationship configuration
            orderEntity.HasMany(o => o.OrderDetails)
                .WithRequired(od => od.Order)
                .HasForeignKey(od => od.OrderId);

            // ---------------------------------------------------------------
            // OrderDetail — table: gadgetsonline_dbo.orderdetails
            // ---------------------------------------------------------------
            var orderDetailEntity = modelBuilder.Entity<OrderDetail>();
            orderDetailEntity.ToTable("orderdetails", "gadgetsonline_dbo");
            orderDetailEntity.Property(e => e.OrderDetailId).HasColumnName("orderdetailid");
            orderDetailEntity.Property(e => e.OrderId).HasColumnName("orderid");
            orderDetailEntity.Property(e => e.ProductId).HasColumnName("productid");
            orderDetailEntity.Property(e => e.Quantity).HasColumnName("quantity");
            orderDetailEntity.Property(e => e.UnitPrice).HasColumnName("unitprice");

            // Preserve existing relationship configuration
            orderDetailEntity.HasRequired(od => od.Product)
                .WithMany()
                .HasForeignKey(od => od.ProductId);
        }
    }
}
