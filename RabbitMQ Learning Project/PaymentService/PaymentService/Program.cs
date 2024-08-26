using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Text;
using System.Text.Json;


var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddHostedService<PaymentService>();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
	app.UseSwagger();
	app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
app.MapGet("/", () => "Payment Service Running");

app.Run();

public class PaymentService : BackgroundService
{
	protected override Task ExecuteAsync(CancellationToken stoppingToken)
	{
		var factory = new ConnectionFactory() { HostName = "localhost" };
		var connection = factory.CreateConnection();
		var channel = connection.CreateModel();

		channel.QueueDeclare(queue: "orderQueue",
							 durable: false,
							 exclusive: false,
							 autoDelete: false,
							 arguments: null);

		var consumer = new EventingBasicConsumer(channel); // defines a consumer that listens to events
		consumer.Received += (model, ea) =>   // defines what will happen when the message is received
		{
			var body = ea.Body.ToArray();  // gets the body
			var message = Encoding.UTF8.GetString(body);   
			var order = JsonSerializer.Deserialize<Order>(message);

			Console.WriteLine($"Processing payment for Order ID: {order.OrderId}");

			var invoiceFactory = new ConnectionFactory() { HostName = "localhost" }; // creates a second RabbitMQ connection and channel for invoice stuff
			using var invoiceConnection = invoiceFactory.CreateConnection();
			using var invoiceChannel = invoiceConnection.CreateModel();

			invoiceChannel.QueueDeclare(queue: "invoiceQueue",
										durable: false,
										exclusive: false,
										autoDelete: false,
										arguments: null);

			var invoiceJson = JsonSerializer.Serialize(order);
			var invoiceBody = Encoding.UTF8.GetBytes(invoiceJson);

			invoiceChannel.BasicPublish(exchange: "",
										routingKey: "invoiceQueue",
										basicProperties: null,
										body: invoiceBody);
		};

		channel.BasicConsume(queue: "orderQueue",
							 autoAck: true,
							 consumer: consumer);

		return Task.CompletedTask;
	}

}

public class Order
{
	public int OrderId { get; set; }
	public string ProductName { get; set; }
	public int Quantity { get; set; }
	public decimal Price { get; set; }
}
