using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;

namespace MVCUserRoles.Models
{

	public class CrawljobModel
	{
		[BsonId]
		[BsonRepresentation(BsonType.ObjectId)]
		//[BsonElement("_id")]
		public string CrawlJobId { get; set; }

		[BsonElement("url")]
		public string CrawljobUrl { get; set; }

		[BsonElement("status")]
		public string CrawljobStatus { get; set; }

		[BsonElement("isDeleted")]
		public bool IsDeleted { get; set; } // Yeni alan
	}


	

}