import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid(); //Uuid class to create an object based on it
//uuid is a third party package

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.category,
      required this.date})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date; //DateTime is a built in data type
  final Category category;

  //adding methods to classes
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  //for building this chart, we need multiple buckets, one for every category, so that we can sum up, all the expenses that belong to one category, so for that we are creating a separate class that will hold that summed up data

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); // adding additional constructor funsctions to classes

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    //utility getter, which sums up all the expenses we have in here

    double sum = 0;

    for (final expense in expenses) {
      //using helper variable expense
      sum = sum + expense.amount; //sum+= expense.amount
    }

    return sum;
  }
}
