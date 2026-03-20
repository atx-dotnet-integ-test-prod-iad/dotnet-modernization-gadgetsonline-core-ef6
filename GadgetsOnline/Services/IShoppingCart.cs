using GadgetsOnline.Models;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;

namespace GadgetsOnline.Services
{
    public interface IShoppingCart
    {
        void AddToCart(int id);
        int CreateOrder(Order order);
        ShoppingCart GetCart(HttpContext context);
        string GetCartId(HttpContext context);
        List<Cart> GetCartItems();
        int GetCount();
        int RemoveFromCart(int id);
        decimal GetTotal();
    }
}
