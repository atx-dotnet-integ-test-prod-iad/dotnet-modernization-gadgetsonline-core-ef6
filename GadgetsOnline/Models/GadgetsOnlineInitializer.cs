using System.Collections.Generic;
using System.Data.Entity;

namespace GadgetsOnline.Models
{
    public class GadgetsOnlineInitializer : CreateDatabaseIfNotExists<GadgetsOnlineEntities>
    {
        protected override void Seed(GadgetsOnlineEntities context)
        {
            // Categories - PostgreSQL will auto-generate CategoryId values
            var categories = new List<Category>
            {
                new Category { Name = "Mobile Phones", Description = "Latest collection of Mobile Phones" },
                new Category { Name = "Laptops", Description = "Latest Laptops in 2022" },
                new Category { Name = "Desktops", Description = "Latest Desktops in 2022" },
                new Category { Name = "Audio", Description = "Latest audio devices" },
                new Category { Name = "Accessories", Description = "USB Cables, Mobile chargers and Keyboards etc" }
            };
            categories.ForEach(c => context.Categories.Add(c));
            context.SaveChanges(); // Save categories first to generate IDs

            // Products - PostgreSQL will auto-generate ProductId values
            // Using navigation properties for relationships instead of CategoryId
            var products = new List<Product>
            {
                // Mobile Phones (categories[0])
                new Product { Category = categories[0], Name = "Phone 12", Price = 699.00M, ProductArtUrl = "/Content/Images/Mobile/1.jpg" },
                new Product { Category = categories[0], Name = "Phone 13 Pro", Price = 999.00M, ProductArtUrl = "/Content/Images/Mobile/2.jpg" },
                new Product { Category = categories[0], Name = "Phone 13 Pro Max", Price = 1199.00M, ProductArtUrl = "/Content/Images/Mobile/3.jpg" },
                
                // Laptops (categories[1])
                new Product { Category = categories[1], Name = "XTS 13'", Price = 899.00M, ProductArtUrl = "/Content/Images/Laptop/1.jpg" },
                new Product { Category = categories[1], Name = "PC 15.5'", Price = 479.00M, ProductArtUrl = "/Content/Images/Laptop/2.jpg" },
                new Product { Category = categories[1], Name = "Notebook 14", Price = 169.00M, ProductArtUrl = "/Content/Images/Laptop/3.jpg" },
                
                // Desktops (categories[2])
                new Product { Category = categories[2], Name = "The IdeaCenter", Price = 539.00M, ProductArtUrl = "/Content/Images/placeholder.gif" },
                new Product { Category = categories[2], Name = "COMP 22-df003w", Price = 389.00M, ProductArtUrl = "/Content/Images/placeholder.gif" },
                
                // Audio (categories[3])
                new Product { Category = categories[3], Name = "Bluetooth Headphones Over Ear", Price = 28.00M, ProductArtUrl = "/Content/Images/Headphones/1.png" },
                new Product { Category = categories[3], Name = "ZX Series ", Price = 10.00M, ProductArtUrl = "/Content/Images/Headphones/2.png" },
                
                // Accessories (categories[4])
                new Product { Category = categories[4], Name = "Wireless charger", Price = 9.99M, ProductArtUrl = "/Content/Images/placeholder.gif" },
                new Product { Category = categories[4], Name = "Mousepad", Price = 2.99M, ProductArtUrl = "/Content/Images/placeholder.gif" },
                new Product { Category = categories[4], Name = "Keyboard", Price = 9.99M, ProductArtUrl = "/Content/Images/placeholder.gif" },
            };
            products.ForEach(p => context.Products.Add(p));

            context.SaveChanges();
        }
    }
}
