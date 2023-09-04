// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:expense_tracker/models/expense.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.create()) {
    on<AppExpenseRegistered>((event, emit) => emit(registerExpense(event)));
    on<AppExpenseRemoved>((event, emit) => emit(removeExpense(event)));
    on<AppExpenseRemovalUndoed>(
        (event, emit) => emit(expenseRemovalUndoed(event)));
  }

  AppState registerExpense(AppExpenseRegistered event) {
    List<Expense> copiedList = state.registeredExpenses;
    copiedList.add(event.expense);
    return state.copyWith(registeredExpenses: copiedList);
  }

  AppState removeExpense(AppExpenseRemoved event) {
    List<Expense> copiedList = state.registeredExpenses;
    copiedList.remove(event.expense);
    return state.copyWith(registeredExpenses: copiedList);
  }

  AppState expenseRemovalUndoed(AppExpenseRemovalUndoed event) {
    List<Expense> copiedList = state.registeredExpenses;
    copiedList.insert(event.index, event.expense);
    return state.copyWith(registeredExpenses: copiedList);
  }
}
