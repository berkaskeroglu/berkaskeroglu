using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Text;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddHostedService<InvoiceService>();
builder.Services.AddControllers();
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
app.MapGet("/", () => "Invoice Service Running");

app.Run();

public class InvoiceService : BackgroundService
{
	protected override Task ExecuteAsync(CancellationToken stoppingToken)
	{
		var factory = new ConnectionFactory() { HostName = "localhost" };
		var connection = factory.CreateConnection();
		var channel = connection.CreateModel();

		channel.QueueDeclare(queue: "invoiceQueue",
							 durable: false,
							 exclusive: false,
							 autoDelete: false,
							 arguments: null);

		var consumer = new EventingBasicConsumer(channel);// creates a new consumer
		consumer.Received += (model, ea) =>  // gets triggered when a message is received from queue
		{
			var body = ea.Body.ToArray();
			var message = Encoding.UTF8.GetString(body);
			var order = JsonSerializer.Deserialize<Order>(message);

			Console.WriteLine($"Invoice created for Order ID: {order.OrderId}");
		};

		channel.BasicConsume(queue: "invoiceQueue",
							 autoAck: true,  // automotically sends 
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
