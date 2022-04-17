import 'package:flutter/material.dart';
import 'package:onye_front_ened/Widgets/Button.dart';
class HomepageHeader extends StatelessWidget {
  const HomepageHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20, bottom: 20),
          child: Text(
            'Registrations',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Button(height: 50, width: 170, label: 'Create Registration', 
        onPressed: ()=> Navigator.of(context)
                .pushNamed('/dashboard/appointment/createRegistration'))
      ],
    );
  }
}
