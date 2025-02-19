import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker_app/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 212, 164, 593),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 212, 164, 593),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.primary,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
          ),
        ),
        textTheme: GoogleFonts.afacadTextTheme(),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.onPrimary,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: GoogleFonts.afacadTextTheme(),
      ),
      // themeMode: ThemeMode.system, THIS IS DEFAULT
      home: const Expenses(),
    ),
  );
}
