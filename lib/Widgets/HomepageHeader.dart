import 'package:flutter/material.dart';
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 170,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ElevatedButton(
                autofocus: true,
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 56, 155, 152)),
                ),
                child: const Text(
                  'Create Registration',
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/dashboard/appointment/createRegistration');
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
