import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/auth/state/login_cubit.dart';
class DashboardProfile extends StatelessWidget {
  const DashboardProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 55,
                  left: MediaQuery.of(context).size.width / 9),
              child: Text(
                '${context.read<LoginCubit>().state.firstName} ${context.read<LoginCubit>().state.lastName}',
                style: const TextStyle(fontSize: 17, fontFamily: 'poppins'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                context.read<LoginCubit>().state.department,
                style:
                    const TextStyle(color: Color.fromARGB(255, 115, 109, 109)),
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                context.read<LoginCubit>().state.hospital,
                style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
