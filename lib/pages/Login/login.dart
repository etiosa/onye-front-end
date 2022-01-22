import 'package:flutter/material.dart';

// ignore: camel_case_types
class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  _login_pageState createState() => _login_pageState();
}

// ignore: camel_case_types
class _login_pageState extends State<login_page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    const login_text(),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Stack(children: [
                    SingleChildScrollView(child: form_section()),
                      ]),
                    ),
                  ],
                ),
              ),
            )));
  }

  // ignore: non_constant_identifier_names
  Column form_section() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Email(),
                  const SizedBox(height: 20),
                  Password(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _Submit_button(
            formKey: _formKey,
          ),
          const SizedBox(
            height: 30,
          ),
        ]);
  }

  
}

// ignore: camel_case_types
class _Submit_button extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _Submit_button({required this.formKey}) : super();

  @override
  Widget build(BuildContext context) {
    //  return BlocBuilder<LoginCubitCubit, LoginCubitState>(
    // builder: (context, state) {
    return Container(
      width: 300,
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
          onPressed: () {
            if (formKey.currentState!.validate()) {
              //send a request to backend
              /*  context.read<LoginCubitCubit>().login(); */
            }
          },
        ),
      ),
    );
    //  },
    //  );
    // }
  }
}

// ignore: use_key_in_widget_constructors
class Password extends StatelessWidget {
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
          /*   onChanged: (password) =>
              context.read<LoginCubitCubit>().setPassword(password), */
          obscureText: true,
          autofocus: true,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Please enter a validate password';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class login_text extends StatelessWidget {
  const login_text({
    Key? key,
  }) : super(key: key);

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

class Email extends StatelessWidget {
  const Email({
    Key? key,
  }) : super(key: key);

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
          /*  onChanged: (email) => context.read<LoginCubitCubit>().setEmail(email), */
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
              return 'Please enter a valid Username';
            }
            return null;
          },
        ),
      ],
    );
  }
}
