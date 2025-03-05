# 🍔 Meals App
An app for discovering meals by cuisine. It features multiple screens including a filter select screen for a user to toggle and display only meals that fit those filters, such as vegan or gluten-free. This app features state management with the [Riverpod](https://riverpod.dev/) package.

<div style="display: flex; flex-direction: row;">
   <img src="https://github.com/user-attachments/assets/2dcfccad-2a6a-4cdd-a9d1-44e9931514e1" width=16%>
   <img src="https://github.com/user-attachments/assets/ca4aab86-a3be-4bdb-96e1-8d8078363047" width=16%>
   <img src="https://github.com/user-attachments/assets/ae63a944-a746-4413-a21a-70d092a00e88" width=16%>
   <img src="https://github.com/user-attachments/assets/24c700df-f43a-414f-bf16-ee103ce6c77b" width=16%>
   <img src="https://github.com/user-attachments/assets/25c4145b-fa44-47ff-8562-79e04383e2cd" width=16%>
   <img src="https://github.com/user-attachments/assets/38a3c545-3e7f-4dce-adb5-6232eb2e0992" width=16%>
</div>

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
