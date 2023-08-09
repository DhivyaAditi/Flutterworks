import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/expense_list/expense_item.dart';
import 'package:flutter/material.dart';
class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key, required this.expenses, required this.deleteExpense });
  final void Function(Expense expense) deleteExpense;
final List<Expense> expenses;
  @override
  Widget build(context){
    return ListView.builder(
      
      itemCount: expenses.length,
      itemBuilder: ((ctx, index) => 
      Dismissible(
        background: Container(color:Theme.of(context).colorScheme.error.withOpacity(0.3),
        margin: Theme.of(context).cardTheme.margin,),
        key:ValueKey(expenses[index]),
       onDismissed: (direction) =>deleteExpense(expenses[index]),
       child: ExpenseItem(expenses[index]
       ))));
      
  }
}