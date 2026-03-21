using System;
using System.Collections.Generic;
using System.Linq;
using GadgetsOnline.Models;
using GadgetsOnline.Services;
using GadgetsOnline.ViewModel;
using Microsoft.AspNetCore.Mvc;
using System.Text.Encodings.Web;

namespace GadgetsOnline.Controllers
{
    public class ShoppingCartController : Controller
    {
        private readonly IInventory _inventory;
        private readonly IShoppingCart _shoppingCart;

        public ShoppingCartController(IInventory inventory, IShoppingCart shoppingCart)
        {
            _inventory = inventory;
            _shoppingCart = shoppingCart;
        }

        //Inventory inventory;
        // GET: ShoppingCart
        public ActionResult Index()
        {
            var cart = _shoppingCart.GetCart(this.HttpContext);
            var viewModel = new ShoppingCartViewModel{CartItems = cart.GetCartItems(), CartTotal = cart.GetTotal()};
            return View(viewModel);
        }

        public ActionResult AddToCart(int id)
        {
            var cart = _shoppingCart.GetCart(this.HttpContext);
            cart.AddToCart(id);
            return RedirectToAction("Index");
        }

        public ActionResult RemoveFromCart(int id)
        {
            var cart = _shoppingCart.GetCart(this.HttpContext);
            int itemCount = cart.RemoveFromCart(id);
            var productName = _inventory.GetProductNameById(id);
            var results = new ShoppingCartRemoveViewModel{Message = HtmlEncoder.Default.Encode(productName) + " has been removed from your shopping cart.", CartTotal = cart.GetTotal(), CartCount = cart.GetCount(), ItemCount = itemCount, DeleteId = id};
            return RedirectToAction("Index");
        }
    }
}
