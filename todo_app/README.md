# ✅ Todo App
 a lightweight task tracker to add tasks with priority and priority-based sorting. Swipe a task to delete it or check it to cross it off the list. Data is stored locally with the [Hive](https://github.com/isar/hive) package.

<img src='https://github.com/TromboneJake/flutter-udemy/blob/main/images/task_app_portrait.png' alt='Portrait screenshot of the task app screen featuring a few tasks with one crossed off.' width=33%/>


## ✨ Features  
- Make a list of tasks that are sorted by priority, high to low or low to high
- Check a task when it is completed to cross it off
- Swipe a task to delete it from the list

## 🗒️ Notes
This section of the course was focused primarily on teaching the concept of keys, to pair the checkbox with the proper todo item when sorting. Before implementing the key the checkbox would stay in place but the task would sort. By using keys, the checkbox stays with the appropriate task. Because this was only a short amount of videos and the code was given I thought it was a good chance to practice and reinforce what was taught up until then so I spent time changing the code and implementing features from previous apps such as the dismissible list item and modal bottom sheet taught with the [Expense Tracker App](https://github.com/TromboneJake/flutter-udemy/tree/main/expense_tracker_app). I also chose to explore some data persistence earlier than the course explored it and implemented the [Hive](https://github.com/isar/hive) package to persist the tasks and their checked state, as well as display a sample task for a first time user. I might come back at a later time and implement some other features such as a task log to see previous days tasks, or a streak system to encourage and reinforce completing all the tasks for a day.

## 🚀 How to Run  
1. Ensure Flutter is installed ([Installation Guide](https://flutter.dev/docs/get-started/install)).  
2. Clone the repository:  
   ```sh
   git clone <repo-url>
   cd todo_app
3. Start a compatible emulator.
4. Run the app:
    ```sh
    flutter run
