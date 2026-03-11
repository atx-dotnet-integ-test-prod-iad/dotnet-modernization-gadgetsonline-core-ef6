using Npgsql;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;

namespace GadgetsOnline.Models
{
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

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // Configure relationships
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

            // PostgreSQL table and column mappings

            // Product -> gadgetsonline_dbo.products
            var productConfig = modelBuilder.Entity<Product>();
            productConfig.ToTable("products", "gadgetsonline_dbo");
            productConfig.Property(e => e.ProductId).HasColumnName("productid");
            productConfig.Property(e => e.CategoryId).HasColumnName("categoryid");
            productConfig.Property(e => e.Name).HasColumnName("name");
            productConfig.Property(e => e.Price).HasColumnName("price");
            productConfig.Property(e => e.ProductArtUrl).HasColumnName("productarturl");

            // Category -> gadgetsonline_dbo.categories
            var categoryConfig = modelBuilder.Entity<Category>();
            categoryConfig.ToTable("categories", "gadgetsonline_dbo");
            categoryConfig.Property(e => e.CategoryId).HasColumnName("categoryid");
            categoryConfig.Property(e => e.Name).HasColumnName("name");
            categoryConfig.Property(e => e.Description).HasColumnName("description");

            // Cart -> gadgetsonline_dbo.carts
            var cartConfig = modelBuilder.Entity<Cart>();
            cartConfig.ToTable("carts", "gadgetsonline_dbo");
            cartConfig.Property(e => e.RecordId).HasColumnName("recordid");
            cartConfig.Property(e => e.CartId).HasColumnName("cartid");
            cartConfig.Property(e => e.ProductId).HasColumnName("productid");
            cartConfig.Property(e => e.Count).HasColumnName("count");
            cartConfig.Property(e => e.DateCreated).HasColumnName("datecreated");

            // Order -> gadgetsonline_dbo.orders
            var orderConfig = modelBuilder.Entity<Order>();
            orderConfig.ToTable("orders", "gadgetsonline_dbo");
            orderConfig.Property(e => e.OrderId).HasColumnName("orderid");
            orderConfig.Property(e => e.OrderDate).HasColumnName("orderdate");
            orderConfig.Property(e => e.Username).HasColumnName("username");
            orderConfig.Property(e => e.FirstName).HasColumnName("firstname");
            orderConfig.Property(e => e.LastName).HasColumnName("lastname");
            orderConfig.Property(e => e.Address).HasColumnName("address");
            orderConfig.Property(e => e.City).HasColumnName("city");
            orderConfig.Property(e => e.State).HasColumnName("state");
            orderConfig.Property(e => e.PostalCode).HasColumnName("postalcode");
            orderConfig.Property(e => e.Country).HasColumnName("country");
            orderConfig.Property(e => e.Phone).HasColumnName("phone");
            orderConfig.Property(e => e.Email).HasColumnName("email");
            orderConfig.Property(e => e.Total).HasColumnName("total");

            // OrderDetail -> gadgetsonline_dbo.orderdetails
            var orderDetailConfig = modelBuilder.Entity<OrderDetail>();
            orderDetailConfig.ToTable("orderdetails", "gadgetsonline_dbo");
            orderDetailConfig.Property(e => e.OrderDetailId).HasColumnName("orderdetailid");
            orderDetailConfig.Property(e => e.OrderId).HasColumnName("orderid");
            orderDetailConfig.Property(e => e.ProductId).HasColumnName("productid");
            orderDetailConfig.Property(e => e.Quantity).HasColumnName("quantity");
            orderDetailConfig.Property(e => e.UnitPrice).HasColumnName("unitprice");
        }

    }


}
