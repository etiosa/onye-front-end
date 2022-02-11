import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/UI/DropDown.dart';
import 'package:onye_front_ened/features/registration/registration_cubit.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

//TODO: Refactor
class _RegistrationFormState extends State<RegistrationForm> {
  DateTime? _dateTime;
    int _index = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20),
              child: Text(
                "Registration",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width / 1.05,
                child: Stepper(
                  elevation: 0,
                  type: StepperType.horizontal,
                  currentStep: _index,
                  onStepCancel: () {
                    if (_index > 0) {
                      setState(() {
                        _index -= 1;
                      });
                    }
                  },
                  onStepContinue: () {
                    if (_index <= 0) {
                      setState(() {
                        _index += 1;
                      });
                    }
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  steps: <Step>[
                    Step(
                      state: StepState.editing,
                      title: const Text(''),
                      content: formSection()
                    ),
                    const Step(
                      state: StepState.complete,
                      isActive: true,
                      title: Text(''),
                      content: Text('Content for Step 2'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    Column formSection() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const FirstName(),
                  const SizedBox(height: 25),
                 const LastName(),
                  const SizedBox(height: 25),
                  //DateOfBirth(),
                
                  DropdownField(
                    fieldName: 'Gender',
                  ),
                 const  SizedBox(height: 25),
                  DropdownField(
                    fieldName: 'Reigion',
                  ),
                  const SizedBox(height: 25),
                      DropdownField(
                    fieldName: 'Education Level',
                  ),
                  const SizedBox(height: 25),
                  // Email()
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
       /*    _SubmitButton(
            formKey: _formKey,
          ),
          const SizedBox(
            height: 30,
          ), */
        ]);
  }
}


class FirstName extends StatelessWidget {
  const FirstName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text("First Name"),
        ),
        SizedBox(
          height: 45,
          width: 400,
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
      ],
    );
  }
}

class LastName extends StatelessWidget {
  const LastName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Last Name"),
        ),
        SizedBox(
          height: 50,
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
      ],
    );
  }
}
//TODO: Drop down
class Gender extends StatelessWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Gender"),
        ),
        SizedBox(
          height: 35,
          width: MediaQuery.of(context).size.width / 1.2,
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
      ],
    );
  }
}

//TODO: Drop down

class Religion extends StatelessWidget {
  const Religion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Religion"),
        ),
        SizedBox(
          height: 35,
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
      ],
    );
  }
}

//TODO: Drop down
class EducationLevel extends StatelessWidget {
  const EducationLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Education Level"),
        ),
        SizedBox(
          height: 35,
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
      ],
    );
  }
}
class _SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _SubmitButton({required this.formKey}) : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
      return Container(
        width: 250,
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
            child: const Text('Login'),
            onPressed: () async {
              /*  if (formKey.currentState!.validate()) {
                context.read<LoginCubit>().login();
              } */
            },
          ),
        ),
      );
    });
  }
}
/* 


 Center(
        child: OutlinedButton(
          onPressed: () async {
            _dateTime = (await showDatePicker(
              
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2025)))!;
          },
          child: const Text('Open Date Picker'),
        ),
      ),









 */


//    context.read<RegistrationCubit>().register();