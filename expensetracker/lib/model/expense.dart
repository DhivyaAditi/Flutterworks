
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter=DateFormat.yMd();


const uuid = Uuid();

enum Category { food, travel, lesuire, work }

const categoryicon={
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.lesuire: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatteddate{
    return formatter.format(date);
  }
}
class ExpenseBucket{
  final List<Expense> expenses;
  final Category category;
  double sum=0;

  ExpenseBucket(this.category,this.expenses);

 double  get allexpenseSpent{
     double sum=0;
    for(final expense in expenses){
      sum+=expense.amount;
    }
    return sum;
  }
  ExpenseBucket.forCategory(List<Expense> allexpenses,this.category):expenses=allexpenses.where((element) => element.category==category).toList();
}