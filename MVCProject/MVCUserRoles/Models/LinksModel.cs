using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MVCUserRoles.Models
{
	public class LinksModel
	{
		[BsonId]
		[BsonRepresentation(BsonType.ObjectId)]
		//[BsonElement("_id")]
		public string LinkId { get; set; }

		[BsonElement("url")]
		public string LinkUrl { get; set; }
		[BsonElement("parentId")]
		public string LinkParentId { get; set; }

		[BsonElement("childLinks")]
		public List<string> ChildLinks { get; set; }
		[BsonElement("label")] // MongoDB'deki alan adıyla eşleşen belirteç
		public string LinkLabel { get; set; }
		[BsonElement("mainId")]
		public string MainId { get; set; }
		[BsonElement("isDeleted")]
		public string IsDeleted { get; set; }
	}
}