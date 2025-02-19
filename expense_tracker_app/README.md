# 🤑 Expense Tracker App
A responsive and adaptive app for tracking expenses and displaying them in a list as well as visually in a chart by category.

<div style="display: flex; justify-content: center; gap: 10px; align-items: stretch;">
   <img src="https://github.com/TromboneJake/flutter-udemy/blob/main/images/expense_app_portrait.png" 
        alt="Screenshot of the Expense App in Portrait mode" 
        style="height: 200px; object-fit: cover;">
   <img src="https://github.com/TromboneJake/flutter-udemy/blob/main/images/expense_app_landscape.png" 
        alt="Screenshot of the Expense App in Landscape mode" 
        style="height: 200px; object-fit: cover;">
</div>

<div style="display: flex; justify-content: center; gap: 10px; align-items: stretch; margin-top: 10px;">
   <img src="https://github.com/TromboneJake/flutter-udemy/blob/main/images/expense_app_add_portrait.png" 
        alt="Screenshot of the Expense App add modal in Portrait mode" 
        style="height: 200px; object-fit: cover;">
   <img src="https://github.com/TromboneJake/flutter-udemy/blob/main/images/expense_app_add_landscape.png" 
        alt="Screenshot of the Expense App add modal in Landscape mode" 
        style="height: 200px; object-fit: cover;">
</div>


## ✨ Features  
- Track expenses via a Bottom Sheet Modal and display them in a list   
- Delete and undo-delete items from the list by swiping them in either direction
- Visualize spending habits by category with an auto updating chart

## 🗒️ Notes
This section of the course covered adding interactivity, custom widgets, and some theming. The section after built on the app to add responsive and adaptive design to support landscape mode as well as Android and iOS styling differences. I did not implement the iOS styling in my code since I don't have an iOS device to test on, but the process is adding a dart:io import and Platform.isIOS to conditionally set widgets such as the alert dialog based on the returned boolean to use Material (Android) or Cupertino (iOS) styling. This app does not have the ability to persist and store data so when it is closed and reopened it returns to a default state. I might come back and add that functionality later when the course covers those topics.

## 🚀 How to Run  
1. Ensure Flutter is installed ([Installation Guide](https://flutter.dev/docs/get-started/install)).  
2. Clone the repository:  
   ```sh
   git clone <repo-url>
   cd expense_tracker_app
3. Start a compatible emulator.
4. Run the app:
    ```sh
    flutter run
