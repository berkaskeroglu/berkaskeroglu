using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MVCUserRoles.Models
{
	public class ProductModel
	{
		public int Id { get; set; }

		[Required]
		public string Name { get; set; }


		public byte[] ImageData { get; set; } // Resim dosyasının byte dizisi olarak saklanması
	}

	public class OptionModel
	{
		public string Value { get; set; }
		public string Text { get; set; }
	}

	public class CategoryModel
	{
		public string Value { get; set; }
		public string Text { get; set; }
	}

	public class CategoryModel2
	{
		public List<string> SelectedCategories { get; set; }
	}

	public class thumbnailClass
	{
		public HttpPostedFileBase File3 { get; set; }
		public string FileType { get; set; }
	}

    public class  quillModel
    {
		[AllowHtml]
        public string QuillContent { get; set; }
    }
	public class quillModel2
	{
		[AllowHtml]
		public string QuillContent2 { get; set; }
	}
	public class VariationModel
	{
		public string SelectedProductOptions { get; set; }
		public string ProductOptionValue { get; set; }
	}

	public class ProductViewModel
	{
		public string productId { get; set; }
		public string status { get; set; }
		public string date { get; set; }
		public List<string> categories { get; set; }
		public List<string> SelectedCategories { get; set; }
		public string tags { get; set; }
		public List<string> Tags { get; set; }
		public List<string> TagKeywords { get; set; }
		public List<string> productMedia { get; set; }
		public string thumbnail { get; set; }
		public string product_name { get; set; }
		public string description { get; set; }
		public string base_price { get; set; }

		public string discount_type { get; set; }
		public string tax_class { get; set; }
		public string vat_amount { get; set; }
		public string discount_percentage { get; set; }
		public string fixed_price { get; set; }
		public string sku_number { get; set; }
		public string barcode_number { get; set; }
		public string quantity_on_shelf { get; set; }
		public string quantity_in_warehouse { get; set; }
		public string quantity_allow_backorders { get; set; }
		public string shipping { get; set; }
		public string product_weight { get; set; }
		public string product_width { get; set; }
		public string product_height { get; set; }

		public string product_length { get; set; }
		public string product_option { get; set; }
		public string product_option_value { get; set; }
		public string meta_tag_title { get; set; }
		public string meta_tag_description { get; set; }
		public string meta_tag_keywords { get; set; }
		// Diğer özellikler buraya eklenebilir
	}

}