import "package:flutter/material.dart";
import "package:flutter/painting.dart";
import "package:flutter/widgets.dart";
import "package:expense_tracker/models/Expenses.dart";
import "package:expense_tracker/Widgets/Expense_item.dart";

class ExpensesList extends StatelessWidget {
  ExpensesList({super.key, required this.Expenses, required this.onRemove});
  final List<Expens> Expenses;
  final void Function(Expens e) onRemove;

  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: Expenses.length,
        itemBuilder: (cnt, index) => Dismissible(
            key: ValueKey(Expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            onDismissed: (direction) {
              onRemove(Expenses[index]);
            },
            child: ExpenseItem(Expenses[index])));
  }
}
