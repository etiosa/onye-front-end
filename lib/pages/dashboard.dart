import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/session/authSession.dart';
import '../components/LoadedProfile .dart';
import '../components/util/Modal.dart';
import 'auth/repository/auth_repositories.dart';

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
    final AuthSession authsession = AuthSession();

    var hometoken;
    if (context.read<LoginBloc>().state.loginStatus != LoginStatus.home) {
      final AuthRepository _authRepository = AuthRepository();
      final LoginBloc _loginbloc = LoginBloc(_authRepository);
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        authsession.getHomeToken()?.then((value) async {
          hometoken = value;
          var res = _loginbloc.home(homeToken: value);
          res.then((res) {
            if (res.statusCode != 200) {
              Modal(
                  inclueAction: true,
                  actionButtons: TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                        Navigator.of(context).pushNamed("/login");
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
                      Text('Token expires, relogin'),
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
          });
        });
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 247, 253, 253),
            body: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
             
                if (state.loginStatus == LoginStatus.init) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamed("/login");
                  });
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: ((context, state) {
                  return const LoadedProfile();
                }),
              ),
            )));
  }
  // return Container();

}


/*
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
              ); */