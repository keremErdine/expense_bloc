import 'package:expense_tracker/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  void _removeExpense(Expense expense) {
    final expenseIndex =
        context.read<AppBloc>().state.registeredExpenses.indexOf(expense);
    context.read<AppBloc>().add(AppExpenseRemoved(expense: expense));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            context.read<AppBloc>().add(
                AppExpenseRemovalUndoed(expense: expense, index: expenseIndex));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    late Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        mainContent = const Center(
          child: Text('No expenses found. Start adding some!'),
        );
        if (state.registeredExpenses.isNotEmpty) {
          mainContent = ExpensesList(
            expenses: state.registeredExpenses,
            onRemoveExpense: _removeExpense,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter ExpenseTracker'),
            actions: [
              IconButton(
                onPressed: _openAddExpenseOverlay,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: width < 600
              ? Column(
                  children: [
                    Chart(expenses: state.registeredExpenses),
                    Expanded(
                      child: mainContent,
                    ),
                  ],
                )
              : Row(children: [
                  Expanded(
                    child: Chart(expenses: state.registeredExpenses),
                  ),
                  Expanded(
                    child: mainContent,
                  ),
                ]),
        );
      },
    );
  }
}