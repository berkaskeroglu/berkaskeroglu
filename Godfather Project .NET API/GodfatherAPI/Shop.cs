using System.ComponentModel.DataAnnotations;


public class ShopProduct
{
	[Key]
	public int ProductId { get; set; }
	public string Name { get; set; }
	public string Info { get; set; }
	public decimal Price { get; set; }
	public int Stock { get; set; }
	public ICollection<ShopImage> Images { get; set; } = new List<ShopImage>();
	public ICollection<ShopComment> Comments { get; set; } = new List<ShopComment>();
}

public class ShopImage
{
	[Key]
	public int ImageId { get; set; }
	public int ProductId { get; set; }
	public string Image { get; set; }
	public ShopProduct Product { get; set; }
}

public class ShopComment
{
	[Key]
	public int CommentId { get; set; }
	public int ProductId { get; set; }
	public string Comment { get; set; }
	public int Star { get; set; }
	public ShopProduct Product { get; set; }

}
