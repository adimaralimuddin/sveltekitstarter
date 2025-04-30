<script lang="ts">
	export let isNewlyCompleted = false;
	export let hidden: boolean;
</script>

<div class:hidden class="relative {isNewlyCompleted ? 'animate-completion' : ''} w-12 h-12">
	<svg
		viewBox="0 0 24 24"
		class="w-full h-full absolute"
		fill="none"
		xmlns="http://www.w3.org/2000/svg"
	>
		<!-- Outer circle -->
		<circle
			cx="12"
			cy="12"
			r="10"
			class="stroke-success/30"
			stroke-width="2"
			stroke-dasharray="63"
			stroke-dashoffset={isNewlyCompleted ? '0' : '63'}
			class:circle-animation={isNewlyCompleted}
		/>

		<!-- Checkmark -->
		<path
			d="M8 12.5L10.5 15L16 9"
			class="stroke-success"
			stroke-width="2"
			stroke-linecap="round"
			stroke-linejoin="round"
			stroke-dasharray="12"
			stroke-dashoffset={isNewlyCompleted ? '0' : '12'}
			class:check-animation={isNewlyCompleted}
		/>

		<!-- Celebration particles -->
		{#if isNewlyCompleted}
			<g class="particles">
				{#each Array(6) as _, i}
					<circle
						cx="12"
						cy="12"
						r="1"
						class="fill-success/50"
						style="transform-origin: 12px 12px; animation: particle-{i} 0.8s ease-out forwards"
					/>
				{/each}
			</g>
		{/if}
	</svg>
</div>

<style>
	.circle-animation {
		animation: circle-draw 0.6s ease-out forwards;
	}

	.check-animation {
		animation: check-draw 0.3s ease-out 0.6s forwards;
	}

	@keyframes circle-draw {
		from {
			stroke-dashoffset: 63;
		}
		to {
			stroke-dashoffset: 0;
		}
	}

	@keyframes check-draw {
		from {
			stroke-dashoffset: 12;
		}
		to {
			stroke-dashoffset: 0;
		}
	}

	@keyframes particle-0 {
		from {
			transform: rotate(0deg) translateY(0);
			opacity: 1;
		}
		to {
			transform: rotate(0deg) translateY(-12px);
			opacity: 0;
		}
	}
	@keyframes particle-1 {
		from {
			transform: rotate(60deg) translateY(0);
			opacity: 1;
		}
		to {
			transform: rotate(60deg) translateY(-12px);
			opacity: 0;
		}
	}
	@keyframes particle-2 {
		from {
			transform: rotate(120deg) translateY(0);
			opacity: 1;
		}
		to {
			transform: rotate(120deg) translateY(-12px);
			opacity: 0;
		}
	}
	@keyframes particle-3 {
		from {
			transform: rotate(180deg) translateY(0);
			opacity: 1;
		}
		to {
			transform: rotate(180deg) translateY(-12px);
			opacity: 0;
		}
	}
	@keyframes particle-4 {
		from {
			transform: rotate(240deg) translateY(0);
			opacity: 1;
		}
		to {
			transform: rotate(240deg) translateY(-12px);
			opacity: 0;
		}
	}
	@keyframes particle-5 {
		from {
			transform: rotate(300deg) translateY(0);
			opacity: 1;
		}
		to {
			transform: rotate(300deg) translateY(-12px);
			opacity: 0;
		}
	}

	.animate-completion {
		animation: completion-pop 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	}

	@keyframes completion-pop {
		0% {
			transform: scale(0.8);
			opacity: 0;
		}
		100% {
			transform: scale(1);
			opacity: 1;
		}
	}
</style>
