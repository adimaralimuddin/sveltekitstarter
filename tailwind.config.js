/** @type {import('tailwindcss').Config} */
// import typo from '@tailwindcss/typography';
// import plugin from 'tailwindcss/plugin';
import daisyui from 'daisyui';
import { fontFamily } from 'tailwindcss/defaultTheme';
export default {
	content: ['./src/**/*.{html,js,svelte,ts}'],
	theme: {
		fontFamily: {
			caroni: ['Caroni', ...fontFamily.sans],
			pecita: ['Pecita', ...fontFamily.sans],
			gaegu: ['Gaegu', ...fontFamily.sans],
			pompiere: ['Pompiere', ...fontFamily.sans],
			sans: ['Caroni', ...fontFamily.sans]
			// sans: ['Rubik', ...fontFamily.sans]
		},
		extend: {
			animation: {
				'vibrate-1': 'vibrate-1 0.3s cubic-bezier(0.6, 0.04, 0.98, 0.335) both',
				jello: 'jello 0.6s linear both',
				'fade-in': ' fade-in 0.5s',
				'slide-top': 'slide-top 0.2s both',
				heartbeat: 'heartbeat 1.5s ease-in-out infinite both',
				'scale-in': 'scale-in-center 0.5s cubic-bezier(0.250, 0.460, 0.450, 0.940) both'
			},
			keyframes: {
				'fade-in': {
					'0%': {
						opacity: 0
					},
					'100%': {
						opacity: 100
					}
				},
				'vibrate-1': {
					'0%': {
						transform: 'translate(0)',
						backgroundColor: 'rgba(255, 82, 82, 0.647)',
						borderColor: 'rgba(255, 82, 82, 0.862)'
					},
					'20%': {
						transform: 'translate(-2px, 2px)'
					},
					'40%': {
						transform: 'translate(-2px, -2px)'
					},
					'60%': {
						transform: 'translate(2px, 2px)'
					},
					'80%': {
						transform: 'translate(2px, -2px)',
						backgroundColor: 'rgba(255, 82, 82, 0)',
						borderColor: 'rgba(255, 82, 82, 0.262)'
					},
					'100%': {
						transform: 'translate(0)'
					}
				},
				jello: {
					'0%': {
						transform: 'scale3d(1, 1, 1)',
						'-webkit-transform': 'scale3d(1, 1, 1)'
					},
					'30%': {
						transform: 'scale3d(1.25, 0.75, 1)',
						'-webkit-transform': 'scale3d(1.25, 0.75, 1)'
					},
					'40%': {
						transform: 'scale3d(0.75, 1.25, 1)',
						'-webkit-transform': 'scale3d(0.75, 1.25, 1)'
					},
					'50%': {
						transform: 'scale3d(1.15, 0.85, 1)',
						'-webkit-transform': 'scale3d(1.15, 0.85, 1)'
					},
					'65%': {
						transform: 'scale3d(0.95, 1.05, 1)',
						'-webkit-transform': 'scale3d(0.95, 1.05, 1)'
					},
					'75%': {
						transform: 'scale3d(1.05, 0.95, 1)',
						'-webkit-transform': 'scale3d(1.05, 0.95, 1)'
					},
					'100%': {
						transform: 'scale3d(1, 1, 1)',
						'-webkit-transform': 'scale3d(1, 1, 1)'
					}
				},
				'slide-top': {
					'0%': {
						transform: 'translateY(100px)'
					},
					'100%': {
						transform: 'translateY(0px)'
					}
				},
				heartbeat: {
					'0%': {
						transform: 'scale(1)',
						'transform-origin': 'center center',
						'animation-timing-function': 'ease-out'
					},
					'10%': {
						transform: 'scale(0.91)',
						'animation-timing-function': 'ease-in'
					},
					'17%': {
						transform: 'scale(0.98)',
						'animation-timing-function': 'ease-out'
					},
					'33%': {
						transform: 'scale(0.87)',
						'animation-timing-function': 'ease-in'
					},
					'45%': {
						transform: 'scale(1)',
						'animation-timing-function': 'ease-out'
					}
				},
				'scale-in-center': {
					'0%': {
						transform: 'scale(0)',
						opacity: '1'
					},
					'100%': {
						transform: 'scale(1)',
						opacity: '1'
					}
				}
			}
		}
	},
	// darkMode: ['selector', '[data-theme="night"]'],

	darkMode: ['selector', '[data-mode="night"]'],
	plugins: [daisyui],
	daisyui: {
		themes: [
			'lemonade',
			// 'retro',
			'valentine',
			'night'
			// {
			// 	valentine: {
			// 		...import('daisyui/src/theming/themes')['valentine'],
			// 		// primary: 'blue',
			// 		// secondary: 'teal',
			// 		'.bg-base': 'white'
			// 	},
			// 	night: {
			// 		...import('daisyui/src/theming/themes')['night'],
			// 		// primary: 'blue',
			// 		// secondary: 'teal',
			// 		'.bg-base': 'white'
			// 	}
			// }
			// {
			// 	polingo: {
			// 		// primary: '#6366f1',
			// 		primary: '#6eb9b6',

			// 		'primary-content': '#030414',

			// 		// secondary: '#06b6d4',
			// 		secondary: '#50B498',

			// 		'secondary-content': '#000c10',

			// 		// accent: '#0d9488',
			// 		accent: '#468585',

			// 		'accent-content': '#d9e4d1',

			// 		neutral: '#1fbca4',

			// 		'neutral-content': '#c4c8c7',

			// 		'base-100': '#111827',

			// 		'base-200': '#17263c',

			// 		'base-300': '#253d62',

			// 		'base-400': '#ed0000',

			// 		'base-content': '#c9cbcf',

			// 		info: '#00b5d9',

			// 		'info-content': '#000c11',

			// 		success: '#4ade80',

			// 		'success-content': '#040800',

			// 		warning: '#ff8700',

			// 		'warning-content': '#160600',

			// 		error: '#ff386a',

			// 		'error-content': '#160104'
			// 	}
			// }
		]
	}
};
