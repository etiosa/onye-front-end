import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 253, 253),
      body: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              Image.asset(
                'assets/images/onye.png',
                fit: BoxFit.contain,
                height: 100,
              ),
              const SizedBox(height: 100),
              const Text(
                'Build better relationships',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 56, 155, 152)),
              ),
              const SizedBox(height: 100),
              Container(
                width: 200,
                height: 70,
                margin: const EdgeInsets.only(bottom: 120),
                padding: const EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    autofocus: true,
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 56, 155, 152)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/login");
                    },
                    child: const Text('Login'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
