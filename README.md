# Fly - Furniture Store (Flutter Assignment)

This project is a mobile e-commerce app built as an assignment. It's called "Fly," and it's basically a furniture store where users can browse items, add them to a cart, and go through a checkout process.

The main goal of this assignment was to practice using Flutter for UI and handling state management with Provider.

## What's in the app
- **User Accounts**: You can sign up and log in. It uses secure storage for tokens.
- **Product Browsing**: Shows furniture items with details.
- **Cart & Favorites**: Users can save items they like or add them to the cart for "buying."
- **Checkout Flow**: I implemented a basic checkout process, including a QR code payment simulation.
- **Maps Integration**: Added maps to show locations (uses Google Maps and Flutter Map).

## Built With
- **Flutter**: The main framework.
- **Provider**: For managing the app state (cart, user info, etc).
- **Go Router**: For handling navigation between screens.
- **HTTP**: To talk to the backend API.
- **Shared Preferences**: To save simple things like theme settings.

## Folder Structure
I tried to keep things organized by features:
- `lib/features`: All the screens and logic for specific parts like `auth`, `home`, and `checkout`.
- `lib/core`: Shared widgets and routing.
- `lib/providers`: State management files.
- `lib/config`: Colors and API settings.

## Setting it up
If you want to run this locally:

1. Clone the repo:
   ```bash
   git clone https://github.com/HoeunRaksa/fly-ecommerce_flutter.git
   ```
2. Get the packages:
   ```bash
   flutter pub get
   ```
3. Check the API URL:
   Go to `lib/config/app_config.dart` and make sure the `baseUrl` is correct. Right now it points to: `https://api.furniture.learner-teach.online/api`.
4. Run it:
   ```bash
   flutter run
   ```

## Note
The backend is running on Laravel, which handles the products and user data. It needs to be online for the app to fetch items.

-- 
**Author:** Hoeun Raksa
