import 'package:flutter/material.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            const Padding(
              padding: EdgeInsets.only(top:15.0, left: 20),
              child: Text(
                "patient id",
                style: TextStyle(
                  color: Color.fromARGB(255, 56, 155, 152),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: SizedBox(
                width: 320,
                height: 50,
                child: TextFormField(
                 readOnly: true,
                 initialValue: 'patient id',
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
            ),
        ],
      ),
               Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0, left: 20),
                child: Text(
                  "phone number",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 155, 152),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextFormField(
                    readOnly: true,
                    initialValue: 'patient id',
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
              ),
            ],
        ),
               Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0, left: 20),
                child: Text(
                  "Date of birth",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 155, 152),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextFormField(
                    readOnly: true,
                    initialValue: 'patient id',
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
              ),
            ],
        ),
               Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0, left: 20),
                child: Text(
                  "Gender",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 155, 152),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextFormField(
                    readOnly: true,
                    initialValue: 'patient id',
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
              ),
            ],
        ),
               Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0, left: 20),
                child: Text(
                  "Relgion",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 155, 152),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextFormField(
                    readOnly: true,
                    initialValue: 'Education',
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
              ),
            ],
        ),
      
                   
                   
                 
            ]),
          )),
    );
  }
}
