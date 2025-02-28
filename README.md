# My Experience with Flutter & Dart - The Complete Guide [2025 Edition]

This repository contains my projects **Flutter & Dart - The Complete Guide [2025 Edition]** course on Udemy. The course, taught by Maximilian Schwarzmüller, covers everything from the basics of Flutter and Dart to advanced app development concepts.
I will code along with the course and then occasionally add my own functionality to the apps to reinforce my learning. These changes will be documented in each project.

![Course Progress](https://progress-bar.xyz/88?title=Course%20Progress)

## 📌 Course Overview
This course provides a comprehensive introduction to Flutter and Dart, teaching how to build cross-platform mobile applications for iOS and Android. Topics include:
- Dart fundamentals and object-oriented programming  
- Flutter UI components and layout system  
- State management (setState, Provider, Riverpod, etc.)  
- Working with APIs and databases  
- Navigation and routing  
- Firebase integration  
- Animations and custom widgets  
- Deploying apps to the Play Store & App Store

## 📂 Repository Structure
Each folder in this repository corresponds to a specific section of the course, containing the full projects and my notes on them.

## 🚀 Projects
Throughout the course, I will build several real-world projects, including:
- [**Roll Dice App**](https://github.com/TromboneJake/flutter-udemy/tree/main/roll_dice_app): The Roll Dice App is a simple Flutter application that simulates rolling a dice. I added the ability to choose a polyhedral die and some custom artwork.
- [**Quiz App**](https://github.com/TromboneJake/flutter-udemy/tree/main/quiz_app): The Quiz App is a multi-screen Flutter application that allows users to take a quiz and see their score and correct answers at the end. I changed the questions and may add functionality to upload custom question sets later.
- [**Expense Tracker App**](https://github.com/TromboneJake/flutter-udemy/tree/main/expense_tracker_app): The Expense Tracker App is a responsive and adaptive app for tracking expenses and displaying them in a list as well as visually in a chart by category. Needs functionality to store and persist data. 
- [**ToDo App**](https://github.com/TromboneJake/flutter-udemy/tree/main/todo_app): The Todo App is a lightweight task tracker to add tasks with priority and priority-based sorting. Swipe a task to delete it or check it to cross it off the list. Data is stored locally with the [Hive](https://github.com/isar/hive) package.  
- [**Meals App**](https://github.com/TromboneJake/flutter-udemy/tree/main/meals_app): The Meal App is an app for discovering meals by cuisine. It features multiple screens including a filter select screen for a user to toggle and display only meals that fit those filters, such as vegan or gluten-free. App-wide state was managed with [Riverpod](https://riverpod.dev).
- [**Shopping List App**](https://github.com/TromboneJake/flutter-udemy/tree/main/shopping_list_app): The Shopping List app is an app for creating a list of grocery items. This was the first app to implement a backend using [Firebase](https://firebase.google.com/docs) and [HTTP](https://pub.dev/packages/http) requests.
- [**Favorite Places App**](https://github.com/TromboneJake/flutter-udemy/tree/main/favorite_places_app): The Favorite Places app allows a user to add their favorite places to a list. Creating a favorite places has a user take a picture with their device with use of the [Image Picker](https://pub.dev/packages/image_picker) package, as well as set a location of the place with use of the [Google Maps API](https://developers.google.com/maps). These places are then stored in an [SQFLite](https://pub.dev/packages/sqflite) database so when a user returns to the app they can still view their favorite places. App-wide state was again managed with [Riverpod](https://riverpod.dev).
- **Chat App**

## 🗒️ Notes
I may also include some notes documenting key concepts, code snippets, and useful references for each project in a `notes/` directory as I see fit.

## 🎯 Goals
- Gain a solid understanding of Flutter & Dart
- Build fully functional mobile apps
- Learn best practices for state management
- Deploy apps to app stores

## 📌 How to Run a Project
To run any of the projects in this repo, navigate to the respective folder and use:
````sh
flutter pub get
flutter run
````
Ensure you have Flutter installed. If not check the [Flutter Installation Guide](https://docs.flutter.dev/get-started/install).
