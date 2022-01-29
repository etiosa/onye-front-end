import 'package:flutter/material.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         child: Column(
           children: [
              Row(children: [
                Text('Image'),
                Column(children: [
                  Text('name'),
                  Text("address"),
                  Text("phone number")
                ],)
              ],),
              ElevatedButton(onPressed: (){}, child: const Text("Registration")),
              ElevatedButton(onPressed: () {}, child: const Text("Patients")),
              ElevatedButton(onPressed: (){}, child: const Text("Schedule"))
              
           ],
         ),
      ),
    );
  }
}