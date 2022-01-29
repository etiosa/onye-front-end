import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/features/login_cubit/login_cubit.dart';
import 'package:onye_front_ened/pages/Home/home.dart';
import 'package:onye_front_ened/pages/Login/login.dart';
import 'package:onye_front_ened/pages/Patients/patients.dart';
import 'package:onye_front_ened/pages/dashboard/dashboard.dart';
import 'package:onye_front_ened/pages/schedule/Schedule.dart';
import 'package:onye_front_ened/repositories/auth_repositories.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthRepository _authRepository = AuthRepository();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onye',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider.value(value: _authRepository,
          child: BlocProvider(create: (context)=>LoginCubit(_authRepository) , 
            child: const  Schedule()
          ,),
      ),
    );
  }
}
