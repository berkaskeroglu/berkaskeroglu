using Microsoft.AspNetCore.Mvc;
using RabbitMQ.Client;
using System.Text;
using System.Text.Json;

namespace OrderService.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class OrderController : Controller
	{
		[HttpPost]
		public IActionResult CreateOrder([FromBody] Order order)
		{
			var factory = new ConnectionFactory() { HostName = "localhost" };
			using var connection = factory.CreateConnection();
			using var channel = connection.CreateModel();

			channel.QueueDeclare(queue: "orderQueue",
								 durable: false,
								 exclusive: false,
								 autoDelete: false,
								 arguments: null 
			);

			var orderJson = JsonSerializer.Serialize(order);
			var body = Encoding.UTF8.GetBytes(orderJson);

			channel.BasicPublish( exchange: "",
								  routingKey: "orderQueue",
								  basicProperties: null,
								  body: body
			);

			return Ok("Order created and sent to queue.");
		
		
		}
	}

	public class Order
	{
		public int OrderId { get; set; }
		public string ProductName { get; set; }
		public int Quantity { get; set; }
		public decimal Price { get; set; }
	}
}
