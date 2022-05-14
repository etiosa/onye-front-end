import 'package:flutter/material.dart';
import 'package:onye_front_ened/Widgets/Button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  
}

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
              Button(
                  height: 70,
                  width: 200,
                  label: 'Login',
                  onPressed: () => Navigator.of(context).pushNamed("/login"))
            ],
          ),
        ),
      ),
    );
  }
}

void test({BuildContext? context}) async {
  Navigator.of(context!).pushNamed("/login");
}
