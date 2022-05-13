import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/session/authSession.dart';
import '../components/LoadedProfile .dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 253, 253),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state.loginStatus == LoginStatus.login) {
              return const LoadedProfile();
            } else {
              return Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.grey[500],
                    strokeWidth: 4,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 56, 155, 152)),
                  ),
                ),
              );
            }
          },
          // return Container();
        ),
      ),
    );
  }
}
