using Microsoft.AspNetCore.Mvc;
using NetMQ;
using NetMQ.Sockets;
using Newtonsoft.Json;

namespace OrderAPI.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class OrderController : Controller
	{
		[HttpPost]
		public IActionResult PlaceOrder([FromBody] Order order) 
		{
			using (var pushSocket = new PushSocket()) 
			{
				pushSocket.Connect("tcp://localhost:5555");
				pushSocket.SendFrame(JsonConvert.SerializeObject(order));
			}

			return Ok("Order placed successfully");
		}
	}
}

public class Order
{
	public int OrderId { get; set; }
	public string ProductName { get; set; }
	public int Quantity { get; set; }
	public decimal Price { get; set; }
}
