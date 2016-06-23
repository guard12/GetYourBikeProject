using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace BikeShopWeb.Models
{
    public class Product
    {  
        public int ProductID { get; set; }

        public string productName { set; get; }

        public string productDescription { set; get; }

        public double price { set; get; }

        public int ProductCategoryID { set; get; }

        [DisplayFormat(DataFormatString = "{0:dd MMM yyyy}")]
        public DateTime? ProductAdded { set; get; }

        public virtual ProductCategory ProductCategory { set; get; }

        public string ImageUrl { get; set; }
        public string ApplicationUsersID { get; set; }

        public virtual ApplicationUser ApplicationUsers { get; set; }

        

    }
}