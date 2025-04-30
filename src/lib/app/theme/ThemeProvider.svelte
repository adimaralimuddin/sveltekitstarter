<script lang="ts">
	import { page } from '$app/stores';
	$: theme = $page?.data?.theme;
</script>

<div id="theme-div" data-theme={theme} class="min-h-screen min-w-screen">
	<slot />
</div>
