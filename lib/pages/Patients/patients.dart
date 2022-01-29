import 'package:flutter/material.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({Key? key}) : super(key: key);

  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 239, 241, 243),
          body: SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(00.0),
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0, left: 15),
                    child: Text("Paitent"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    /*   onChanged: (username) =>
                  context.read<LoginCubit>().setUserName(username), */
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
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      print("search");
                    },
                    child: const Text("Search"))
              ],
            ),
          )),
    );
  }
}
