import "package:flutter/material.dart";
import "package:expense_tracker/models/Expenses.dart";

class Newexpenses extends StatefulWidget {
  const Newexpenses({super.key, required this.onAddExpenses});
  final void Function(Expens expenses) onAddExpenses;
  @override
  State<Newexpenses> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<Newexpenses> {
  final titleController = TextEditingController();
  final AmountController = TextEditingController();
  DateTime? _pickedDate;
  Categorys _type = Categorys.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );

    final Datepick = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _pickedDate = Datepick;
    });
  }

  void _saveExpense() {
    final entredAmout = double.tryParse(AmountController.text);
    final amounstisInvalid = entredAmout == null || entredAmout <= 0;
    if (titleController.text.trim().isEmpty ||
        amounstisInvalid ||
        _pickedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                //want a builder function that will take a context and return a widget
                title: const Text("Invalid Input"),
                content: const Text(
                    "Please enter the valid date , Amount and Category"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    }
    widget.onAddExpenses(Expens(
        title: titleController.text,
        amount: entredAmout,
        date: _pickedDate!,
        category: _type));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    AmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text("Title")),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: AmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: "\$ ",
                      label: Text("Amount"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_pickedDate == null
                        ? "NO date selected"
                        : formatter.format(_pickedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                    value: _type,
                    items: Categorys.values
                        .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            )))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _type = value;
                      });
                    }),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel ")),
                ElevatedButton(
                    onPressed: _saveExpense,
                    child: const Text("Save the Text")),
              ],
            )
          ],
        ));
  }
}
