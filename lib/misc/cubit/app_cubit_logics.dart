import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveler_app/misc/cubit/app_cubit_state.dart';
import 'package:traveler_app/misc/cubit/app_cubits.dart';
import 'package:traveler_app/pages/detail_page.dart';
import 'package:traveler_app/pages/home_page.dart';
import 'package:traveler_app/pages/welcome_page.dart';

import '../../pages/navpages/main_page.dart';

class AppCubitLogics extends StatefulWidget {
  AppCubitLogics({Key? key}) : super(key: key);

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is DetailState) {
        return DetailPage();
      }
      if (state is WelcomeState) {
        return WelcomePage();
      }
      if (state is LoadedState) {
        return MainPage();
      }
      if (state is LoadingState) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Container();
      }
    }));
  }
}
