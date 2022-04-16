import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/RegisterationPagination.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';

import '../pages/appointment/state/appointment_cubit.dart';
import '../pages/auth/state/login_cubit.dart';

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
    // TODO: implement build
    return RegisterationPagination(initPageSelected: initPageSelected);
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