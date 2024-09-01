<script>
    import { onMount } from "svelte";
    import { cartCount } from '../shop/cartStore';
    let currentImageIndex = 0;
    let products = [];
    let images = [];
  //  $: imageSrc = images[currentImageIndex];
    let stars = [];
    let isDataLoaded = false;
    let imageIndices = {};
    let currentImageSrc = {};
    
    function addToCart() {
        cartCount.update(n => n + 1);
    }

   // let imageSrc = images[currentImageIndex];

    function showImage(productId, index) {
        let productImages = getProductImages(productId);
        if (index < 0) index = productImages.length - 1;
        if (index >= productImages.length) index = 0;
        imageIndices[productId] = index;

        imageIndices = { ...imageIndices, [productId]: index };
        currentImageSrc[productId] = getCurrentImage(productId);
        console.log("Current image URL:", getCurrentImage(productId));
    }

    function getProductImages(productId) {
        return images.filter(img => img.productId === productId).map(img => img.image);
    }

    function nextImage(productId) {
        showImage(productId, ((imageIndices[productId] || 0) + 1));
        console.log("Next image.. Index:", imageIndices[productId]);
    }

    function prevImage(productId) {
        showImage(productId, ((imageIndices[productId] || 0) - 1));
        console.log("Previous image.. Index:", imageIndices[productId]);
    }

    function getCurrentImage(productId) {
        const productImages = getProductImages(productId);
        return productImages[imageIndices[productId]] || productImages[0];
    }

    onMount(async () => {
    try {
        const resProducts = await fetch('https://localhost:7071/api/Shop/products', {
            headers: {
                'Accept': 'application/json'
            }
        });

        if (resProducts.ok) {
            const productsData = await resProducts.json();
            products = productsData;
        } else {
            console.error('Failed to fetch products:', resProducts.statusText);
        }

        const resImages = await fetch('https://localhost:7071/api/Shop/images');
        images = await resImages.json();
        console.log("HERE ARE", images);

        const resStars = await fetch('https://localhost:7071/api/Shop/stars', {
            headers: {
                'Accept': 'application/json'
            }
        });
        stars = await resStars.json();
        console.log(stars);
        products.forEach(product => {
                imageIndices[product.productId] = 0;
                currentImageSrc[product.productId] = getCurrentImage(product.productId);
            });
        isDataLoaded = true;
        } catch (error) {
        console.error('Error fetching data:', error);
        }
    });


    


    function getProductRating(productId) {
        console.log("STAR SAYISI:", stars.length, stars);
        if (stars.length === 0) return 0;
        
        const productStars = stars.filter(star => star.productId === productId);
        console.log("product stars:", productStars);
        const totalStars = productStars.reduce((acc, curr) => {
            console.log(curr.star);
            const starValue = Number(curr.star);
            if (isNaN(starValue)) {
                console.error("Invalid star value:", curr.star);
                return acc;
            }
            return acc + starValue;
        }, 0);

        console.log("total stars:", totalStars);
        if (productStars.length === 0) return 0;
        
        return (totalStars / productStars.length) || 0;
}
</script>


{#if isDataLoaded}
    <div class="product-container">
        {#each products as product (product.productId)}
            <div class="product-item">
                <div class="product-image-container">
                    <img src={currentImageSrc[product.productId]} alt="Product Image" class="product-image">
                    <div class="navigation-buttons">
                        <button class="nav-button left" on:click={() => prevImage(product.productId)}>&#10094;</button>
                        <button class="nav-button right" on:click={() => nextImage(product.productId)}>&#10095;</button>
                    </div>
                </div>
                
                <div class="product-details">
                    <h3 class="product-title">{product.name}</h3>
                    <p class="product-description">
                        {product.info}
                    </p>
                    <p class="product-price">${product.price}</p>
                    <div class="product-rating">
                        Rating:
                        <span class="stars">{'★'.repeat(Math.round(getProductRating(product.productId)))}{'☆'.repeat(5 - Math.round(getProductRating(product.productId)))}</span>
                        <span class="reviews">({stars.filter(s => s.productId === product.productId).length} reviews)</span>
                    </div>
                    <button class="add-to-cart" on:click={addToCart}>Add to Cart</button>
                </div>
            </div>
        {/each}
    </div>
    <div class="cart-button">
        🛒
        {#if $cartCount > 0}
            <div class="cart-badge">{$cartCount}</div>
        {/if}
    </div>
{:else}
    <p>Loading products...</p>
{/if}


<style>
    .cart-button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        background-color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 24px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        cursor: pointer;
        z-index: 1000;
    }

    .cart-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background-color: #ff4141;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 12px;
    }
    .product-container {
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 30px;
        padding-top: 20px;
        padding-bottom: 30px;
    }

    .product-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
        height: 300px;
        background-color: #e3e3e3;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
       /* transition: transform 0.3s, box-shadow 0.3s; */
        position: relative;
        overflow: hidden;
    }

    .product-item:hover {
        /*transform: translateY(-5px);*/
        box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
    }

    .product-image-container {
        position: relative;
        width: 40%;
        height: 100%;
        overflow: hidden;
        border-radius: 15px;
    }

    .product-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s;
    }

    .product-item:hover .product-image {
        transform: scale(1.05);
    }

    .navigation-buttons {
        position: absolute;
        top: 50%;
        width: 100%;
        display: flex;
        justify-content: space-between;
        transform: translateY(-50%);
        opacity: 0;
        transition: opacity 0.3s;
    }

    .product-image-container:hover .navigation-buttons {
        opacity: 1;
    }

    .nav-button {
        background-color: rgba(0, 0, 0, 0.5);
        border: none;
        width: 50px;
        height: 50px;
        padding-left: 10px;
        color: white;
        padding: 10px;
        border-radius: 50%;
        cursor: pointer;
        font-size: 1.5rem;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.3s;
    }

    .nav-button:hover {
        background-color: rgba(0, 0, 0, 0.8);
    }

    .product-details {
        width: 55%;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 10px;
    }

    .product-title {
        font-size: 1.8rem;
        font-weight: bold;
        margin-bottom: 5px;
        color: black;
    }

    .product-description {
        font-size: 1rem;
        color: black;
        margin-bottom: 10px;
        flex-grow: 1;
    }

    .product-price {
        font-size: 1.5rem;
        color: #d63031;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .product-rating {
        font-size: 1rem;
        color: #525252;        ;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
    }

    .stars {
        margin-right: 10px;
        font-size: 1.2rem;
    }

    .reviews {
        font-size: 0.9rem;
        color: #525252;
    }

    .add-to-cart {
        align-self: flex-end;
        background-color: #636e72;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 25px;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s;
        position: absolute;
        bottom: 20px;
        right: 20px;
    }

    .add-to-cart:hover {
        background-color: #d63031;
    }
</style>
