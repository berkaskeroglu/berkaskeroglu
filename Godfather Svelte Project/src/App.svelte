<script>
	import MichaelCorleone from "./characters/MichaelCorleone.svelte";
	import VitoCorleone from "./characters/VitoCorleone.svelte";
	import About from "./components/About.svelte";
	import Characters from "./components/Characters.svelte";
	import Navbar from "./components/Navbar.svelte";
	import Shop from "./components/Shop.svelte";
	import Timeline from "./components/Timeline.svelte";

	let currentPage = "about";

	const navigate = (page) => {
		currentPage = page;
	};
</script>

<Navbar {navigate} />

<main>
	{#if currentPage === "about"}
		<About />
	{:else if currentPage === "characters"}
		<Characters />
	{:else if currentPage === "timeline"}
		<Timeline />
	{:else if currentPage == "michael-corleone"}
		<MichaelCorleone />
	{:else if currentPage == "vito-corleone"}
		<VitoCorleone />
	{:else if currentPage == "shop"}
		<Shop />
	{/if}
</main>

<style>
	
	main {
		padding: 1rem;
		max-width: 60%;
		margin: 0 auto;
	}
</style>
