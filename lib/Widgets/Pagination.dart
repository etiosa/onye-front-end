import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/AppointmentPagination.dart';
import 'package:onye_front_ened/Widgets/PatientDoctorPagination.dart';
import 'package:onye_front_ened/Widgets/RegisterationPagination.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';

import '../pages/appointment/state/appointment_cubit.dart';
import '../pages/auth/state/login_cubit.dart';

/// @[SearchType]
/// Registration
/// OR
/// Appointment
class Pagination extends StatelessWidget {
  Pagination({
    Key? key,
    required this.initPageSelected,
    required this.searchType,
  }) : super(key: key) {
    // RegisterationCubit
  }

  final int? initPageSelected;

  /// @[SearchType]
  /// Registration
  /// OR
  /// Appointment

  String searchType;

  @override
  Widget build(BuildContext context) {
    switch (searchType) {
      case 'Registration':
        return RegisterationPagination(initPageSelected: initPageSelected);

      case 'Appointment':
        return AppointmentPagination(initPageSelected: initPageSelected);
      case 'Patient':
        return PatientDoctorPagination(initPageSelected: 0);

      default:
        return const SizedBox(
          height: 0,
          width: 0,
        );
    }
  }
}
//search Type
//during it construtor
//return cubit based on type of search


 




//need nextpage
//the method

//registeration pagination
//appointment pagination
//patient or doctor paginaition