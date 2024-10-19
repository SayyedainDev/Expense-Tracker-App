import "package:expense_tracker/chart/chart.dart";
import "package:flutter/material.dart";
import "package:expense_tracker/models/Expenses.dart";
import "package:expense_tracker/Widgets/Expenses_list.dart";
import "package:expense_tracker/Widgets/newexpenses.dart";

class Expenses extends StatefulWidget {
  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expens> registerd_users = [];
  void _addoverly() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Newexpenses(onAddExpenses: _addExpenses),
    );
  }

  void _addExpenses(Expens expenses) {
    setState(() {
      registerd_users.add(expenses);
    });
  }

  void _removeExpenses(Expens Expenses) {
    final _expenseindex = registerd_users.indexOf(Expenses);
    setState(() {
      registerd_users.remove(Expenses);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                registerd_users.insert(_expenseindex, Expenses);
              });
            }),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainconten =
        const Center(child: Text("No ,Content find in the File"));

    if (registerd_users.isNotEmpty) {
      mainconten = ExpensesList(
        Expenses: registerd_users,
        onRemove: _removeExpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            "Flutter Expense Tacker app",
          ),
        ),
        actions: [
          IconButton(
            onPressed: _addoverly,
            icon: const Icon(
              Icons.ad_units_rounded,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(expenses: registerd_users),
          Expanded(child: mainconten)
        ],
      ),
    );
  }
}
