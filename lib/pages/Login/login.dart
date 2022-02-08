import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onye_front_ened/features/login_cubit/login_cubit.dart';
import 'package:onye_front_ened/pages/dashboard/dashboard.dart';

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
    context.read<LoginCubit>().home();
 
    if (context.read<LoginCubit>().state.loginStatus ||
        context.read<LoginCubit>().state.statusCode > 0) {
    
      Navigator.of(context).pushNamed("/dashboard");
    } else {
      print("login");
    }

    print('before run');
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: const Color.fromARGB(255, 247, 253, 253),
            body: Container(
              margin: const EdgeInsets.only(top: 70),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LoginText(),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Stack(children: [
                        SingleChildScrollView(child: _formSection()),
                      ]),
                    ),
                    if (context.read<LoginCubit>().state.statusCode > 0)
                      const Text('Yes')
                    else
                      const ScaffoldMessenger(child: Text('Please Login'))
                  ],
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
              context.read<LoginCubit>().setUserName(username),
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
              context.read<LoginCubit>().setPassword(password),
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

  const _SubmitButton(this.formKey) : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.loginStatus) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed("/dashboard");
          });

         // Navigator.of(context).pushNamed("/dashboard");
        } else
          print(state);
        return Container(
          width: 250,
          height: 60,
          padding: const EdgeInsets.all(2),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: ElevatedButton(
              autofocus: true,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 56, 155, 152)),
              ),
              child: const Text('Login'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  context.read<LoginCubit>().login();

                  /*   if (context.read<LoginCubit>().state.loginStatus) {
                    print("login pressed move");
                    Navigator.of(context).pushNamed("/dashboard");
                  } */
                }
              },
            ),
          ),
        );
      },
    );
  }
}
