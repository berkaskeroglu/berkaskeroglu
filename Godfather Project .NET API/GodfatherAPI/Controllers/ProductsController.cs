using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;



[Route("api/[controller]")]
[ApiController]
public class ShopController : ControllerBase
{
	private readonly string _connectionString = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=Database1;Integrated Security=True;Connect Timeout=30;Encrypt=False;";

	[HttpGet("products")]
	public IActionResult GetProducts()
	{
		var products = new List<object>();

		using (var connection = new SqlConnection(_connectionString))
		{
			connection.Open();
			var query = @"SELECT product_id, name, price, info, stock FROM dbo.ShopProduct";

			using (var command = new SqlCommand(query, connection))
			{
				using (var reader = command.ExecuteReader())
				{
					while (reader.Read())
					{
						var product = new
						{
							ProductId = reader["product_id"],
							Name = reader["name"],
							Info = reader["info"],
							Price = reader["price"],
							Stock = reader["stock"]
						};

						products.Add(product);
					}
				}
			}
		}

		return Ok(products);
	}

	[HttpGet("images")]
	public IActionResult GetImages()
	{
		var images = new List<object>();

		using (var connection = new SqlConnection(_connectionString))
		{
			connection.Open();
			var query = @"SELECT product_id, image FROM dbo.ShopImages";

			using (var command = new SqlCommand(query, connection))
			{
				using (var reader = command.ExecuteReader())
				{
					while (reader.Read())
					{
						var image = new
						{
							ProductId = reader["product_id"],
							Image = reader["image"]
						};

						images.Add(image);
					}
				}
			}
		}

		return Ok(images);
	}

	[HttpGet("stars")]
	public IActionResult GetStars()
	{
		var stars = new List<object>();

		using (var connection = new SqlConnection(_connectionString))
		{
			connection.Open();
			var query = @"SELECT product_id, star FROM dbo.ShopComments";

			using (var command = new SqlCommand(query, connection))
			{
				using (var reader = command.ExecuteReader())
				{
					while (reader.Read())
					{
						var star = new
						{
							ProductId = reader["product_id"],
							Star = reader["star"]
						};

						stars.Add(star);
					}
				}
			}
		}

		return Ok(stars);
	}

	[HttpGet("comments")]
	public IActionResult GetComments(string id)
	{
		var comments = new List<object>();

		using (var connection = new SqlConnection(_connectionString))
		{
			connection.Open();
			var query = @"SELECT comment_id, star, comment FROM dbo.ShopComments WHERE product_id = @ProductId";

			using (var command = new SqlCommand(query, connection))
			{
				command.Parameters.AddWithValue("@ProductId", id);
				using (var reader = command.ExecuteReader())
				{
					while (reader.Read())
					{
						var comment = new
						{
							Id = reader["comment_id"],
							Star = reader["star"],
							Comment = reader["comment"]
						};

						comments.Add(comment);
					}
				}
			}
		}

		return Ok(comments);
	}
}

