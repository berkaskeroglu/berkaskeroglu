using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNetCore.Http;
using MVCUserRoles.Models;
using System.Transactions;
using Newtonsoft.Json;
using MongoDB.Driver.Core.Configuration;


namespace MVCUserRoles.Controllers
{
	public class CatalogController : Controller
	{
		

		private List<SelectListItem> GetStatusFromDatabase()
		{
			List<SelectListItem> options = new List<SelectListItem>();

			string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;";
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				connection.Open();
				string query = "SELECT status FROM dbo.status";
				using (SqlCommand command = new SqlCommand(query, connection))
				{
					SqlDataReader reader = command.ExecuteReader();
					while (reader.Read())
					{
						string value = reader["status"].ToString();
						options.Add(new SelectListItem { Value = value, Text = value });
					}
				}
			}

			return options;
		}

		private List<SelectListItem> GetCategoriesFromDatabase()
		{
			List<SelectListItem> categories = new List<SelectListItem>();
			string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;";
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				connection.Open();
				string query = "SELECT categories FROM dbo.categories";
				using (SqlCommand command = new SqlCommand(query, connection))
				{
					SqlDataReader reader = command.ExecuteReader();
					while (reader.Read())
					{
						string value = reader["categories"].ToString();
						categories.Add(new SelectListItem { Value = value, Text = value });
					}
				}
			}

			return categories;
		}

		private List<SelectListItem> GetVariationsFromDatabase()
		{
			List<SelectListItem> variationOptions = new List<SelectListItem>();
			string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;";
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				connection.Open();
				string query = "SELECT variation FROM dbo.variationOptions";
				using (SqlCommand command = new SqlCommand(query, connection))
				{
					SqlDataReader reader = command.ExecuteReader();
					while (reader.Read())
					{
						string value = reader["variation"].ToString();
						variationOptions.Add(new SelectListItem { Value = value, Text = value });
					}
				}
			}

			return variationOptions;
		}
		private List<SelectListItem> GetTaxClassesFromDatabase()
		{
			List<SelectListItem> taxClass = new List<SelectListItem>();
			string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;";
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				connection.Open();
				string query = "SELECT taxClass FROM dbo.taxClass";
				using (SqlCommand command = new SqlCommand(query, connection))
				{
					SqlDataReader reader = command.ExecuteReader();
					while (reader.Read())
					{
						string value = reader["taxClass"].ToString();
						taxClass.Add(new SelectListItem { Value = value, Text = value });
					}
				}
			}

			return taxClass;
		}

		public ActionResult Whitelist()
		{
			// Burada whitelist verilerini almanız gerekiyor, örneğin bir veritabanı sorgusu yapabilirsiniz.
			List<string> whitelistData = GetWhitelistDataFromDatabase();

			// JSON formatına dönüştür
			string jsonData = JsonConvert.SerializeObject(whitelistData);

			// JSON sonucunu döndür
			return Content(jsonData, "application/json");
		}

		// Örnek bir veritabanı sorgusu
		private List<string> GetWhitelistDataFromDatabase()
		{
			List<string> tags = new List<string>();
			string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;";
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				connection.Open();
				string query = "SELECT tags FROM dbo.tags";
				using (SqlCommand command = new SqlCommand(query, connection))
				{
					SqlDataReader reader = command.ExecuteReader();
					while (reader.Read())
					{
						string value = reader["tags"].ToString();
						tags.Add(value);
					}
				}
			}
			return tags;
		}

		public ActionResult UploadImage(HttpPostedFileBase file3, HttpPostedFileBase file, string myHiddenValue2, string myHiddenValue, string selectedStatus, string date, CategoryModel2 model, string tags, string product_name, quillModel model2, quillModel2 model3, string base_price, string hiddenDiscountValue, string discount_option, string vat_amount, string sku_number, string tax_class, string fixed_price, string barcode, string quantity_on_shelf, string quantity_in_warehouse, List<Dictionary<string, string>> kt_ecommerce_add_product_options, string meta_title, string meta_keywords, string product_weight, string product_width, string product_height, string product_length, string quantity_allow_backorders = "0", string shipping = "0")
		{
			//log.txt
			List<SelectListItem> options = GetStatusFromDatabase();
			List<SelectListItem> categories = GetCategoriesFromDatabase();
			List<SelectListItem> variationOptions = GetVariationsFromDatabase();
			List<SelectListItem> taxClass = GetTaxClassesFromDatabase();
			ViewBag.Options = options;
			ViewBag.Categories = categories;
			ViewBag.VariationOptions = variationOptions;
			ViewBag.TaxClass = taxClass;
			string quillContent = model2.QuillContent;
			string quillContent2 = model3.QuillContent2;



			if (file != null && file.ContentLength > 0)
			{
				byte[] imageData2 = null;
				using (var binaryReader2 = new BinaryReader(file.InputStream))
				{
					imageData2 = binaryReader2.ReadBytes(file.ContentLength);
				}

				string connectionString2 = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;"; // Veritabanı bağlantı dizesini buraya girin
				using (System.Data.SqlClient.SqlConnection connection2 = new System.Data.SqlClient.SqlConnection(connectionString2))
				{
					connection2.Open();

					string insertQuery = "INSERT INTO dbo.productMedia2 (productMedia) VALUES (@ImageData2)";
					SqlCommand command = new SqlCommand(insertQuery, connection2);


					command.Parameters.AddWithValue("@ImageData2", imageData2);

					command.ExecuteNonQuery();

					connection2.Close();
				}

			}
			else
			{
				ViewBag.Message = "Please select an image.";
			}

			if (file3 != null && file3.ContentLength > 0)
			{
				byte[] imageData = null;

				using (var binaryReader = new BinaryReader(file3.InputStream))
				{
					imageData = binaryReader.ReadBytes(file3.ContentLength);
				}

				string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;"; // Veritabanı bağlantı dizesini buraya girin
				using (System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection(connectionString))
				{
					connection.Open();
					//string selectedCategories = string.Join(",", model.SelectedCategories);
					string selectedCategories = JsonConvert.SerializeObject(model.SelectedCategories);
					List<string> selectedProductOptionsList = new List<string>();
					//string ProductOptionsJson = JsonConvert.(selectedProductOptionsList);
					List<string> productOptionValuesList = new List<string>();
					List<string> SeperatedMetaKeywords = new List<string>();
					SeperatedMetaKeywords = meta_keywords.Split(',').ToList();
					string JsonMetaKeywords = JsonConvert.SerializeObject(SeperatedMetaKeywords);


					Dictionary<string, string> optionsDictionary = new Dictionary<string, string>();
					// Verileri al
					foreach (var option in kt_ecommerce_add_product_options)
					{
						string selectedOption = option["SelectedProductOptions"];
						string productOptionValue = option["ProductOptionValue"];

						optionsDictionary[selectedOption] = productOptionValue;

					}
					string optionsJson = JsonConvert.SerializeObject(optionsDictionary);

					Dictionary<string, string> statusMappings = new Dictionary<string, string>()
					{
						{ "published", "0" },
						{ "draft", "1" },
						{ "scheduled", "2" },
						{ "inactive", "3" }
					};

					string mappedStatus = statusMappings[selectedStatus];

					string insertQuery = "INSERT INTO dbo.product6 (productId, thumbnail, status, date, categories, tags, product_name, base_price, description, discount_type, discount_percentage, vat_amount, sku_number, tax_class, fixed_price, barcode_number, quantity_on_shelf, quantity_in_warehouse, quantity_allow_backorders, meta_tag_description, product_option, shipping, meta_tag_title, meta_tag_keywords, product_weight, product_width, product_height, product_length) VALUES (@productId, @ImageData, @status, @date, @category, @tags, @product_name, @base_price, @quillContent, @discount_type, @discount_percentage, @vat_amount, @sku_number, @tax_class, @fixed_price, @barcode_number, @quantity_on_shelf, @quantity_in_warehouse, @quantity_allow_backorders, @meta_tag_description, @product_option, @shipping, @meta_tag_title, @meta_tag_keywords, @product_weight, @product_width, @product_height, @product_length)";
					SqlCommand command = new SqlCommand(insertQuery, connection);

					command.Parameters.AddWithValue("@productId", myHiddenValue);
					command.Parameters.AddWithValue("@ImageData", imageData);
					command.Parameters.AddWithValue("@status", mappedStatus);
					command.Parameters.AddWithValue("@date", date);
					command.Parameters.AddWithValue("@category", selectedCategories);
					command.Parameters.AddWithValue("@tags", tags);
					command.Parameters.AddWithValue("@product_name", product_name);
					command.Parameters.AddWithValue("@base_price", base_price);
					command.Parameters.AddWithValue("@quillContent", quillContent);
					command.Parameters.AddWithValue("@discount_type", discount_option);
					command.Parameters.AddWithValue("@discount_percentage", hiddenDiscountValue);
					command.Parameters.AddWithValue("@vat_amount", vat_amount);
					command.Parameters.AddWithValue("@sku_number", sku_number);
					command.Parameters.AddWithValue("@tax_class", tax_class);
					command.Parameters.AddWithValue("@fixed_price", fixed_price);
					command.Parameters.AddWithValue("@barcode_number", barcode);
					command.Parameters.AddWithValue("@quantity_on_shelf", quantity_on_shelf);
					command.Parameters.AddWithValue("@quantity_in_warehouse", quantity_in_warehouse);
					command.Parameters.AddWithValue("@quantity_allow_backorders", quantity_allow_backorders);
					command.Parameters.AddWithValue("@meta_tag_description", quillContent2);
					command.Parameters.AddWithValue("@product_option", optionsJson);
					//command.Parameters.AddWithValue("@product_option_value", productOptionValueString);
					command.Parameters.AddWithValue("@shipping", shipping);
					command.Parameters.AddWithValue("@meta_tag_title", meta_title);
					command.Parameters.AddWithValue("@meta_tag_keywords", JsonMetaKeywords);
					command.Parameters.AddWithValue("@product_weight", product_weight);
					command.Parameters.AddWithValue("@product_width", product_width);
					command.Parameters.AddWithValue("@product_height", product_height);
					command.Parameters.AddWithValue("@product_length", product_length);

					// Sorguyu çalıştır
					command.ExecuteNonQuery();

					// Bağlantıyı kapat
					connection.Close();
					connection.Open();
					string updateQuery = "UPDATE dbo.productMedia2 SET productId = '" + myHiddenValue + "' WHERE productId IS NULL OR productId = '';";
					SqlCommand command2 = new SqlCommand(updateQuery, connection);
					command2.ExecuteNonQuery();
					connection.Close();
				}

				ViewBag.Message = "Image uploaded successfully!";
			}
			else
			{
				ViewBag.Message = "Please select an image.";
			}

			return View();

		}

		public ActionResult EditProduct(string id = "3c85a7e0-3178-4b4d-945e-f1999b25fb2b")
		{
			List<string> photoList = new List<string>();
			
			string query = "SELECT * FROM dbo.product6 WHERE productID = @productId";
			string query2 = "SELECT * FROM dbo.productMedia2 WHERE productId = @productId";

			string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;";
			
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				SqlCommand command = new SqlCommand(query, connection);
				command.Parameters.AddWithValue("@productId", id);

				connection.Open();
				SqlDataReader reader = command.ExecuteReader();

				if (reader.Read())
				{
					// Veritabanından gelen verileri modelle eşleştirme
					ProductViewModel model = new ProductViewModel();
					model.productId = reader["productId"].ToString();
					model.status = reader["status"].ToString();

					
					byte[] imageData = (byte[])reader["thumbnail"];
					model.thumbnail = Convert.ToBase64String(imageData);

					model.date = reader["date"].ToString();
					//model.categories = reader["categories"].ToString();
					string jsonCategories = reader["categories"].ToString();
					List<string> categoriesList = JsonConvert.DeserializeObject<List<string>>(jsonCategories);

					model.SelectedCategories = categoriesList;

					List<SelectListItem> allCategories = new List<SelectListItem>
					{
						new SelectListItem { Text = "Computers", Value = "computers" },
						new SelectListItem { Text = "Watches", Value = "watches" },
						new SelectListItem { Text = "Headphones", Value = "headphones" },
						new SelectListItem { Text = "Footwear", Value = "footwear" },
						new SelectListItem { Text = "Cameras", Value = "cameras" },
						new SelectListItem { Text = "Shirts", Value = "shirts" },
						new SelectListItem { Text = "Household", Value = "household" },
						new SelectListItem { Text = "Handbags", Value = "handbags" },
						new SelectListItem { Text = "Sandals", Value = "sandals" },
						new SelectListItem { Text = "Wines", Value = "wines" }
					};

					foreach (var category in allCategories)
					{
						if (model.SelectedCategories.Contains(category.Value))
						{
							category.Selected = true;
						}
					}

					ViewBag.AllCategories = allCategories;

					string jsonTags = reader["tags"].ToString();
					List<Tag> tagsList = JsonConvert.DeserializeObject<List<Tag>>(jsonTags);

					// Tag sınıfının değerlerini string listesine dönüştürme
					model.Tags = tagsList.Select(tag => tag.Value).ToList();

					// Tag tipi bir sınıf tanımlayın

					model.product_name = reader["product_name"].ToString();
					model.description = reader["description"].ToString();
					model.base_price = reader["base_price"].ToString();
					model.discount_type = reader["discount_type"].ToString();
					model.tax_class = reader["tax_class"].ToString();
					model.vat_amount = reader["vat_amount"].ToString();
					model.discount_percentage = reader["discount_percentage"].ToString();
					model.fixed_price = reader["fixed_price"].ToString();
					model.sku_number = reader["sku_number"].ToString();
					model.barcode_number = reader["barcode_number"].ToString();
					model.quantity_on_shelf = reader["quantity_on_shelf"].ToString();
					model.quantity_in_warehouse = reader["quantity_in_warehouse"].ToString();
					model.quantity_allow_backorders = reader["quantity_allow_backorders"].ToString();
					model.shipping = reader["shipping"].ToString();
					model.product_weight = reader["product_weight"].ToString();
					model.product_width = reader["product_width"].ToString();
					model.product_height = reader["product_height"].ToString();
					model.product_length = reader["product_length"].ToString();
					model.product_option = reader["product_option"].ToString();
					model.product_option_value = reader["product_option_value"].ToString();
					model.meta_tag_title = reader["meta_tag_title"].ToString();
					model.meta_tag_description = reader["meta_tag_description"].ToString();

					string jsonTagKeywords = reader["meta_tag_keywords"].ToString();
					string[] tagKeywordsArray = JsonConvert.DeserializeObject<string[]>(jsonTagKeywords);
					string tagString = string.Join(",", tagKeywordsArray);
					model.meta_tag_keywords = tagString;


					// Diğer alanları da burada eşleştirebilirsiniz
					//connection.Close();

						reader.Close();

						SqlCommand command2 = new SqlCommand(query2, connection);
						command2.Parameters.AddWithValue("@productId", id);
						
						//connection2.Open();
						using (SqlDataReader reader3 = command2.ExecuteReader())
						{
							while (reader3.Read())
							{
								byte[] photoData = (byte[])reader3["productMedia"];
								string base64String = Convert.ToBase64String(photoData);
								string photoUrl = "data:image/jpeg;base64," + base64String;
								photoList.Add(photoUrl);
							}
						}

						model.productMedia = photoList;

					
					return View(model);
				}
				else
				{
					// Ürün bulunamadıysa hata sayfasına yönlendirme veya başka bir işlem yapma
					return HttpNotFound();
				}
			}
		}
		public class Tag
		{
			public string Value { get; set; }
		}

		
		public JsonResult GetProductPhotos(string id = "118dcd3e-617f-4b20-a4d7-0f5faedff7b1")
		{
			string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;";

			List<string> photoList = new List<string>();
			string query2 = "SELECT * FROM dbo.productMedia2 WHERE productId = @productId";

			using (SqlConnection connection2 = new SqlConnection(connectionString))
			{
				SqlCommand command2 = new SqlCommand(query2, connection2);
				command2.Parameters.AddWithValue("@productId", id);

				connection2.Open();
				SqlDataReader reader3 = command2.ExecuteReader();

				while (reader3.Read())
				{
					byte[] photoData = (byte[])reader3["productMedia"];
					string base64String = Convert.ToBase64String(photoData);
					string photoUrl = "data:image/jpeg;base64," + base64String;
					photoList.Add(photoUrl);
				}
				connection2.Close();
			}

			return Json(photoList, JsonRequestBehavior.AllowGet);
		}

		public ActionResult EditProductAction(HttpPostedFileBase file3, HttpPostedFileBase file, string myHiddenValue, string myHiddenValue2, string selectedStatus, string date, CategoryModel2 model, string tags, string product_name, quillModel model2, quillModel2 model3, string base_price, string hiddenDiscountValue, string discount_option, string vat_amount, string sku_number, string tax_class, string fixed_price, string barcode, string quantity_on_shelf, string quantity_in_warehouse, List<Dictionary<string, string>> kt_ecommerce_add_product_options, string meta_title, string meta_keywords, string product_weight, string product_width, string product_height, string product_length, string quantity_allow_backorders = "0", string shipping = "0")
		{
			string quillContent = model2.QuillContent;
			string quillContent2 = model3.QuillContent2;
			
			
			string productId = myHiddenValue;
			if (file != null && file.ContentLength > 0)
			{
				byte[] imageData2 = null;
				using (var binaryReader2 = new BinaryReader(file.InputStream))
				{
					imageData2 = binaryReader2.ReadBytes(file.ContentLength);
				}

				string connectionString2 = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;"; // Veritabanı bağlantı dizesini buraya girin
				using (System.Data.SqlClient.SqlConnection connection2 = new System.Data.SqlClient.SqlConnection(connectionString2))
				{
					connection2.Open();

					string insertQuery = "UPDATE dbo.productMedia2 SET productMedia = @ImageData2 WHERE productId = @productId";
					SqlCommand command = new SqlCommand(insertQuery, connection2);

					command.Parameters.AddWithValue("@productId", productId);
					command.Parameters.AddWithValue("@ImageData2", imageData2);
					


					command.ExecuteNonQuery();
					ViewBag.Message = "Image uploaded successfully!";
					connection2.Close();
				}

			}
			else
			{
				ViewBag.Message = "Please select an image.";
			}

			if (file3 != null && file3.ContentLength > 0)
			{
				byte[] imageData = null;
				
				using (var binaryReader = new BinaryReader(file3.InputStream))
				{
					imageData = binaryReader.ReadBytes(file3.ContentLength);
				}

				string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;"; // Veritabanı bağlantı dizesini buraya girin
				using (System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection(connectionString))
				{
					connection.Open();
					//string selectedCategories = string.Join(",", model.SelectedCategories);
					string selectedCategories = JsonConvert.SerializeObject(model.SelectedCategories);
					List<string> selectedProductOptionsList = new List<string>();
					//string ProductOptionsJson = JsonConvert.(selectedProductOptionsList);
					List<string> productOptionValuesList = new List<string>();
					List<string> SeperatedMetaKeywords = new List<string>();
					SeperatedMetaKeywords = meta_keywords.Split(',').ToList();
					string JsonMetaKeywords = JsonConvert.SerializeObject(SeperatedMetaKeywords);


					Dictionary<string, string> optionsDictionary = new Dictionary<string, string>();
					// Verileri al
					foreach (var option in kt_ecommerce_add_product_options)
					{
						string selectedOption = option["SelectedProductOptions"];
						string productOptionValue = option["ProductOptionValue"];

						optionsDictionary[selectedOption] = productOptionValue;

					}
					string optionsJson = JsonConvert.SerializeObject(optionsDictionary);

					Dictionary<string, string> statusMappings = new Dictionary<string, string>()
					{
						{ "published", "0" },
						{ "draft", "1" },
						{ "scheduled", "2" },
						{ "inactive", "3" }
					};

					string mappedStatus = statusMappings[selectedStatus];

					string insertQuery = "UPDATE dbo.product6 SET thumbnail = @ImageData, status = @status, date = @date, categories = @category, tags = @tags, product_name = @product_name, base_price = @base_price, description = @quillContent, discount_type = @discount_type, discount_percentage = @discount_percentage, vat_amount = @vat_amount, sku_number = @sku_number, tax_class = @tax_class, fixed_price = @fixed_price, barcode_number = @barcode_number, quantity_on_shelf = @quantity_on_shelf, quantity_in_warehouse = @quantity_in_warehouse, quantity_allow_backorders = @quantity_allow_backorders, meta_tag_description = @meta_tag_description, product_option = @product_option, shipping = @shipping, meta_tag_title = @meta_tag_title, meta_tag_keywords = @meta_tag_keywords, product_weight = @product_weight, product_width = @product_width, product_height = @product_height, product_length = @product_length WHERE productId = @productId";
					SqlCommand command = new SqlCommand(insertQuery, connection);

					command.Parameters.AddWithValue("@productId", productId);
					command.Parameters.AddWithValue("@ImageData", imageData);
					command.Parameters.AddWithValue("@status", mappedStatus);
					command.Parameters.AddWithValue("@date", date);
					command.Parameters.AddWithValue("@category", selectedCategories);
					command.Parameters.AddWithValue("@tags", tags);
					command.Parameters.AddWithValue("@product_name", product_name);
					command.Parameters.AddWithValue("@base_price", base_price);
					command.Parameters.AddWithValue("@quillContent", quillContent);
					command.Parameters.AddWithValue("@discount_type", discount_option);
					command.Parameters.AddWithValue("@discount_percentage", hiddenDiscountValue);
					command.Parameters.AddWithValue("@vat_amount", vat_amount);
					command.Parameters.AddWithValue("@sku_number", sku_number);
					command.Parameters.AddWithValue("@tax_class", tax_class);
					command.Parameters.AddWithValue("@fixed_price", fixed_price);
					command.Parameters.AddWithValue("@barcode_number", barcode);
					command.Parameters.AddWithValue("@quantity_on_shelf", quantity_on_shelf);
					command.Parameters.AddWithValue("@quantity_in_warehouse", quantity_in_warehouse);
					command.Parameters.AddWithValue("@quantity_allow_backorders", quantity_allow_backorders);
					command.Parameters.AddWithValue("@meta_tag_description", quillContent2);
					command.Parameters.AddWithValue("@product_option", optionsJson);
					//command.Parameters.AddWithValue("@product_option_value", productOptionValueString);
					command.Parameters.AddWithValue("@shipping", shipping);
					command.Parameters.AddWithValue("@meta_tag_title", meta_title);
					command.Parameters.AddWithValue("@meta_tag_keywords", JsonMetaKeywords);
					command.Parameters.AddWithValue("@product_weight", product_weight);
					command.Parameters.AddWithValue("@product_width", product_width);
					command.Parameters.AddWithValue("@product_height", product_height);
					command.Parameters.AddWithValue("@product_length", product_length);

					// Sorguyu çalıştır
					command.ExecuteNonQuery();

					// Bağlantıyı kapat
					connection.Close();
					
				}

				ViewBag.Message = "Image uploaded successfully!";
			}
			else
			{
				ViewBag.Message = "Please select an image.";
			}

			return RedirectToAction("EditProduct", "Catalog");
		}

		

		public ActionResult UploadImage2(HttpPostedFileBase file3, HttpPostedFileBase file, string existing_thumbnail, string myHiddenValue2, string myHiddenValue, string selectedStatus, string date, CategoryModel2 model, string tags, string product_name, quillModel model2, quillModel2 model3, string base_price, string hiddenDiscountValue, string discount_option, string vat_amount, string sku_number, string tax_class, string fixed_price, string barcode, string quantity_on_shelf, string quantity_in_warehouse, List<Dictionary<string, string>> kt_ecommerce_add_product_options, string meta_title, string meta_keywords, string product_weight, string product_width, string product_height, string product_length, string quantity_allow_backorders = "0", string shipping = "0")
		{
			string quillContent = model2.QuillContent;
			string quillContent2 = model3.QuillContent2;
			string productId = myHiddenValue;

			

			if (1 > 0) // test
			{
				byte[] imageData = null;

				if (file3 != null && file3.ContentLength > 0)
				{
					using (var binaryReader = new BinaryReader(file3.InputStream))
					{
						imageData = binaryReader.ReadBytes(file3.ContentLength);
					}
				}
				else
				{
				
					imageData = Convert.FromBase64String(existing_thumbnail);
				}

				string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;"; // Veritabanı bağlantı dizesini buraya girin
				using (System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection(connectionString))
				{
					connection.Open();
					string selectedCategories = JsonConvert.SerializeObject(model.SelectedCategories);
					List<string> SeperatedMetaKeywords = meta_keywords.Split(',').ToList();
					string JsonMetaKeywords = JsonConvert.SerializeObject(SeperatedMetaKeywords);

					Dictionary<string, string> optionsDictionary = new Dictionary<string, string>();
					foreach (var option in kt_ecommerce_add_product_options)
					{
						string selectedOption = option["SelectedProductOptions"];
						string productOptionValue = option["ProductOptionValue"];

						optionsDictionary[selectedOption] = productOptionValue;
					}
					string optionsJson = JsonConvert.SerializeObject(optionsDictionary);

					Dictionary<string, string> statusMappings = new Dictionary<string, string>()
					{
						{ "published", "0" },
						{ "draft", "1" },
						{ "scheduled", "2" },
						{ "inactive", "3" }
					};

					string mappedStatus = statusMappings[selectedStatus];

					string updateQuery = "UPDATE dbo.product6 SET thumbnail = @ImageData, status = @status, date = @date, categories = @category, tags = @tags, product_name = @product_name, base_price = @base_price, description = @quillContent, discount_type = @discount_type, discount_percentage = @discount_percentage, vat_amount = @vat_amount, sku_number = @sku_number, tax_class = @tax_class, fixed_price = @fixed_price, barcode_number = @barcode_number, quantity_on_shelf = @quantity_on_shelf, quantity_in_warehouse = @quantity_in_warehouse, quantity_allow_backorders = @quantity_allow_backorders, meta_tag_description = @meta_tag_description, product_option = @product_option, shipping = @shipping, meta_tag_title = @meta_tag_title, meta_tag_keywords = @meta_tag_keywords, product_weight = @product_weight, product_width = @product_width, product_height = @product_height, product_length = @product_length WHERE productId = @productId";
					SqlCommand command = new SqlCommand(updateQuery, connection);

					command.Parameters.AddWithValue("@productId", productId);
					command.Parameters.AddWithValue("@ImageData", imageData);
					command.Parameters.AddWithValue("@status", mappedStatus);
					command.Parameters.AddWithValue("@date", date);
					command.Parameters.AddWithValue("@category", selectedCategories);
					command.Parameters.AddWithValue("@tags", tags);
					command.Parameters.AddWithValue("@product_name", product_name);
					command.Parameters.AddWithValue("@base_price", base_price);
					command.Parameters.AddWithValue("@quillContent", quillContent);
					command.Parameters.AddWithValue("@discount_type", discount_option);
					command.Parameters.AddWithValue("@discount_percentage", hiddenDiscountValue);
					command.Parameters.AddWithValue("@vat_amount", vat_amount);
					command.Parameters.AddWithValue("@sku_number", sku_number);
					command.Parameters.AddWithValue("@tax_class", tax_class);
					command.Parameters.AddWithValue("@fixed_price", fixed_price);
					command.Parameters.AddWithValue("@barcode_number", barcode);
					command.Parameters.AddWithValue("@quantity_on_shelf", quantity_on_shelf);
					command.Parameters.AddWithValue("@quantity_in_warehouse", quantity_in_warehouse);
					command.Parameters.AddWithValue("@quantity_allow_backorders", quantity_allow_backorders);
					command.Parameters.AddWithValue("@meta_tag_description", quillContent2);
					command.Parameters.AddWithValue("@product_option", optionsJson);
					command.Parameters.AddWithValue("@shipping", shipping);
					command.Parameters.AddWithValue("@meta_tag_title", meta_title);
					command.Parameters.AddWithValue("@meta_tag_keywords", JsonMetaKeywords);
					command.Parameters.AddWithValue("@product_weight", product_weight);
					command.Parameters.AddWithValue("@product_width", product_width);
					command.Parameters.AddWithValue("@product_height", product_height);
					command.Parameters.AddWithValue("@product_length", product_length);

					command.ExecuteNonQuery();

					connection.Close();
				}

				ViewBag.Message = "Image uploaded and product updated successfully!";
			}
			else
			{
				ViewBag.Message = "Please select an image.";
			}

			if (file != null && file.ContentLength > 0)
			{
				byte[] imageData2 = null;
				using (var binaryReader2 = new BinaryReader(file.InputStream))
				{
					imageData2 = binaryReader2.ReadBytes(file.ContentLength);
				}

				string connectionString2 = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;"; // Veritabanı bağlantı dizesini buraya girin
				using (System.Data.SqlClient.SqlConnection connection2 = new System.Data.SqlClient.SqlConnection(connectionString2))
				{
					connection2.Open();


					string deleteQuery = "DELETE FROM dbo.productMedia2 WHERE productId = @productId";
					SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection2);
					deleteCommand.Parameters.AddWithValue("@productId", productId);
					deleteCommand.ExecuteNonQuery();


					string insertQuery = "INSERT INTO dbo.productMedia2 (productId, productMedia) VALUES (@productId, @ImageData2)";
					SqlCommand insertCommand = new SqlCommand(insertQuery, connection2);
					insertCommand.Parameters.AddWithValue("@ImageData2", imageData2);
					insertCommand.Parameters.AddWithValue("@productId", productId);
					insertCommand.ExecuteNonQuery();

					connection2.Close();
				}
			}
			else
			{
				ViewBag.Message = "Please select an image.";
			}

			return RedirectToAction("EditProduct", "Catalog");
		}


		public ActionResult UploadImage3(string selectedStatus, string id = "118dcd3e-617f-4b20-a4d7-0f5faedff7b1")
		{
			string connectionString2 = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;"; // Veritabanı bağlantı dizesini buraya girin
			using (System.Data.SqlClient.SqlConnection connection2 = new System.Data.SqlClient.SqlConnection(connectionString2))
			{
				connection2.Open();

				string productId2 = id;
				string insertQuery = "INSERT INTO dbo.product7 (productId, status) VALUES (@productId2, @status)";
				SqlCommand command = new SqlCommand(insertQuery, connection2);


				command.Parameters.AddWithValue("@productId2", productId2);
				command.Parameters.AddWithValue("@status", selectedStatus);


				command.ExecuteNonQuery();

				connection2.Close();
			}


			return View();
		}

	
	}
}