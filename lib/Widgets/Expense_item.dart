import "package:flutter/material.dart";
import "package:expense_tracker/models/Expenses.dart";

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expens expense;
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text("\$${expense.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                    Icon(Categoryicons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
