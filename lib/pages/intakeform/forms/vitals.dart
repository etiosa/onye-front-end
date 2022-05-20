import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:onye_front_ened/Widgets/button.dart';

class Vitals extends StatelessWidget {
  const Vitals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
       SizedBox(
         width: 300,
        // height: 100,
         child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Height",
                style: TextStyle(color: Color.fromARGB(255, 56, 155, 152))),
          ),
          TextFormField(
           /*  onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)), */
            obscureText: true,
            autofocus: true,
            decoration: const InputDecoration(
              isDense: false,
              filled: true,
              fillColor: Color.fromARGB(255, 205, 226, 226),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a valid password';
              } else {
                return null;
              }
            },
          ),
      ],
    ),
       ),
       SizedBox(height: 10,),
         SizedBox(
         width: 300,
      //   height: 100,
         child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Weight",
                style: TextStyle(color: Color.fromARGB(255, 56, 155, 152))),
          ),
          TextFormField(
            
           /*  onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)), */
            obscureText: true,
            autofocus: true,
            decoration: const InputDecoration(
              isDense: false,
              filled: true,
              fillColor: Color.fromARGB(255, 205, 226, 226),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a valid password';
              } else {
                return null;
              }
            },
          ),
      ],
    ),
       ),
       SizedBox(
          width: 300,
        //  height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Pulse",
                    style: TextStyle(color: Color.fromARGB(255, 56, 155, 152))),
              ),
              TextFormField(
                
                /*  onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)), */
                obscureText: true,
                autofocus: true,
                decoration: const InputDecoration(
                  isDense: false,
                  filled: true,
                  fillColor: Color.fromARGB(255, 205, 226, 226),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid password';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
          SizedBox(
          width: 300,
          //  height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Blood Pressure",
                    style: TextStyle(color: Color.fromARGB(255, 56, 155, 152))),
              ),
              TextFormField(
                /*  onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)), */
                obscureText: true,
                autofocus: true,
                decoration: const InputDecoration(
                  isDense: false,
                  filled: true,
                  fillColor: Color.fromARGB(255, 205, 226, 226),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid password';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),

      ]),
    );
  }
}


