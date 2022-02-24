import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:onye_front_ened/pages/appointment/form/appointment_form.dart';
import 'package:onye_front_ened/pages/appointment/form/create_appointment.dart';
import 'package:onye_front_ened/pages/registration/form/create_registration.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/pages/registration/page/Registration.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import 'package:onye_front_ened/pages/home.dart';
import 'package:onye_front_ened/pages/auth/page/login.dart';
import 'package:onye_front_ened/pages/patient/page/patients.dart';
import 'package:onye_front_ened/pages/appointment/page/Appointments.dart';
import 'package:onye_front_ened/pages/dashboard.dart';
import 'package:onye_front_ened/pages/appointment/repository/appointment_repository.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';
import 'package:onye_front_ened/pages/patient/repository/patientRepository.dart';
import 'package:onye_front_ened/pages/patient/form/create_patient_form.dart';

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
            BlocProvider(
                create: (_) => AppointmentCubit(_appointmentRepository))
          ],
          child: OKToast(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Onye',
              routes: {
                '/': (context) => const HomePage(),
                '/login': (context) => const LoginPage(),
                '/dashboard': (context) => const Dashboard(),
                '/dashboard/checkin': (context) => const Registration(),
                '/dashboard/appointment': (context) => const Appointments(),
                '/dashboard/appointment/createAppointment': (context) =>
                    const AppointmentForm(),
                '/dashboard/appointment/createRegistration': (context) =>
                    const CreateRegistration(),
                '/dashboard/appointment/createApppointment': (context) =>
                    const CreateAppointment(),
                '/dashboard/registrationForm': (context) =>
                    const CreatePatientForm(),
                'dashboard/patient': (context) => const PatientsPage()
              },
            ),
          ),
        ));
  }
}
