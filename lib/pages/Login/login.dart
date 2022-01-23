import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: const Color.fromARGB(255, 239, 241, 243),
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
                children: [
                  _Username.withController(usernameController),
                  const SizedBox(height: 20),
                  _Password.withController(passwordController),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _SubmitButton(
            formKey: _formKey,
            usernameController: usernameController,
            passwordController: passwordController,
          ),
          const SizedBox(
            height: 30,
          ),
        ]);
  }
}

class _LoginText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        'Onye ',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 67, 83, 109)),
      ),
    );
  }
}

// ignore: must_be_immutable
class _Username extends StatelessWidget {
  _Username({
    Key? key,
  }) : super(key: key);

  late TextEditingController controller;

  _Username.withController(TextEditingController usernameController) {
    controller = usernameController;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Username"),
        ),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
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
  _Password({
    Key? key,
  }) : super(key: key);

  late TextEditingController controller;

  _Password.withController(TextEditingController passwordController) {
    controller = passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Password"),
        ),
        TextFormField(
          controller: controller,
          obscureText: true,
          autofocus: true,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
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
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const _SubmitButton(
      {required this.formKey,
      required this.usernameController,
      required this.passwordController})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
      padding: const EdgeInsets.all(2),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: ElevatedButton(
          autofocus: true,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 121, 113, 234)),
          ),
          child: const Text('Login'),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              // TODO send a request to backend
              print(usernameController.text);
              print(passwordController.text);
            }
          },
        ),
      ),
    );
  }
}
