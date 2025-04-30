<button
	{...$$restProps}
	on:click
	class=" btn btn-ghost btn-square flex gap-2 items-center justify-center {$$props?.class}"
>
	<slot />
</button>
