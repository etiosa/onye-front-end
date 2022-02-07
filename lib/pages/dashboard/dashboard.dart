import 'package:flutter/material.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         child: Column(
                children: [ 
                  Text("Good afternoon"),    //TODO: backend login here
                  Text('Doctor Joe') //TODO: backend as well
                ],
         ),
      ),
    );
  }
}