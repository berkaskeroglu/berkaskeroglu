using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Security.Claims;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.Ajax.Utilities;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using MongoDB.Bson;
using MongoDB.Driver;
using MVCUserRoles.Models;


namespace MVCUserRoles.Controllers
{
    [Authorize]
    public class CrawljobController : Controller
    {
		private readonly IMongoCollection<LinksModel> _crawljobCollection;
		private readonly IMongoCollection<CrawljobModel> jobsCollection;
		private readonly IMongoDatabase database;
        private readonly IMongoDatabase jobDatabase;
		ApplicationDbContext context;

		public CrawljobController()
		{
			var client = new MongoClient("mongodb+srv://askerko:Test.1234@cluster0.mfepkqz.mongodb.net/"); // MongoDB bağlantı adresi
			database = client.GetDatabase("crawler"); // Veritabanı adı
           // jobDatabase = client.GetDatabase("jobs");
			jobsCollection = database.GetCollection<CrawljobModel>("jobs"); // Collection adı
			_crawljobCollection = database.GetCollection<LinksModel>("links"); // Collection adı
			context = new ApplicationDbContext();
		}

		public ActionResult Index()
		{
			List<CrawljobModel> crawljobs = jobsCollection.Find(Builders<CrawljobModel>.Filter.Eq("isDeleted", "false")).ToList();
			if (isAdminUser())
			{
				ViewBag.IsAdminUser = true; // veya false, bu değeri göre ayarlayın
				return View(crawljobs);
			}
			else if (isManagerUser())
			{
				ViewBag.IsManagerUser = true; // veya false, bu değeri göre ayarlayın
				return View(crawljobs);
			}
			else if (isEmployeeUser())
			{
				ViewBag.IsEmployeeUser = true; // veya false, bu değeri göre ayarlayın
				return View(crawljobs);
			}
			else if (isInternUser())
			{
				ViewBag.IsInternUser = true; // veya false, bu değeri göre ayarlayın
				return View(crawljobs);
			}
			else if (isViewerUser())
			{
				ViewBag.IsViewerUser = true; // veya false, bu değeri göre ayarlayın
				return View(crawljobs);
			}

			return View(crawljobs);
		}


		public ActionResult Details(string id)
		{
			var filter = Builders<LinksModel>.Filter.And(
				Builders<LinksModel>.Filter.Eq("mainId", id),  // mainId eşleşmesi
				Builders<LinksModel>.Filter.Eq("isDeleted", "false")  // isDeleted false eşleşmesi
				);
			List<LinksModel> links = _crawljobCollection.Find(filter).ToList();

			if (isAdminUser())
			{
				//ViewBag.Name = new SelectList(context.Roles.Where(u => !u.Name.Contains("Admin")).ToList(), "Name", "Name");
				if (isAdminUser())
				{
					ViewBag.IsAdminUser = true; 
					return View(links);
				}
				
				else { return View(links); }
			}
			else if (isManagerUser())
			{
				ViewBag.IsManagerUser = true;
				return View(links);
			}
			else if (isViewerUser())
			{
				ViewBag.IsViewerUser = true;
				return View(links);
			}
			else
			{
				return RedirectToAction("UnauthorizedAccess", "Error");
				//return RedirectToAction("UnauthorizedAccess", "Error");
			}

		}

		public Boolean isAdminUser()
		{
			if (User.Identity.IsAuthenticated)
			{
				var user = User.Identity;
				var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
				var s = UserManager.GetRoles(user.GetUserId());
				if (s[0].ToString() == "Admin")
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			return false;
		}

		public Boolean isManagerUser()
		{
			if (User.Identity.IsAuthenticated)
			{
				var user = User.Identity;
				var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
				var s = UserManager.GetRoles(user.GetUserId());
				if (s[0].ToString() == "Manager")
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			return false;
		}

		public Boolean isEmployeeUser()
		{
			if (User.Identity.IsAuthenticated)
			{
				var user = User.Identity;
				var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
				var s = UserManager.GetRoles(user.GetUserId());
				if (s[0].ToString() == "Employee")
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			return false;
		}

		public Boolean isInternUser()
		{
			if (User.Identity.IsAuthenticated)
			{
				var user = User.Identity;
				var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
				var s = UserManager.GetRoles(user.GetUserId());
				if (s[0].ToString() == "Intern")
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			return false;
		}

		public Boolean isViewerUser()
		{
			if (User.Identity.IsAuthenticated)
			{
				var user = User.Identity;
				var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
				var s = UserManager.GetRoles(user.GetUserId());
				if (s[0].ToString() == "Viewer")
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			return false;
		}




		[HttpPost]
		public ActionResult StartCrawl(string url, string depth, string keyword, string collectionName)
		{
			string operationChoice = "1";
			string command = $"ConsoleApp3 \"{operationChoice}\" \"{url}\" \"{depth}\" \"{keyword}\" \"{collectionName}\"";
			string exePath = @"C:\Users\berka\source\repos\ConsoleApp3\ConsoleApp3\bin\Debug\";

			ProcessStartInfo psi = new ProcessStartInfo("cmd.exe", "/k " + exePath + command)
			{
				RedirectStandardOutput = true,
				UseShellExecute = false,
				CreateNoWindow = false
			};

			using (Process process = new Process())
			{
				process.StartInfo = psi;
				process.Start();
				//process.WaitForExit();
			}

			return RedirectToAction("Index");
		}

		





		[HttpPost]
		public ActionResult Delete(string id)
		{
			if (isAdminUser())
			{
				if (string.IsNullOrEmpty(id))
				{
					return HttpNotFound();
				}

				var filter = Builders<CrawljobModel>.Filter.Eq("_id", id);
				var update = Builders<CrawljobModel>.Update.Set("isDeleted", "true");
				jobsCollection.UpdateOne(filter, update);

				return RedirectToAction("Index");
			}
			else if (isManagerUser())
			{
				if (string.IsNullOrEmpty(id))
				{
					return HttpNotFound();
				}

				var filter = Builders<CrawljobModel>.Filter.Eq("_id", id);
				var update = Builders<CrawljobModel>.Update.Set("isDeleted", "true");
				jobsCollection.UpdateOne(filter, update);

				return RedirectToAction("Index");
			}
			else
			{
				// Super admin değilse yetkisiz erişim sayfasına yönlendir
				return RedirectToAction("UnauthorizedAccess", "Error");
			}
			
			
		}

		[HttpPost]
		public ActionResult DeleteLink(string id)
		{
			if (string.IsNullOrEmpty(id))
			{
				return HttpNotFound();
			}

			var filter = Builders<LinksModel>.Filter.Eq("_id", id);
			var update = Builders<LinksModel>.Update.Set("isDeleted", "true");
			_crawljobCollection.UpdateOne(filter, update);


			return RedirectToAction("Details");
		}


		// GET: Crawljob/Create
		public ActionResult Create()
        {
            return View();
        }

        // POST: Crawljob/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Crawljob/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Crawljob/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Crawljob/Delete/5
   
    }
}
