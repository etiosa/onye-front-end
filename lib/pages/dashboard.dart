import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';

import '../components/util/Messages.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _authSession = AuthSession();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Messages.showMessage(
        const Icon(
          IconData(0xf635, fontFamily: 'MaterialIcons'),
          color: Colors.green,
        ),
        'Login successful');
  }

//TODO: Change the Button Structure to GridView
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 253, 253),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 100,
                height: 50,
                padding: const EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ElevatedButton(
                    autofocus: true,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                        // borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                            color: Color.fromARGB(255, 56, 155, 152)),
                      )),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: const Text(
                      'Logout',
                      style:
                          TextStyle(color: Color.fromARGB(255, 56, 155, 152)),
                    ),
                    onPressed: () async {
                    /*   final  homeToken =
                          _authSession.getHomeToken();
                      homeToken.then((homeToken) =>
                      context.read<LoginCubit>().logout(token: homeToken)
                      ); */
                      // context.read<LoginCubit>().logout(token: homeToken);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 6,
                  bottom: 1.0,
                  left: MediaQuery.of(context).size.width / 9),
              child: const Text(
                "Good afternoon",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            //TODO: backend login here
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

            //TODO: backend as well
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (() =>
                      {Navigator.of(context).pushNamed("/dashboard/checkin")}),
                  child: Container(
                    height: 120,
                    width: 150,
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
                    height: 120,
                    width: 150,
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
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: (() => {
                      Navigator.of(context)
                          .pushNamed("/dashboard/registrationForm")
                    }),
                child: Container(
                  height: 120,
                  width: 150,
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
                    child: Text('Create a Patient'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
