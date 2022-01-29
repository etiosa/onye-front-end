import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 239, 241, 243),
      body: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Image'),
                const SizedBox(height: 15),
              const Text('Build better relationships', style: TextStyle(fontSize: 20),),
              const SizedBox( height:15),
            Container(
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
                 onPressed: () {  },
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
