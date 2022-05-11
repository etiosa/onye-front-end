import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/session/authSession.dart';

import '../Widgets/Button.dart';
import '../components/LoadedProfile .dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

//TODO: need to replace this with Ssimmger
class _DashboardState extends State<Dashboard> {
  final _authSession = AuthSession();

  @override
  void initState() {
    // TODO: implement initState
    //call the home again for now
    super.initState();
  }

  //call the appointment later after I am finished with everything else
  //eula last

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 253, 253),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state.loginStatus == LoginStatus.login) {
              //LOAD the  login profile
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
  context.read<LoginBloc>().add(LogOut());
  WidgetsBinding.instance?.addPostFrameCallback((_) {
    Navigator.popAndPushNamed(context, '/login');
  });
}
