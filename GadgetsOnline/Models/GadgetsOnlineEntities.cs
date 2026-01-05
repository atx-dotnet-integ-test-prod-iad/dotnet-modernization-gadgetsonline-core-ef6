using GadgetsOnline.Models;
using Npgsql;
using System;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace GadgetsOnline.Models
{
    public class GadgetsOnlineEntities : DbContext
    {
        // Default constructor for EF Core
        public GadgetsOnlineEntities(DbContextOptions<GadgetsOnlineEntities> options) : base(options)
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
                .Where(e => e.State == EntityState.Added || e.State == EntityState.Modified);

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
            // Configure table and column mappings for PostgreSQL
            modelBuilder.Entity<Product>()
                .ToTable("products", "gadgetsonline_dbo");
            modelBuilder.Entity<Product>()
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
                .ToTable("categories", "gadgetsonline_dbo");
            modelBuilder.Entity<Category>()
                .Property(e => e.CategoryId).HasColumnName("categoryid");
            modelBuilder.Entity<Category>()
                .Property(e => e.Name).HasColumnName("name");
            modelBuilder.Entity<Category>()
                .Property(e => e.Description).HasColumnName("description");

            // Configure relationships for Category
            modelBuilder.Entity<Category>()
                .HasMany(c => c.Products)
                .WithOne(p => p.Category)
                .HasForeignKey(p => p.CategoryId)
                .IsRequired();

            modelBuilder.Entity<Cart>()
                .ToTable("carts", "gadgetsonline_dbo");
            modelBuilder.Entity<Cart>()
                .Property(e => e.RecordId).HasColumnName("recordid");
            modelBuilder.Entity<Cart>()
                .Property(e => e.CartId).HasColumnName("cartid");
            modelBuilder.Entity<Cart>()
                .Property(e => e.ProductId).HasColumnName("productid");
            modelBuilder.Entity<Cart>()
                .Property(e => e.Count).HasColumnName("count");
            modelBuilder.Entity<Cart>()
                .Property(e => e.DateCreated).HasColumnName("datecreated");

            // Configure relationships for Cart
            modelBuilder.Entity<Cart>()
                .HasOne(c => c.Product)
                .WithMany()
                .HasForeignKey(c => c.ProductId)
                .IsRequired();

            modelBuilder.Entity<Order>()
                .ToTable("orders", "gadgetsonline_dbo");
            modelBuilder.Entity<Order>()
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

            // Configure relationships for Order
            modelBuilder.Entity<Order>()
                .HasMany(o => o.OrderDetails)
                .WithOne(od => od.Order)
                .HasForeignKey(od => od.OrderId)
                .IsRequired();

            modelBuilder.Entity<OrderDetail>()
                .ToTable("orderdetails", "gadgetsonline_dbo");
            modelBuilder.Entity<OrderDetail>()
                .Property(e => e.OrderDetailId).HasColumnName("orderdetailid");
            modelBuilder.Entity<OrderDetail>()
                .Property(e => e.OrderId).HasColumnName("orderid");
            modelBuilder.Entity<OrderDetail>()
                .Property(e => e.ProductId).HasColumnName("productid");
            modelBuilder.Entity<OrderDetail>()
                .Property(e => e.Quantity).HasColumnName("quantity");
            modelBuilder.Entity<OrderDetail>()
                .Property(e => e.UnitPrice).HasColumnName("unitprice");

            // Configure relationships for OrderDetail
            modelBuilder.Entity<OrderDetail>()
                .HasOne(od => od.Product)
                .WithMany()
                .HasForeignKey(od => od.ProductId)
                .IsRequired();
        }

    }


}
