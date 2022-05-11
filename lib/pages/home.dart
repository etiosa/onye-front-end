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
    //. Note: hours are specified between 0 and 23, as in a 24-hour
    print(DateTime.now().toLocal().hour);
    print(DateTime.now().toLocal().minute);
    var currentTime = DateTime.now().toLocal().hour;
    print(currentTime);
    if (currentTime <= 0 && currentTime <= 11) {
      print('Morning');
    }

    if (currentTime >= 12 && currentTime <= 18) {
      print("aftertNoon");
    }

    if (currentTime > 18 && currentTime <= 24) {
      print("evening");
    }
    //if the hour is between 00:00 abd 18
    //if  between 12am and 11:59pm morning
    //if 1s between 12pm - 6pm ;; Afternoon
    //if 6pm and more  is evening

    //print(DateTime.now().compareTo());
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
