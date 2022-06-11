import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/session/auth_session.dart';
import 'package:onye_front_ened/util/util.dart';
import '../components/loaded_profile .dart';
import '../components/util/modal.dart';
import 'auth/repository/auth_repositories.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}
//TODO: check Navigator

class _DashboardState extends State<Dashboard> {
  //final _authSession = AuthSession();

  @override
  void initState() {
    // TODO: implement initState
    //call the home again for now
    super.initState();
    final AuthSession authsession = AuthSession();

    if (Util.hasTokenExpired()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Modal(
            inclueAction: true,
            actionButtons: TextButton(
                child: const Text('Close'),
                onPressed: () {
                  //Navigator.of(context, rootNavigator: true).pop(true);

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
      });
    }
  }

//TODO: have it's own bloc
//it will
//CHANGE THIS
  @override
  Widget build(BuildContext context) {
    final AuthSession authsession = AuthSession();

    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 247, 253, 253),
            body: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                authsession.getHomeToken()?.then((value) async {
                  if (value.isEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed("/login");
                    });
                  }
                });
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: ((context, state) {
                  return const LoadedProfile();
                }),
              ),
            )));
  }
}
