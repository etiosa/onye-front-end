
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/appointment/state/appointment_cubit.dart';
import '../pages/auth/state/login_cubit.dart';

class AppointmentPagination extends StatefulWidget {
  AppointmentPagination({
    Key? key,
    required this.initPageSelected,
  }) : super(key: key) {
    // RegisterationCubit
  }

  final int? initPageSelected;

  @override
  State<AppointmentPagination> createState() =>
      _AppointmentPaginationState();
}
//search Type
//during it construtor
//return cubit based on type of search

class _AppointmentPaginationState extends State<AppointmentPagination> {
  int initPageSelected = 0;
  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 72,
      color: const Color.fromARGB(255, 56, 155, 152),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var index = 0;
              index <= context.read<AppointmentCubit>().state.maxPageNumber;
              index++)
            Container(
              margin: const EdgeInsets.only(top: 1.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    initPageSelected = index;
                  });

                  context.read<AppointmentCubit>().setNextPage(
                      nextPage: index,
                      token: context.read<LoginCubit>().state.homeToken,
                      searchParams:
                          context.read<AppointmentCubit>().state.searchParams);
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
