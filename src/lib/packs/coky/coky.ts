export function cokyGet(key: string) {
	// Retrieve all cookies as a single string
	const cookies = document.cookie;

	// Split the cookie string into individual key-value pairs
	const cookieArray = cookies.split('; ');

	// Find the cookie with the matching key and return its value
	for (const cookie of cookieArray) {
		const [cookieKey, cookieValue] = cookie.split('=');
		if (cookieKey === key) {
			const c = decodeURIComponent(cookieValue); // Return decoded cookie value
			return JSON.parse(c);
		}
	}

	// Return null if the cookie is not found
	return null;
}

export function cokySet(
	key: string,
	value: unknown,
	{ expiresInDays }: { expiresInDays: number } = { expiresInDays: 999 }
): void {
	// Convert the value to a string (if necessary) and encode it to make it cookie-safe

	value = typeof value !== 'string' ? JSON.stringify(value) : value;

	const encodedValue = encodeURIComponent(value);

	// Set the expiration date
	const date = new Date();
	date.setTime(date.getTime() + expiresInDays * 24 * 60 * 60 * 1000); // Convert days to milliseconds
	const expires = `expires=${date.toUTCString()}`;

	// Set the cookie with the key, value, and expiration
	document.cookie = `${key}=${encodedValue}; ${expires}; path=/`;
}

export function cokyDel(name: string) {
	document.cookie = `${name}=; path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC;`;
}

// Delete the 'user_auth' cookie
