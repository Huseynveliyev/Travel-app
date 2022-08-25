import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'misc/cubit/app_cubit_logics.dart';
import 'misc/cubit/app_cubits.dart';
import 'services/data_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: BlocProvider(
        create: (context) => AppCubits(
          data: DataServices(),
        ),
        child: AppCubitLogics(),
      ),
    );
  }
}
