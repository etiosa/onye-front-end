import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/Button.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/session/auth_session.dart';

import '../components/util/Modal.dart';
import '../pages/auth/state/login_bloc.dart';
import '../pages/doctor/state/doctor_cubit_cubit.dart';
import '../pages/patient/state/patient_cubit.dart';
import '../pages/registration/state/registration_cubit.dart';
import '../util/util.dart';

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
  int currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: const Color.fromARGB(255, 56, 155, 152),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: currentPage <= 0
                ? null
                : () {
                    currentPage = currentPage - 1;
                    var setPage = setPageFunctionType(
                        type: widget.typeofSearch,
                        context: context,
                        index: currentPage);
                    setPage();
                  },
            child: Text("Prev",
                style: TextStyle(
                    color: currentPage <= 0 ? Colors.grey : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          InkWell(
            onTap: widget.maxPageCounter - 1 > currentPage
                ? () {
                    setState(() {
                      currentPage = currentPage + 1;
                    });
                    var setPage = setPageFunctionType(
                        type: widget.typeofSearch,
                        context: context,
                        index: currentPage);
                    setPage();
                  }
                : null,
            child: Text(
              "Next",
              style: TextStyle(
                  color: currentPage >= widget.maxPageCounter - 1
                      ? Colors.grey
                      : Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

/* remove the doctor from Registeration */
Function setPageFunctionType(
    {required String type, required BuildContext context, required int index}) {
  final AuthSession authsession = AuthSession();
  if (Util.hasTokenExpired()) {
    Modal(
        inclueAction: true,
        actionButtons: TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/login'));
              //Navigator.of(context).pushNamed("/login");
            }),
        context: context,
        modalType: 'failed',
        modalBody: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              height: 40,
            ),
            Text('Token expires, please relogin'),
            SizedBox(height: 20),
            Icon(
              Icons.error,
              color: Colors.redAccent,
              size: 100,
            )
          ],
        ),
        progressDetails: 'relogin');
  }
  switch (type) {
    case 'appointment':
      return () => {
            authsession.getHomeToken()?.then((value) async {
              context.read<AppointmentCubit>().setNextPage(
                  nextPage: index,
                  token: value,
                  searchParams:
                      context.read<AppointmentCubit>().state.searchParams);
            }),
          };
    case 'registration':
      return () => {
            authsession.getHomeToken()?.then((value) async {
              context.read<RegisterationCubit>().setNextPage(
                  nextPage: index,
                  token: value,
                  searchParams:
                      context.read<RegisterationCubit>().state.searchParams);
            }),
          };

    case 'patient':
      return () => {
            authsession.getHomeToken()?.then((value) async {
              context.read<PatientCubit>().setNextPage(
                  nextPage: index,
                  token: value,
                  searchParams: context.read<DoctorCubit>().state.searchParams);
            }),
          };
    case 'doctor':
      return () => {
            authsession.getHomeToken()?.then((value) async {
              context.read<DoctorCubit>().setNextPage(
                  nextPage: index,
                  token: value,
                  searchParams:
                      context.read<RegisterationCubit>().state.searchParams);
            }),
          };
  }
  return () {};
}
