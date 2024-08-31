<script>
    import { onMount } from "svelte";
    let currentImageIndex = 0;
    let products = [];
    let images = [];
  //  $: imageSrc = images[currentImageIndex];
    let stars = [];
    let isDataLoaded = false;
    let imageIndices = {};
    

   // let imageSrc = images[currentImageIndex];

    function showImage(productId, index) {
        const productImages = getProductImages(productId);
        if (index < 0) index = productImages.length - 1;
        if (index > productImages.length) index = 0;
        imageIndices[productId] = index;
    }

    function getProductImages(productId) {
        return images.filter(img => img.productId === productId).map(img => img.image);
    }

    function nextImage(productId) {
        showImage(productId, (imageIndices[productId] || 0) + 1);
        console.log("Next image.. Index:", index);
    }

    function prevImage(productId) {
        showImage(productId, (imageIndices[productId] || 0) - 1);
        console.log("Previous image.. Index:", index);
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
        products.forEach(product => {
            imageIndices[product.productId] = 0;
        });
        isDataLoaded = true;
        } catch (error) {
        console.error('Error fetching data:', error);
        }
    });


    


    function getProductRating(productId) {
        const productStars = stars.filter(star => star.productId === productId);
        const totalStars = productStars.reduce((acc, curr) => acc + Number(curr.Star), 0);
        return (totalStars / productStars.length) || 0;
    }
</script>


{#if isDataLoaded}
    <div class="product-container">
        {#each products as product (product.productId)}
            <div class="product-item">
                <div class="product-image-container">
                    <img src={getCurrentImage(product.productId)} alt="Product Image" class="product-image">
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
                    <button class="add-to-cart">Add to Cart</button>
                </div>
            </div>
        {/each}
    </div>
{:else}
    <p>Loading products...</p>
{/if}


<style>
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
        background-color: #808080;
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
        color: #dfe6e9;
    }

    .product-description {
        font-size: 1rem;
        color: white;
        margin-bottom: 10px;
        flex-grow: 1;
    }

    .product-price {
        font-size: 1.5rem;
        color: #dfe6e9;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .product-rating {
        font-size: 1rem;
        color: #ffd700;
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
        color: white;
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
