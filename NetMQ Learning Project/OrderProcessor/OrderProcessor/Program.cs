using NetMQ;
using NetMQ.Sockets;
using Newtonsoft.Json;

class Program
{
	static void Main(string[] args)
	{
		using (var pullSocket = new PullSocket())
		{
			pullSocket.Bind("tcp://localhost:5555");

			while (true)
			{
				var message = pullSocket.ReceiveFrameString();
				var order = JsonConvert.DeserializeObject<Order>(message);

				Console.WriteLine($"Processing Order: {order.OrderId}, Product: {order.ProductName}");

				using (var pushSocket = new PushSocket())
				{
					pushSocket.Connect("tcp://localhost:5556");
					pushSocket.SendFrame(JsonConvert.SerializeObject(order));
				}
			}
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