import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/components/Forms/AppointmentForm.dart';
import 'package:onye_front_ened/components/Forms/CreateRegistration.dart';
import 'package:onye_front_ened/components/Forms/RegistrationForm.dart';
import 'package:onye_front_ened/features/appointment/appointment_cubit.dart';
import 'package:onye_front_ened/features/login_cubit/login_cubit.dart';
import 'package:onye_front_ened/features/registration/registration_cubit.dart';
import 'package:onye_front_ened/pages/Home/home.dart';
import 'package:onye_front_ened/pages/Login/login.dart';
import 'package:onye_front_ened/pages/Patients/patients.dart';
import 'package:onye_front_ened/pages/appointment/Appointments.dart';
import 'package:onye_front_ened/pages/appointment/registration/Checkin.dart';
import 'package:onye_front_ened/pages/dashboard/dashboard.dart';
import 'package:onye_front_ened/repositories/appointment_repositories/appointment_repositories.dart';
import 'package:onye_front_ened/repositories/auth_repositories.dart';
import 'package:onye_front_ened/repositories/registration_repositories/registrationRepositories.dart';

void main() async {
  runApp(const MyApp());
}

//TODO: create private Route later
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthRepository _authRepository = AuthRepository();
    final RegistrationRepositories _registerRepository =
        RegistrationRepositories();
    final AppointmentRepository _appointmentRepository =
        AppointmentRepository();

    return RepositoryProvider(
      create: (_) => _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
             lazy: false,
            create: (_) => LoginCubit(_authRepository),
          ),
          BlocProvider(
            create: (_) => RegistrationCubit(_registerRepository),
          ),
          BlocProvider(create: (_) => AppointmentCubit(_appointmentRepository))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Onye',
          routes: {
            '/': (context) => const HomePage(),
            '/login': (context) => const LoginPage(),
            '/dashboard': (context) => const Dashboard(),
            '/dashboard/checkin': (context) => const Checkin(),
            '/dashboard/appointment': (context) => const Appointments(),
            '/dashboard/appointment/createAppointment': (context) =>
                const AppointmentForm(),
                 '/dashboard/appointment/createRegistration':(context)=>const CreateRegistration(),
            '/dashboard/registrationForm': (context) =>
                const RegistrationForm(),
            'dashboard/patient': (context) => const PatientsPage()
          },
        ),
      ),
    );
  }
}
