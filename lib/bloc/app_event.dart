part of 'app_bloc.dart';

abstract class AppEvent {}

class AppExpenseRegistered extends AppEvent {
  AppExpenseRegistered({required this.expense});
  final Expense expense;
}

class AppExpenseRemoved extends AppEvent {
  AppExpenseRemoved({required this.expense});
  final Expense expense;
}

class AppExpenseRemovalUndoed extends AppEvent {
  AppExpenseRemovalUndoed({required this.expense, required this.index});
  final Expense expense;
  final int index;
}
