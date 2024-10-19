import "package:flutter/material.dart";
import "package:uuid/uuid.dart";
import "package:intl/intl.dart";

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Categorys { travel, leisure, food, work }

const Categoryicons = {
  Categorys.food: Icons.food_bank,
  Categorys.leisure: Icons.movie,
  Categorys.travel: Icons.travel_explore,
  Categorys.work: Icons.work,
};

class Expens {
  Expens(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4() //generate a unique string id
  ;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categorys category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class expenseBucket {
  const expenseBucket({
    required this.category,
    required this.expenses,
  });

  expenseBucket.ofcategory(List<Expens> allexpenses, this.category)
      : expenses = allexpenses
            .where((expense) => expense.category == category)
            .toList();
  final List<Expens> expenses;
  final Categorys category;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
