import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/features/login_cubit/login_cubit.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(context.read<LoginCubit>().state);
          context.read<LoginCubit>().home();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 253, 253),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 6,
                  bottom: 5.0,
                  left: MediaQuery.of(context).size.width / 9),
              child: const Text("Good afternoon"),
            ), //TODO: backend login here
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 35,
                  left: MediaQuery.of(context).size.width / 9),
              child: const Text('Doctor Joe'),
            ), //TODO: backend as well
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (() => {
                        Navigator.of(context)
                            .pushNamed("/dashboard/registration")
                      }),
                  child: Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 56, 155, 152),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 40.0, left: 20),
                      child: Text(
                        'Registration',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (() => {
                        Navigator.of(context)
                            .pushNamed("/dashboard/appointment")
                      }),
                  child: Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 40.0, left: 20),
                      child: Text('Appointment'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
