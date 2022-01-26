import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Schedule"),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    print("upcoming");
                  },
                  child: const Text("Upcoming")),
                  ElevatedButton(
                  onPressed: () {
                    print("upcoming");
                  },
                  child: const Text("Upcoming")),
                  ElevatedButton(
                  onPressed: () {
                    print("upcoming");
                  },
                  child: const Text("Upcoming"))
            ],
            
          ),
          Text("Current Vist"),

          Column(children: [
            Container(
              width: 100,
              height:100,
              color: Colors.amber,
            )
          ],)
        
        ],
      ),
    ));
  }
}
