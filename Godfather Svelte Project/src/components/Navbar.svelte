<script>
    export let navigate;
    let audio = new Audio('/music/The Godfather Theme Song.mp3');
    let isPlaying = false;
    let isOpen = false;

    function toggleMusic() {
        if (isPlaying) {
            audio.pause();
            audio.currentTime = 0;
        }
        else {
            audio.play();
        }
        isPlaying = !isPlaying;
    }

    function openDropdown() {
        isOpen = true;
    }

    function closeDropdown() {
        isOpen = false;
    }
    

</script>
<div class="nav-container">
    <img src="data:image/png;base64,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" alt="logo" class="logo" />
</div>

<nav class="nav-bar">
    <a class="nav-item" href="#" on:click={() => navigate("about")}>About Godfather</a>
    <!-- svelte-ignore a11y-mouse-events-have-key-events -->
    <a class="nav-item" href="#" on:mouseover={openDropdown} on:mouseleave={closeDropdown}>
        Characters
        <ul class={`dropdown ${isOpen ? 'show' : ''}`}>
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <li class="dropdown-item" href="#" on:click={() => navigate("vito-corleone")}>Don Vito Corleone</li>
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <li class="dropdown-item" href="#" on:click={() => navigate("michael-corleone")}>Michael Corleone</li>
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <li class="dropdown-item" on:click={() => navigate("tom-hagen")}>Tom Hagen</li>
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <li class="dropdown-item" on:click={() => navigate("vincent-corleone")}>Vincent Corleone</li>
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <li class="dropdown-item" on:click={() => navigate("santino-corleone")}>Santino Corleone</li>
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <li class="dropdown-item" on:click={() => navigate("fredo-corleone")}>Fredo Corleone</li>
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <li class="dropdown-item" on:click={() => navigate("others")}>Others</li>
        </ul>
    </a>
    <a class="nav-item" href="#" on:click={() => navigate("timeline")}>Timeline</a>
    <a class="nav-item" href="#">Quiz</a>
    <a class="nav-item" href="#" on:click={() => navigate("shop")}>Shop</a>
</nav>

{#if isPlaying}
    <!-- svelte-ignore a11y-click-events-have-key-events -->
    <i class="fa-sharp fa-solid fa-pause music-icon" on:click={toggleMusic}></i>
{:else}
    <!-- svelte-ignore a11y-click-events-have-key-events -->
    <i class="fa-solid fa-play music-icon" on:click={toggleMusic}></i>
{/if}

<style>
    .nav-container {
        background-color: black;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 10px;
    }
    .nav-bar {
        /* font-family: Copperplate, "Copperplate Gothic Light", fantasy; */
        align-items: center;
        display: flex;
        justify-content: space-evenly;
        width: 100%;
        background-color: black;
        padding: 10px 0;
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .dropdown {
        width: 180px;
        display: none;
        position: absolute;
        top: 100%;
        left: 50%;
        transform: translateX(-50%);
        background-color: #fff;
        color: #333;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 4px;
        list-style: none;
        padding: 0;
        margin: 0;
        z-index: 1000;
    }

    .dropdown.show {
        display: block;
    }

    .dropdown-item {
        padding: 10px 20px;
        cursor: pointer;
    }

    .dropdown-item:hover {
        background-color: #ddd;
    }

    .nav-item {
        position: relative;
        color:white;
        margin: 0 1rem;
        font-size: 2rem;
        text-decoration: none;
        font-family: 'The Godfather', sans-serif;
        
    }

    .nav-item:hover {
        color: #f4c430;
    }

    .logo {
        margin-bottom: 10px;
        width: 300px;
        height: auto;
    }

    .music-icon {
        position: fixed;
        height: 40px;
        top: 20px;
        right: 20px;
        bottom: 20px;
        font-size: 2rem;
        color: white;
        cursor: pointer;
        z-index: 1100;
    }

    .music-icon:hover {
        color: #f4c430;
    }
</style>
