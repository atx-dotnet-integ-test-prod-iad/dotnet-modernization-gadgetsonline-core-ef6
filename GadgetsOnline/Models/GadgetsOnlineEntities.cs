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
    /// PostgreSQL DbConfiguration for EF6 with Npgsql provider.
    /// Registered via [DbConfigurationType] on GadgetsOnlineEntities.
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

        // ---------------------------------------------------------------
        // DateTime compatibility: PostgreSQL requires UTC DateTimeKind.
        // ---------------------------------------------------------------
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
            // Relationship configurations (preserved from original)
            // ---------------------------------------------------------------
            modelBuilder.Entity<Category>()
                .HasMany(c => c.Products)
                .WithRequired(p => p.Category)
                .HasForeignKey(p => p.CategoryId);

            modelBuilder.Entity<Cart>()
                .HasRequired(c => c.Product)
                .WithMany()
                .HasForeignKey(c => c.ProductId);

            modelBuilder.Entity<Order>()
                .HasMany(o => o.OrderDetails)
                .WithRequired(od => od.Order)
                .HasForeignKey(od => od.OrderId);

            modelBuilder.Entity<OrderDetail>()
                .HasRequired(od => od.Product)
                .WithMany()
                .HasForeignKey(od => od.ProductId);

            // ---------------------------------------------------------------
            // PostgreSQL schema + column name mappings
            // Schema: gadgetsonline_dbo
            // ---------------------------------------------------------------

            // Product -> gadgetsonline_dbo.products
            {
                var entityConfig = modelBuilder.Entity<Product>();
                entityConfig.ToTable("products", "gadgetsonline_dbo");
                entityConfig.Property(e => e.ProductId).HasColumnName("productid");
                entityConfig.Property(e => e.CategoryId).HasColumnName("categoryid");
                entityConfig.Property(e => e.Name).HasColumnName("name");
                entityConfig.Property(e => e.Price).HasColumnName("price");
                entityConfig.Property(e => e.ProductArtUrl).HasColumnName("productarturl");
            }

            // Category -> gadgetsonline_dbo.categories
            {
                var entityConfig = modelBuilder.Entity<Category>();
                entityConfig.ToTable("categories", "gadgetsonline_dbo");
                entityConfig.Property(e => e.CategoryId).HasColumnName("categoryid");
                entityConfig.Property(e => e.Name).HasColumnName("name");
                entityConfig.Property(e => e.Description).HasColumnName("description");
            }

            // Cart -> gadgetsonline_dbo.carts
            {
                var entityConfig = modelBuilder.Entity<Cart>();
                entityConfig.ToTable("carts", "gadgetsonline_dbo");
                entityConfig.Property(e => e.RecordId).HasColumnName("recordid");
                entityConfig.Property(e => e.CartId).HasColumnName("cartid");
                entityConfig.Property(e => e.ProductId).HasColumnName("productid");
                entityConfig.Property(e => e.Count).HasColumnName("count");
                entityConfig.Property(e => e.DateCreated).HasColumnName("datecreated");
            }

            // Order -> gadgetsonline_dbo.orders
            {
                var entityConfig = modelBuilder.Entity<Order>();
                entityConfig.ToTable("orders", "gadgetsonline_dbo");
                entityConfig.Property(e => e.OrderId).HasColumnName("orderid");
                entityConfig.Property(e => e.OrderDate).HasColumnName("orderdate");
                entityConfig.Property(e => e.Username).HasColumnName("username");
                entityConfig.Property(e => e.FirstName).HasColumnName("firstname");
                entityConfig.Property(e => e.LastName).HasColumnName("lastname");
                entityConfig.Property(e => e.Address).HasColumnName("address");
                entityConfig.Property(e => e.City).HasColumnName("city");
                entityConfig.Property(e => e.State).HasColumnName("state");
                entityConfig.Property(e => e.PostalCode).HasColumnName("postalcode");
                entityConfig.Property(e => e.Country).HasColumnName("country");
                entityConfig.Property(e => e.Phone).HasColumnName("phone");
                entityConfig.Property(e => e.Email).HasColumnName("email");
                entityConfig.Property(e => e.Total).HasColumnName("total");
            }

            // OrderDetail -> gadgetsonline_dbo.orderdetails
            {
                var entityConfig = modelBuilder.Entity<OrderDetail>();
                entityConfig.ToTable("orderdetails", "gadgetsonline_dbo");
                entityConfig.Property(e => e.OrderDetailId).HasColumnName("orderdetailid");
                entityConfig.Property(e => e.OrderId).HasColumnName("orderid");
                entityConfig.Property(e => e.ProductId).HasColumnName("productid");
                entityConfig.Property(e => e.Quantity).HasColumnName("quantity");
                entityConfig.Property(e => e.UnitPrice).HasColumnName("unitprice");
            }
        }
    }
}
