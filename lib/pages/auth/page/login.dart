import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/button.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/components/util/Modal.dart';

import '../../eula/state/eula_bloc.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: const Color.fromARGB(255, 247, 253, 253),
            body: BlocListener<LoginBloc, LoginState>(
              listenWhen: ((previous, current) =>
                  previous.loginStatus != current.loginStatus),
              listener: (context, state) {
                if (state.loginStatus == LoginStatus.home &&
                    state.isContractAccept) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) async {
                    //  await FirebaseAnalytics.instance.setUserId(id: state.userId);

                    // Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/dashboard");
                    //  Navigator.popAndPushNamed(context, '/dashboard');
                    // Navigator.pushReplacementNamed(context, '/dashboard');
                    //Navigator.pushUntil(context, ModalRoute.withName('/dashboard'));
                    //Navigator.popAndPushNamed(context, '/dashboard');
                    //  Navigator.pushReplacementNamed(context, '/dashboard');

/* Navigator.of(context).pushNamedAndRemoveUntil(
                        '/dashboard', (Route<dynamic> route) => false); */
                    /*  Navigator.pushAndRemoveUntil(
                        context, '/dashboard', (route) => false); */
                  });
                }
                //if we canLogin..move to the next page.
                if (state.loginStatus == LoginStatus.home &&
                    !state.isContractAccept) {
                  context
                      .read<EulaBloc>()
                      .add(LoadBetaContract(token: state.homeToken));

                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/beta-contract");
                  });
                }

                if (state.loginStatus == LoginStatus.inprogress) {
                  Modal(
                      context: context,
                      modalType: '',
                      inclueAction: false,
                      modalBody: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Login In Progress'),
                          const SizedBox(height: 30),
                          SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.grey[500],
                                strokeWidth: 4,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color.fromARGB(255, 56, 155, 152)),
                              )),
                        ],
                      ),
                      progressDetails: 'progrss');
                }
                if (state.loginStatus == LoginStatus.failed) {
                  Modal(
                      inclueAction: true,
                      actionButtons: TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(true);
                            Navigator.of(context, rootNavigator: true)
                                .pop(true);
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
                          Text("username/password is incorrect"),
                          SizedBox(height: 20),
                          Icon(
                            Icons.error,
                            color: Colors.redAccent,
                            size: 100,
                          )
                        ],
                      ),
                      progressDetails: "username/password is incorrect");
                }
                if (state.loginStatus == LoginStatus.unknown) {
                  Modal(
                      context: context,
                      modalType: 'Unkown',
                      inclueAction: true,
                      actionButtons: TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(true);
                            Navigator.of(context, rootNavigator: true)
                                .pop(true);
                          }),
                      modalBody: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          SizedBox(
                            height: 40,
                          ),
                          Text('Please enter a valid username/password'),
                          SizedBox(height: 20),
                          Icon(
                            Icons.dangerous,
                            color: Colors.redAccent,
                            size: 100,
                          )
                        ],
                      ),
                      progressDetails:
                          'Please enter a valid username/password');
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 70),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _LoginText(),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(children: [
                          _formSection(),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  Column _formSection() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Username(),
                  SizedBox(height: 20),
                  _Password(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _SubmitButton(_formKey),
          const SizedBox(
            height: 30,
          ),
        ]);
  }
}

class _LoginText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset(
        'assets/images/onye.png',
        fit: BoxFit.contain,
        height: 100,
      ),
    );
  }
}

// ignore: must_be_immutable
class _Username extends StatelessWidget {
  const _Username({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            "Username",
            style: TextStyle(
              color: Color.fromARGB(255, 56, 155, 152),
            ),
          ),
        ),
        TextFormField(
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUserNameChanged(username)),
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
              return 'Please enter a valid username';
            }
            return null;
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _Password extends StatelessWidget {
  const _Password({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Password",
              style: TextStyle(color: Color.fromARGB(255, 56, 155, 152))),
        ),
        TextFormField(
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          autofocus: true,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 205, 226, 226),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Please enter a valid password';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  //final _authSession = AuthSession();

  const _SubmitButton(this.formKey) : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Button(
        height: 60,
        width: 250,
        onPressed: () => login(context: context, formKey: formKey),
        label: 'Login',
      );
    });
  }
}

void login(
    {required BuildContext context,
    required GlobalKey<FormState> formKey}) async {
  if (formKey.currentState!.validate()) {
    context.read<LoginBloc>().add(const Login());
  }
}
