<script lang="ts">
	
	import '../app.css';
	import '@fontsource/rubik';
	import { page } from '$app/stores';

	import ThemeToggler from '$lib/app/theme/ThemeToggler.svelte';
	$: theme = $page?.data?.theme;
</script>


<div id="theme-div" data-theme={theme} class="min-h-screen min-w-screen">
	<ThemeToggler/>
	<slot />
</div>


