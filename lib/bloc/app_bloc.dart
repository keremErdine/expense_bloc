import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/models/expense.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<AppExpenseRegistered>(_registerExpense);
    on<AppExpenseRemoved>(_removeExpense);
    on<AppExpenseRemovalUndoed>(_expenseRemovalUndoed);
  }

  void _registerExpense(
      AppExpenseRegistered event, Emitter<AppState> emit) async {
    List<Expense> copiedList = [...state.registeredExpenses];
    copiedList.add(event.expense);
    emit(state.copyWith(registeredExpenses: copiedList));
  }

  void _removeExpense(AppExpenseRemoved event, Emitter emit) async {
    List<Expense> copiedList = [...state.registeredExpenses];
    copiedList.remove(event.expense);
    emit(state.copyWith(registeredExpenses: copiedList));
  }

  void _expenseRemovalUndoed(AppExpenseRemovalUndoed event, Emitter emit) {
    List<Expense> copiedList = [...state.registeredExpenses];
    copiedList.insert(event.index, event.expense);
    emit(state.copyWith(registeredExpenses: copiedList));
  }
}
