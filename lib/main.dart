

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:onye_front_ened/pages/appointment/form/create_appointment.dart';
import 'package:onye_front_ened/pages/home.dart';
import 'package:onye_front_ened/pages/patient/page/PatientProfile.dart';
import 'package:onye_front_ened/pages/registration/form/create_registration.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/pages/registration/page/registrations.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import 'package:onye_front_ened/pages/auth/page/login.dart';
import 'package:onye_front_ened/pages/patient/page/patients.dart';
import 'package:onye_front_ened/pages/appointments.dart';
import 'package:onye_front_ened/pages/dashboard.dart';
import 'package:onye_front_ened/pages/appointment/repository/appointment_repository.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';
import 'package:onye_front_ened/pages/patient/repository/patientRepository.dart';
import 'package:onye_front_ened/pages/patient/form/create_patient_form.dart';

void main() async {
  runApp(const MyApp());
}

//TODO: create private Route later
//TODO: App wrapper i
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthRepository _authRepository = AuthRepository();
    final PatientRepositories _registerRepository =
        PatientRepositories();
    final AppointmentRepository _appointmentRepository =
        AppointmentRepository();

    return RepositoryProvider(
        create: (_) => _authRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => LoginCubit(_authRepository),
               
            ),
            BlocProvider(
              create: (_) => PatientCubit(_registerRepository),
            ),
            BlocProvider(
                create: (_) => AppointmentCubit(_appointmentRepository))
          ],
          child: OKToast(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Onye',
              routes: {
                '/': (context) => const HomePage(),
                '/dashboard/patient': (context) => const PatientsPage(),
                '/login': (context) => const LoginPage(),
                '/dashboard': (context) => const Dashboard(),
                 '/dashboard/patient/patientprofile': (context) => const PatientProfile(),
                '/dashboard/checkin': (context) => const Registration(),
                '/dashboard/appointment': (context) => const Appointments(),
                '/dashboard/appointment/createAppointment': (context) =>
                    const CreateAppointment(),
                '/dashboard/appointment/createRegistration': (context) =>
                    const CreateRegistration(),
                '/dashboard/registrationForm': (context) =>
                    const CreatePatientForm(),
                'dashboard/patient': (context) => const PatientsPage()
              },
            ),
          ),
        ));
  }
}
