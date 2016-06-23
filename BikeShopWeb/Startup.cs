using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BikeShopWeb.Startup))]
namespace BikeShopWeb
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
