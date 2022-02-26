import 'package:flutter/material.dart';
import 'package:onye_front_ened/pages/patient/repository/dropDownRepositories.dart';

class DropdownField extends StatefulWidget {
  DropdownField({Key? key, required this.fieldName, required this.options})
      : super(key: key);
  final String fieldName;
  final List<String> options;
  @override
  State<DropdownField> createState() => _DropdownFieldtState();
}

class _DropdownFieldtState extends State<DropdownField> {
  @override
  void initState() {
    super.initState();
    // context.read<RegistrationCubit>();
  }

  String dropdownValue = 'One';

  _DropdownFieldtState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.fieldName),
          SizedBox(
            height: 50,
            width: 400,
            child: DropdownButtonFormField<String>(
              value: dropdownValue,

              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                filled: true,
                fillColor: Color.fromARGB(255, 205, 226, 226),
              ),

              //icon: const Icon(Icons.arrow_downward),
              elevation: 1,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items:
                  widget.options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontFamily: 'poppins', fontSize: 14),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


/* 
 Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text("First Name"),
        ),
        SizedBox(
          height: 30,
          width: 320,
          child: TextFormField(
            /*   onChanged: (username) =>
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


*/
