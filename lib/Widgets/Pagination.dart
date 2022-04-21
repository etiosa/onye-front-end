import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';

import '../pages/auth/state/login_cubit.dart';
import '../pages/doctor/state/doctor_cubit_cubit.dart';
import '../pages/patient/state/patient_cubit.dart';
import '../pages/registration/state/registration_cubit.dart';



/// /// @[SearchType : doctor, patient, appointment
///       registration]
class Pagination extends StatefulWidget {
  final int maxPageCounter;
  final String typeofSearch;

  const Pagination({
    required this.maxPageCounter,
    required this.typeofSearch,
    Key? key,
  }) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int initPageSelected = 0;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 90,
      color: const Color.fromARGB(255, 56, 155, 152),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var index = 0; index < widget.maxPageCounter; index++)
            Container(
              margin: const EdgeInsets.only(top: 1.0),
              child: InkWell(
                onTap: () {
                  initPageSelected = index;

                  var setPage = setPageFunctionType(
                      type: widget.typeofSearch,
                      context: context,
                      index: initPageSelected);

                  setPage();
                },
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: initPageSelected == index
                            ? const Color.fromARGB(255, 98, 0, 238)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Text(
                      "${index + 1}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: initPageSelected == index
                              ? Colors.white
                              : Colors.white),
                    ))),
              ),
            ),
        ],
      ),
    );
  }
}

/* remove the doctor from Registeration */
Function setPageFunctionType(
    {required String type, required BuildContext context, required int index}) {
  switch (type) {
    case 'appointment':
      return () => {
            context.read<AppointmentCubit>().setNextPage(
                nextPage: index,
                token: context.read<LoginCubit>().state.homeToken,
                searchParams:
                    context.read<AppointmentCubit>().state.searchParams)
          };
    case 'registration':
      return () => {
            context.read<RegisterationCubit>().setNextPage(
                nextPage: index,
                token: context.read<LoginCubit>().state.homeToken,
                searchParams:
                    context.read<RegisterationCubit>().state.searchParams)
          };

    case 'patient':
      return () => {
            context.read<PatientCubit>().setNextPage(
                nextPage: index,
                token: context.read<LoginCubit>().state.homeToken,
                searchParams: context.read<DoctorCubit>().state.searchParams)
          };
    case 'doctor':
      return () => {
            context.read<DoctorCubit>().setNextPage(
                nextPage: index,
                token: context.read<LoginCubit>().state.homeToken,
                searchParams:
                    context.read<RegisterationCubit>().state.searchParams)
          };
  }
  return () {};
}

