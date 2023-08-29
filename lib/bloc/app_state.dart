part of 'app_bloc.dart';

class AppState {
  AppState({required this.registeredExpenses});
  List<Expense> registeredExpenses;

  AppState copyWith({List<Expense>? registeredExpenses}) {
    return AppState(
        registeredExpenses: registeredExpenses ?? this.registeredExpenses);
  }
}
