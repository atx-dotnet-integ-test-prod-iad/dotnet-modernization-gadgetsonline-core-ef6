using System;
using System.Collections.Generic;
using System.Linq;
using GadgetsOnline.Models;
using GadgetsOnline.Services;
using Microsoft.AspNetCore.Mvc;

namespace GadgetsOnline.Controllers
{
    public class StoreController : Controller
    {
        private readonly IInventory _inventory;
        private readonly IShoppingCart _shoppingCart;

        public StoreController(IInventory inventory, IShoppingCart shoppingCart)
        {
            _inventory = inventory;
            _shoppingCart = shoppingCart;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Browse(string category)
        {
            var productModel = _inventory.GetAllProductsInCategory(category);
            return View(productModel);
        }

        public ActionResult Details(int id)
        {
            var album = _inventory.GetProductById(id);
            return View(album);
        }
    }
}
