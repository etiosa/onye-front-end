import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/session/authSession.dart';

import '../Widgets/Button.dart';
import '../components/DashboardMenuItem.dart';
import '../components/DashboardProfile.dart';
import '../components/util/Modal.dart';

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
    //call the home again for now
    super.initState();
  }

//TODO: Change the Button Structure to GridView
  @override
  Widget build(BuildContext context) {
    print("twice");
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 253, 253),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Logout(),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 6,
                    bottom: 1.0,
                    left: MediaQuery.of(context).size.width / 9),
                child: const Text(
                  "Good afternoon", //take the user syste, current time ....base on that display greeting
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              //TODO: backend login here

              const DashboardProfile(),

              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),

              const DashboardMenuItem(),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: (() =>
                      {Navigator.of(context).pushNamed("/dashboard/patient")}),
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
                      child: Text('Patients'),
                    ),
                  ),
                ),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///return BlocBuilder<LoginBloc, LoginState>(
    // buildWhen: (previous, current) =>
    //  current.loginStatus != previous.loginStatus,
    //  builder: (context, state) {
    final _authSession = AuthSession();
    _authSession.getHomeToken()!.then((value) => {
          if (value == '')
            {
              // Navigator.of(context).pop(),
              print("auth session is emopty"),
              /*    Messages.showMessage(
                        const Icon(
                          IconData(0xf635, fontFamily: 'MaterialIcons'),
                          color: Colors.green,
                        ),
                        Navigator.of(context).pushNamed("/login");
                /*         'Logout successful from dashboard'), */
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed("/login");
                    }) */
            }
        });

    return Button(
        height: 60,
        width: 100,
        label: "Logout",
        onPressed: () async {
          logout(context);
        });
    // });
  }
}

void logout(BuildContext context) async {
  print("logot");
  context.read<LoginBloc>().add(LogOut());
  WidgetsBinding.instance?.addPostFrameCallback((_) {
    Navigator.popAndPushNamed(context, '/login');
  });
}
