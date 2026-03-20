using System;
using GadgetsOnline.Models;
using GadgetsOnline.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;

namespace GadgetsOnline.Controllers
{
    public class CheckoutController : Controller
    {
        private readonly IOrderProcessing _orderProcessing;
        public CheckoutController(IOrderProcessing orderProcessing)
        {
            _orderProcessing = orderProcessing;
        }
        private IOrderProcessing GetOrderProcess()
        {
            return _orderProcessing;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AddressAndPayment()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddressAndPayment(IFormCollection values)
        {
            var order = new Order();
            TryUpdateModelAsync(order);
            try
            {
                order.Username = "Anonymous";
                order.OrderDate = DateTime.Now;
                bool result = GetOrderProcess().ProcessOrder(order, this.HttpContext);
                return RedirectToAction("Complete", new { id = order.OrderId });
            }
            catch
            {
                return View(order);
            }
        }

        public ActionResult Complete(int id)
        {
            return View(id);
        }
    }
}
