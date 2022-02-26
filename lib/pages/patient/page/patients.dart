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
      backgroundColor: const Color.fromARGB(255, 252, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, right: 30),
                height: 50,
                width: 200,
                color: const Color.fromARGB(255, 56, 155, 152),
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 56, 155, 152)),
                    ),
                    onPressed: () {
                    },
                    child: const Text('Register Patient')),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20),
            child: Text("Search"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextFormField(
                  /*    onChanged: (username) =>
                      context.read<LoginCubit>().setUserName(username), */
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Color.fromARGB(255, 205, 226, 226),
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
              Container(
                width: 80,
                height: 60,
                padding: const EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ElevatedButton(
                    autofocus: true,
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 56, 155, 152)),
                    ),
                    child: const Text('Search'),
                    onPressed: () async {
                      /*  if (formKey.currentState!.validate()) {
                  context.read<LoginCubit>().login();
                } */
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width / 1.05,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes positi
                  ), //BoxShadow
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: const [
                            Text(
                              'Jean Joe',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text('02/22/2022')
                          ],
                        ),
                        Column(
                          children: const [
                            Text('Patient number'),
                            SizedBox(height: 20),
                            Text('1111')
                          ],
                        )
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

