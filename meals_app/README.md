# 🍔 Meals App
An app for discovering meals by cuisine. It features multiple screens including a filter select screen for a user to toggle and display only meals that fit those filters, such as vegan or gluten-free. This app features state management with the [Riverpod](https://riverpod.dev/) package.

*Screenshot(s) coming soon*

The next section focuses on adding animations to the app. Check back soon for that!

## ✨ Features  
- View a list of cuisine categories and select one to view meals from it
- Favorite a meal to add it to your favorites list for easy access
- Filter out certain meals based on dietary restrictions such as gluten-free, lactose-free, vegetarian, or vegan

## 🗒️ Notes
This section focused on navigation and routing between multiple screens, with a navigation bar and side drawer, and managing state and data between them. Afterwards, the app was updated to remove state management by passing around code and instead to manage app-wide state via [Riverpod](https://riverpod.dev/). Finally, some app animations were added like having the grid of categories scroll up from the bottom, this was added with explicit animations. An animation to spin the star when a meal was favorited/unfavorited was added with an implicit animation. An animation on the image when switching screens from the list of meals to a specific meal was also added by wrapping the images on both screens with a Hero widget and adding a tag parameter.

## 🚀 How to Run  
1. Ensure Flutter is installed ([Installation Guide](https://flutter.dev/docs/get-started/install)).  
2. Clone the repository:  
   ```sh
   git clone <repo-url>
   cd meals_app
3. Start a compatible emulator.
4. Run the app:
    ```sh
    flutter run
