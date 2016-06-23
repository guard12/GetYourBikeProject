using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BikeShopWeb.Models;
using PagedList;

namespace BikeShopWeb.Controllers
{
    public class ProductCategoriesController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: ProductCategories
        public ActionResult Index()
        {
            return View(db.ProductCategories.ToList());
        }

        public ActionResult getCategories()
        {
            return PartialView(db.ProductCategories.ToList());

        }


        // Find product by Category
        public ActionResult FindProduct(int? id, string sortBikes, string currentFilter, int? page, string searchString)
        {

            ViewBag.PriceSortParam = String.IsNullOrEmpty(sortBikes) ? "Price_desc" : "";
            ViewBag.DateSortParam = sortBikes == "Date" ? "date_desc" : "Date";
            ViewBag.CurrentSort = sortBikes;

            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            ViewBag.currentFilter = searchString;

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
           
            ProductCategory productCategory = db.ProductCategories.Find(id);

            if (productCategory == null)
            {
                return HttpNotFound();
            }
            //var products = from p in db.Products
            //               select p;

            

            int pageSize = 9;
            int pageNumber = (page ?? 1);

            var Allproducts = from pc in productCategory.Product.ToPagedList(pageNumber, pageSize)
                              select pc;
            if (!String.IsNullOrEmpty(searchString))
            {
                Allproducts = Allproducts.Where(pc => pc.productName.Contains(searchString)
                                       || pc.productDescription.Contains(searchString));
            }

            switch (sortBikes)
            {
                case "Price_desc":
                    Allproducts = Allproducts.OrderByDescending(pc => pc.price);
                    break;
                case "date_desc":
                    Allproducts = Allproducts.OrderByDescending(pc => pc.ProductAdded);
                    break;
                case "Date":
                    Allproducts = Allproducts.OrderBy(pc => pc.ProductAdded);
                    break;
                default:
                    Allproducts = Allproducts.OrderBy(pc => pc.price);
                    break;
            }

            return View(Allproducts.ToPagedList(pageNumber, pageSize));

        }

        // GET: ProductCategories/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProductCategory productCategory = db.ProductCategories.Find(id);
            if (productCategory == null)
            {
                return HttpNotFound();
            }
            return View(productCategory);
        }

        // GET: ProductCategories/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: ProductCategories/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProductCategoryID,categoryName,categoryNotes")] ProductCategory productCategory)
        {
            if (ModelState.IsValid)
            {
                db.ProductCategories.Add(productCategory);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(productCategory);
        }

        // GET: ProductCategories/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProductCategory productCategory = db.ProductCategories.Find(id);
            if (productCategory == null)
            {
                return HttpNotFound();
            }
            return View(productCategory);
        }

        // POST: ProductCategories/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProductCategoryID,categoryName,categoryNotes")] ProductCategory productCategory)
        {
            if (ModelState.IsValid)
            {
                db.Entry(productCategory).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(productCategory);
        }

        // GET: ProductCategories/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProductCategory productCategory = db.ProductCategories.Find(id);
            if (productCategory == null)
            {
                return HttpNotFound();
            }
            return View(productCategory);
        }

        // POST: ProductCategories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ProductCategory productCategory = db.ProductCategories.Find(id);
            db.ProductCategories.Remove(productCategory);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
