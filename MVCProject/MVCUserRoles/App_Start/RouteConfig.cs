using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace MVCUserRoles
{
	public class RouteConfig
	{
		public static void RegisterRoutes(RouteCollection routes)
		{
			routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

			routes.MapRoute(
				name: "Details",
				url: "Crawljob/{action}/{id}",
				defaults: new { controller = "Crawljob", action = "Details", id = UrlParameter.Optional }
			);

			routes.MapRoute(
				name: "UnauthorizedAccess",
				url: "Crawljob/{action}/{id}",
				defaults: new { controller = "Crawljob", action = "UnauthorizedAccess", id = UrlParameter.Optional }
			);

			routes.MapRoute(
				name: "Crawljob",
				url: "Crawljob/{action}/{id}",
				defaults: new { controller = "Crawljob", action = "Index", id = UrlParameter.Optional }
			);
			//routes.MapRoute(
			//	name: "UploadImage",
			//	url: "Catalog/{action}/{id}",
			//	defaults: new { controller = "Catalog", action = "UploadImage", id = UrlParameter.Optional }
			//);

			routes.MapRoute(
				name: "Default",
				url: "{controller}/{action}/{id}",
				defaults: new { controller = "Home", action = "Login", id = UrlParameter.Optional }
			);

			


		}
	}
}
