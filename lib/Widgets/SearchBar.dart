
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/appointment/state/appointment_cubit.dart';
import '../pages/auth/state/login_cubit.dart';


class SearchBar extends StatelessWidget {
  SearchBar({Key? key, required this.formIndex, required this.field})
      : super(key: key);
  int formIndex;
  String field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Text(field),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (query) => {
              context.read<AppointmentCubit>().setSearchParams(query),
            },
            onFieldSubmitted: (query) => {
              if (field == 'Search patient')
                {
                  context.read<AppointmentCubit>().searchPatients(
                      query: query,
                      token: context.read<LoginCubit>().state.homeToken)
                },
              if (field == 'Search doctor')
                {
                  context.read<AppointmentCubit>().searchDoctors(
                      query: query,
                      token: context.read<LoginCubit>().state.homeToken)
                },
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a valid search query';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 50,
            width: 100,
            constraints: const BoxConstraints(maxWidth: 170),
            child: ElevatedButton(
              autofocus: true,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 56, 155, 152)),
              ),
              child: const Text(
                'Searchss',
                style: TextStyle(fontSize: 12),
              ),
              onPressed: () {
                if (field == 'Search patient') {
                  context.read<AppointmentCubit>().searchPatients(
                      query:
                          context.read<AppointmentCubit>().state.searchParams,
                      token: context.read<LoginCubit>().state.homeToken);
                }
                if (field == 'Search doctor') {
                  context.read<AppointmentCubit>().searchDoctors(
                      query:
                          context.read<AppointmentCubit>().state.searchParams,
                      token: context.read<LoginCubit>().state.homeToken);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
