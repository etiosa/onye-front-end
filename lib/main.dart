import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:oktoast/oktoast.dart';
import 'package:onye_front_ened/components/repository/clinical_note_repository.dart';
import 'package:onye_front_ened/pages/eula/eula.dart';
import 'package:onye_front_ened/pages/appointment/form/create_appointment.dart';
import 'package:onye_front_ened/pages/doctor/repository/doctor_repository.dart';
import 'package:onye_front_ened/pages/doctor/state/doctor_cubit_cubit.dart';
import 'package:onye_front_ened/pages/eula/state/eula_bloc.dart';
import 'package:onye_front_ened/pages/home.dart';
import 'package:onye_front_ened/pages/patient/page/patient_profile.dart';
import 'package:onye_front_ened/pages/registration/form/create_registration.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/pages/registration/page/registrations.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import 'package:onye_front_ened/pages/auth/page/login.dart';
import 'package:onye_front_ened/pages/patient/page/patients.dart';
import 'package:onye_front_ened/pages/appointments.dart';
import 'package:onye_front_ened/pages/dashboard.dart';
import 'package:onye_front_ened/pages/appointment/repository/appointment_repository.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';
import 'package:onye_front_ened/pages/patient/repository/patient_repository.dart';
import 'package:onye_front_ened/pages/patient/form/create_patient_form.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onye_front_ened/pages/registration/repository/registration_repository.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';

import 'components/clinicalNote/clinical_note_cubit.dart';

import 'firebase_options.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  await dotenv.load(fileName: 'stage.env');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    String token=
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpZCI6IjJmZWY5ODFmLWUyMGUtNDU5Zi1hNWQ3LTQxZTQ3MDBkNDU0ZCIsInR5cGUiOiJOVVJTRSIsInVzZXJuYW1lIjoibnVyc2UiLCJhY2NlcHRlZEV1bGEiOnRydWUsInJvbGVzIjpbIk5VUlNFIl0sImZhY2lsaXR5IjoiNTc1ZWNjYTEtOTNkOS00YmVhLTljY2ItNGQ3YjY5Yjk4MzczIiwiZXhwIjoxNjU0ODgxNjMyfQ.2ae50_vr6sZt4dmmZDUd6nbWltYfxQH05qiOtL7i88UOizVFqzZMmOuq_hba05xeGpfa-AqlNLdCs7gTwT1tMg';
    Map<String, dynamic> payload = Jwt.parseJwt(token);
        print(payload);


      DateTime? expiryDate = Jwt.getExpiryDate(token);
    print(expiryDate);
    bool isExpired = Jwt.isExpired(token);
    print(isExpired);



    final AuthRepository _authRepository = AuthRepository();
    final PatientRepositories _registerRepository = PatientRepositories();
    final AppointmentRepository _appointmentRepository =
        AppointmentRepository();
    final RegistrationRepository _registrationRepository =
        RegistrationRepository();
    final ClinicalNoteRepository _clinicalNoteRepository =
        ClinicalNoteRepository();
    final DoctorRepository _doctorRepository = DoctorRepository();

    return RepositoryProvider(
        create: (_) => _authRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => LoginBloc(_authRepository),
            ),
            BlocProvider(
              create: (_) => EulaBloc(),
            ),
            BlocProvider(
              create: (_) => PatientCubit(_registerRepository),
            ),
            BlocProvider(
                create: (_) => RegisterationCubit(_registrationRepository)),
            BlocProvider(
                create: (_) => AppointmentCubit(_appointmentRepository)),
            BlocProvider(create: (_) => DoctorCubit(_doctorRepository)),
            BlocProvider(
                create: (_) => ClinicalnoteCubit(_clinicalNoteRepository)),
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
                '/dashboard/patient/patientprofile': (context) =>
                    const PatientProfile(),
                '/dashboard/checkin': (context) => const Registration(),
                '/dashboard/appointment': (context) => const Appointments(),
                '/dashboard/appointment/createAppointment': (context) =>
                    const CreateAppointment(),
                '/dashboard/createRegistration': (context) =>
                    const CreateRegistration(),
                '/dashboard/registrationForm': (context) =>
                    const CreatePatientForm(),
                '/beta-contract': (context) => const Eula(),
              },
            ),
          ),
        ));
  }
}
