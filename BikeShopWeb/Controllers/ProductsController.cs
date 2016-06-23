using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BikeShopWeb.Models;
using Microsoft.AspNet.Identity;
using System.IO;
using PagedList;

namespace BikeShopWeb.Controllers
{
    //[Authorize]
    public class ProductsController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();
        //[AllowAnonymous]
        // GET: Products
        public ActionResult Index(string sortBikes, string currentFilter, int? page, string searchString)
        {
            ViewBag.PriceSortParam = String.IsNullOrEmpty(sortBikes) ? "Price_desc" : "";
            ViewBag.DateSortParam = sortBikes == "Date" ? "date_desc" : "Date";
            //ViewBag.KeyWordParam = string.IsNullOrEmpty
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
            // string isloggedin = User.Identity.GetUserId();
           var products = from p in db.Products.Include(p => p.ApplicationUsers).Include(p => p.ProductCategory)
            select p;

            if (!String.IsNullOrEmpty(searchString))
            {
                products = products.Where(p => p.productName.Contains(searchString)
                                       || p.productDescription.Contains(searchString));
            }

            switch (sortBikes)
            {
                case "Price_desc":
                    products = products.OrderByDescending(p => p.price);
                    break;
                case "date_desc":
                    products = products.OrderByDescending(p => p.ProductAdded);
                    break;
                case "Date":
                    products = products.OrderBy(p => p.ProductAdded);
                    break;
                default:
                    products = products.OrderBy(p => p.price);
                    break;
            }

            int pageSize = 9;
            int pageNumber = (page ?? 1);
            return View(products.ToPagedList(pageNumber, pageSize));
        }

        public ActionResult getCategories()
        {
            return PartialView(db.ProductCategories.ToList());

        }

        
        public ActionResult getProductsOfUser(int? id)
        {
            return View(db.Products.ToList());
        }

        // GET: Products/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }
        // GET: Products/Create
        public ActionResult Create()
        {
            ViewBag.ApplicationUsersID = new SelectList(db.Users, "Id", "Email");
            ViewBag.ProductCategoryID = new SelectList(db.ProductCategories, "ProductCategoryID", "categoryName");
            return View();
        }

        // POST: Products/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProductID,productName,productDescription,price,ProductCategoryID,ApplicationUsersID,ProductAdded, UploadedFile")] Product product, HttpPostedFileBase UploadedFile)
        {
            if(UploadedFile == null)
            {
                product.ImageUrl = "/NoImage/rsz_default.png";
                product.ProductAdded = DateTime.Now;
                product.ApplicationUsersID = User.Identity.GetUserId();
                db.Products.Add(product);
                db.SaveChanges();
                ViewBag.SuccessMsg = "Your bike has been successfully added";
                return RedirectToAction("Index");
            }
            else
            {
                var ext = Path.GetExtension(UploadedFile.FileName);
                string path = Server.MapPath("~/UploadedImages/");
                string name = Guid.NewGuid().ToString() + ext;
                UploadedFile.SaveAs(path + name);
                if (ModelState.IsValid)
                {
                    product.ImageUrl = "/UploadedImages/" + name;
                    product.ProductAdded = DateTime.Today;
                    product.ApplicationUsersID = User.Identity.GetUserId();
                    db.Products.Add(product);
                    db.SaveChanges();
                    ViewBag.SuccessMsg = "Your bike has been successfully added";
                    return RedirectToAction("Index");
                }
            }
            
            ViewBag.ProductCategoryID = new SelectList(db.ProductCategories, "ProductCategoryID", "categoryName", product.ProductCategoryID);
            return View(product);
        }

        // GET: Products/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.ApplicationUsersID = new SelectList(db.Users, "Id", "Email", product.ApplicationUsersID);
            ViewBag.ProductCategoryID = new SelectList(db.ProductCategories, "ProductCategoryID", "categoryName", product.ProductCategoryID);
            return View(product);
        }

        // POST: Products/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProductID,productName,productDescription,price,ProductCategoryID,ApplicationUsersID")] Product product)
        {
            if (ModelState.IsValid)
            {
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ApplicationUsersID = new SelectList(db.Users, "Id", "Email", product.ApplicationUsersID);
            ViewBag.ProductCategoryID = new SelectList(db.ProductCategories, "ProductCategoryID", "categoryName", product.ProductCategoryID);
            return View(product);
        }

        // GET: Products/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
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
        public ActionResult UserProducts()
        {
            //id = User.Identity.GetUserId();


               
            return PartialView(db.Products.ToList());

        }
    }
}
