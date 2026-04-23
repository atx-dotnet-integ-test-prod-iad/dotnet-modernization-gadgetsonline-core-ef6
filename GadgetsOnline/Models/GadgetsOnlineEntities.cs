using GadgetsOnline.Models;
using Microsoft.EntityFrameworkCore;
using Npgsql;
using System;

using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace GadgetsOnline.Models
{
    public class GadgetsOnlineEntities : DbContext
    {
// Default constructor using DbContextOptions
        public GadgetsOnlineEntities(DbContextOptions<GadgetsOnlineEntities> options) : base(options)
        {
        }

        // Constructor with explicit connection string
        public GadgetsOnlineEntities(string dbConn) : base(new DbContextOptionsBuilder<GadgetsOnlineEntities>().UseNpgsql(dbConn).UseLazyLoadingProxies().Options)
        {
        }

        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }

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
                .Where(e => e.State == Microsoft.EntityFrameworkCore.EntityState.Added || e.State == Microsoft.EntityFrameworkCore.EntityState.Modified);

            foreach (var entry in entries)
            {
                foreach (var property in entry.Properties)
                {
                    var value = property.CurrentValue;
                    if (value is DateTime dateTime && dateTime.Kind != DateTimeKind.Utc)
                    {
                        property.CurrentValue = DateTime.SpecifyKind(dateTime, DateTimeKind.Utc);
                    }
                }
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // -------------------------------------------------------
            // Schema + column mappings (gadgetsonline_dbo schema)
            // -------------------------------------------------------

            modelBuilder.Entity<Product>()
                .ToTable("products", "gadgetsonline_dbo")
                .Property(e => e.ProductId).HasColumnName("productid");
            modelBuilder.Entity<Product>()
                .Property(e => e.CategoryId).HasColumnName("categoryid");
            modelBuilder.Entity<Product>()
                .Property(e => e.Name).HasColumnName("name");
            modelBuilder.Entity<Product>()
                .Property(e => e.Price).HasColumnName("price");
            modelBuilder.Entity<Product>()
                .Property(e => e.ProductArtUrl).HasColumnName("productarturl");

            modelBuilder.Entity<Category>()
                .ToTable("categories", "gadgetsonline_dbo")
                .Property(e => e.CategoryId).HasColumnName("categoryid");
            modelBuilder.Entity<Category>()
                .Property(e => e.Name).HasColumnName("name");
            modelBuilder.Entity<Category>()
                .Property(e => e.Description).HasColumnName("description");

            modelBuilder.Entity<Cart>()
                .ToTable("carts", "gadgetsonline_dbo")
                .Property(e => e.RecordId).HasColumnName("recordid");
            modelBuilder.Entity<Cart>()
                .Property(e => e.CartId).HasColumnName("cartid");
            modelBuilder.Entity<Cart>()
                .Property(e => e.ProductId).HasColumnName("productid");
            modelBuilder.Entity<Cart>()
                .Property(e => e.Count).HasColumnName("count");
            modelBuilder.Entity<Cart>()
                .Property(e => e.DateCreated).HasColumnName("datecreated");

            modelBuilder.Entity<Order>()
                .ToTable("orders", "gadgetsonline_dbo")
                .Property(e => e.OrderId).HasColumnName("orderid");
            modelBuilder.Entity<Order>()
                .Property(e => e.OrderDate).HasColumnName("orderdate");
            modelBuilder.Entity<Order>()
                .Property(e => e.Username).HasColumnName("username");
            modelBuilder.Entity<Order>()
                .Property(e => e.FirstName).HasColumnName("firstname");
            modelBuilder.Entity<Order>()
                .Property(e => e.LastName).HasColumnName("lastname");
            modelBuilder.Entity<Order>()
                .Property(e => e.Address).HasColumnName("address");
            modelBuilder.Entity<Order>()
                .Property(e => e.City).HasColumnName("city");
            modelBuilder.Entity<Order>()
                .Property(e => e.State).HasColumnName("state");
            modelBuilder.Entity<Order>()
                .Property(e => e.PostalCode).HasColumnName("postalcode");
            modelBuilder.Entity<Order>()
                .Property(e => e.Country).HasColumnName("country");
            modelBuilder.Entity<Order>()
                .Property(e => e.Phone).HasColumnName("phone");
            modelBuilder.Entity<Order>()
                .Property(e => e.Email).HasColumnName("email");
            modelBuilder.Entity<Order>()
                .Property(e => e.Total).HasColumnName("total");

            modelBuilder.Entity<OrderDetail>()
                .ToTable("orderdetails", "gadgetsonline_dbo")
                .Property(e => e.OrderDetailId).HasColumnName("orderdetailid");
            modelBuilder.Entity<OrderDetail>()
                .Property(e => e.OrderId).HasColumnName("orderid");
            modelBuilder.Entity<OrderDetail>()
                .Property(e => e.ProductId).HasColumnName("productid");
            modelBuilder.Entity<OrderDetail>()
                .Property(e => e.Quantity).HasColumnName("quantity");
            modelBuilder.Entity<OrderDetail>()
                .Property(e => e.UnitPrice).HasColumnName("unitprice");

            // -------------------------------------------------------
            // Relationship configurations (preserved unchanged)
            // -------------------------------------------------------

            // Configure relationships
            modelBuilder.Entity<Category>()
                .HasMany(c => c.Products)
                .WithOne(p => p.Category)
                .HasForeignKey(p => p.CategoryId);

            modelBuilder.Entity<Cart>()
                .HasOne(c => c.Product)
                .WithMany()
                .HasForeignKey(c => c.ProductId);

            modelBuilder.Entity<Order>()
                .HasMany(o => o.OrderDetails)
                .WithOne(od => od.Order)
                .HasForeignKey(od => od.OrderId);

            modelBuilder.Entity<OrderDetail>()
                .HasOne(od => od.Product)
                .WithMany()
                .HasForeignKey(od => od.ProductId);
        }

    }


}
