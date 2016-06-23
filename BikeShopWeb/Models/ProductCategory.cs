using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BikeShopWeb.Models
{
    public class ProductCategory
    {
        public int ProductCategoryID { set; get; }
        public string categoryName { set; get; }
        public string categoryNotes { set; get; }
        public virtual List<Product> Product { set; get; }
    }
}