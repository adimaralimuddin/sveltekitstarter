<script lang="t">
	import { cokySet } from '$lib/packs/coky/coky';
	import IconMoon from '$lib/Uis/icons/IconMoon.svelte';
	import IconSun from '$lib/Uis/icons/IconSun.svelte';
	const theme = ['valentine', 'night'];
</script>

<button {...$$props} class="btn btn-ghost btn-sm btn-square {$$props?.class}">
	<label class="hover:text-primary flex items-center cursor-pointer space-x-2d">
		<input
			class="peer hidden"
			type="checkbox"
			on:change={(e) => {
				const val = e.currentTarget.checked;
				const tar = document.getElementById('theme-div');
				if (tar) {
					const attr = tar.getAttribute('data-theme');
					if (attr == theme[0]) {
						cokySet('theme', theme[1]);
						tar.setAttribute('data-theme', theme[1]);
					} else {
						cokySet('theme', theme[0]);
						tar.setAttribute('data-theme', theme[0]);
					}
				}
			}}
		/>
		<IconMoon class="peer-checked:hidden" />
		<IconSun class="hidden peer-checked:block" />
	</label>
</button>
