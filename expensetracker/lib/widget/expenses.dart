import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/expense_list/add_newexpense.dart';
import 'package:expense_tracker/widget/expense_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widget/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key, required this.isdark, required this.isDark});
  final void Function() isdark;
  final bool isDark;
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
        title: 'Lunch',
        amount: 1500,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Udemy',
        amount: 650,
        date: DateTime.now(),
        category: Category.work),
  ];
  void addexpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      //allows bottomsheet to take entire height of the screen
      useSafeArea: true,
      //for not hiding the device features like camera battery
      //it main it was done by usematerial3:true
      context: context,
      builder: (ctx) => AddnewExpense(addnewExpense: _addnewExpense),
    );
  }

  void _addnewExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final index = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    //if a user accidently deletes widget, needs to retrive
    // scaffoldmessenger we can access show snack bar
    //snackbar class helps to do this
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense deleted'),
      action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              //neeed
              _expenses.insert(index, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent =
        const Center(child: Text('No data found, Add new one!'));

    if (_expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expenses,
        deleteExpense: _deleteExpense,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: widget.isdark,
                    icon: widget.isDark
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode)),
                IconButton(
                  onPressed: addexpense,
                  icon: const Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _expenses),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expenses: _expenses),
                  ),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ));
  }
}
