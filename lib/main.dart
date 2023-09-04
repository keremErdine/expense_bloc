import 'package:expense_tracker/bloc/app_bloc.dart';
import 'package:expense_tracker/screens/home/home.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
      BlocProvider(create: (context) => AppBloc(), child: const ExpenseApp()));
}
