import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.expense,{super.key});
  final Expense expense;
  @override
  Widget build(context){
    
    return   Card(
      child:Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          Text(expense.title,style: Theme.of(context).textTheme.titleLarge),
          
          Row(
            children:[
              Text(expense.amount.toString()),
              const Spacer(),
              Row(children: [
              Icon(categoryicon[expense.category]),
              const SizedBox(width:4),
              Text(expense.formatteddate)
              ],)
              
              
            ]
            
          )
        ],
      ),
    )
     );
  }
}