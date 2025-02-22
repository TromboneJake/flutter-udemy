import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/keys/keys.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/priority.dart';

final kSeedColor = Colors.blueAccent;

var kColorScheme = ColorScheme.fromSeed(
  seedColor: kSeedColor,
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: kSeedColor,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(TodoAdapter()); // Register Todo Adapter
  Hive.registerAdapter(PriorityAdapter()); // Register Todo Adapter

  await Hive.openBox<Todo>('tasks');
  await Hive.openBox('checkedTasksBox');
  await Hive.openBox('userInfo');
  // Check if first run
  var userBox = Hive.box('userInfo');
  if (!userBox.containsKey('isFirstRun')) {
    userBox.put('isFirstRun', true);
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        textTheme: GoogleFonts.lexendDecaTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        textTheme: GoogleFonts.lexendDecaTextTheme().apply(
          bodyColor: kDarkColorScheme.onSurface,
          displayColor: kDarkColorScheme.onSurface,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer),
        ),
      ),
      home: Keys(),
    );
  }
}
