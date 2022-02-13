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
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegistrationCubit>().setEducationLevel();
    context.read<RegistrationCubit>().setGender();
    context.read<RegistrationCubit>().setReligion();
  }

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
                  steps: const <Step>[
                    Step(
                        state: StepState.editing,
                        title: Text(''),
                        content: FormBody()),
                    Step(
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

  Future datePicker(BuildContext context) async {
    final initDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initDate,
        firstDate: DateTime(1970),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) return;
    context
        .read<RegistrationCubit>()
        .setDateofBirth(newDate.toString().split(' ')[0]);
  }


}

class FormBody extends StatefulWidget {
  const FormBody({
    Key? key,
  }) : super();

  @override
  State<FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
      print(state);
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
                  children: [
                    const FirstName(),
                    const SizedBox(height: 25),
                    const LastName(),
                    const SizedBox(height: 25),
                    const DatePickerFeild(),
                    const SizedBox(height: 25),
                    DropdownField(
                      fieldName: 'Gender',
                      options: state.gender,
                    ),
                    const SizedBox(height: 25),
                    DropdownField(
                      fieldName: 'Reigion',
                      options: state.religion,
                    ),
                    const SizedBox(height: 25),
                    DropdownField(
                      fieldName: 'Education Level',
                      options: state.educationLevel,
                    ),
                    const SizedBox(height: 25),
                    // Email()
                  ],
                ),
              ),
            ),
            /*     const SizedBox(
            height: 20,
          ), */
            /*    _SubmitButton(
            formKey: _formKey,
          ),
          const SizedBox(
            height: 30,
          ), */
          ]);
    });
  }
}

class DatePickerFeild extends StatelessWidget {
  const DatePickerFeild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date of birth',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                _RegistrationFormState().datePicker(context);
              },
              child: Container(
                height: 45,
                width: 400,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    state.dateOfBirth,
                    style: const TextStyle(fontFamily: 'poppins'),
                  ),
                ),
              ),
            )
          ],
        ));
      },
    );
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





//    context.read<RegistrationCubit>().register();