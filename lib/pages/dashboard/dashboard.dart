import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/features/login_cubit/login_cubit.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*   context
        .read<LoginCubit>()
        .home(tokens: context.read<LoginCubit>().state.loginToken); */
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 253, 253),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: const Text(
                'Doctor Joe John',
                style: TextStyle(fontSize: 17, fontFamily: 'poppins'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                'Surgery',
                style: TextStyle(color: Color.fromARGB(255, 115, 109, 109)),
              ),
            ),
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                'St. Hopkins Hospital',
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 40.0,
              ),
              child: Text(
                '010-444 444',
                style: TextStyle(fontFamily: 'poppins', fontSize: 15),
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
