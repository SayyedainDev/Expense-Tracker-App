import "package:flutter/material.dart";
import "package:expense_tracker/Widgets/Expenses.dart";
import "package:flutter/widgets.dart";

var KColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));

void main() {
  return runApp(MaterialApp(
    theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: KColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: KColorScheme.onPrimaryContainer,
          foregroundColor: KColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: KColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: KColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: KColorScheme.onSecondaryContainer,
                fontSize: 16))),
    home: Expenses(),
  ));
}
