using System.Web.Mvc;

namespace BikeShopWeb.Controllers
{
    
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult Product()
        {
            return RedirectToAction("Index", "Products");
        }
        public ActionResult SellBike()
        {
            return RedirectToAction("Create", "Products");
        }
       
    }
}