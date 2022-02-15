import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/features/registration/registration_cubit.dart';

import '../../features/appointment/appointment_cubit.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointments> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 241, 243),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                      'Create New Appointment',
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      //if (formKey.currentState!.validate()) {
                      //send a request to backend
                      // context.read<LoginCubitCubit>().login();
                      //}
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Search",
                        style: TextStyle(
                            color: Color.fromARGB(255, 56, 155, 152))),
                  ),
                  Container(
                    constraints:
                        const BoxConstraints(maxWidth: 350, maxHeight: 40),
                    child: TextFormField(
                      onChanged: (searchParams) => context
                          .read<AppointmentCubit>()
                          .setSearchParams(searchParams),
                      obscureText: false,
                      autofocus: true,
                      decoration: const InputDecoration(
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
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          DatePickerFeild(
                            label: 'From',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DateTimePickerFeild(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          DatePickerFeild(
                            label: 'To',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DateTimePickerFeild(),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  /*   const DatePickerFeild(),
                  const DateTimePickerFeild(), */
                  //  PatientLists(),
                  Container(
                    height: 50,
                    width: 100,
                    margin: const EdgeInsets.only(left: 15),
                    constraints: const BoxConstraints(maxWidth: 170),
                    child: ElevatedButton(
                      autofocus: true,
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 56, 155, 152)),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        context.read<AppointmentCubit>().searchAppointments();
                      },
                    ),
                  ),
                ],
              ),
            )

            //formSection()
          ],
        ),
      ),
    );
  }
}

Future datePicker(BuildContext context, String label) async {
  var dateFormat = DateFormat('yyyy-MM-dd');

  final initDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 5));

  String formattedDate = dateFormat.format(newDate!);

  // ignore: unnecessary_null_comparison
  if (newDate == null) return;
  switch (label) {
    case 'From':
      print('from');
      context.read<AppointmentCubit>().setStartDate(formattedDate);
      break;
    case 'To':
          print('from');

      context.read<AppointmentCubit>().setEndDate(formattedDate);

      break;
    default:
      break;
  }
  // String formattedDate = dateFormat.format(newDate);
  // String formattedDate = dateFormat.format(newDate);
  // context.read<AppointmentCubit>().setStartDate(formattedDate);
}

Future dateTimePicker(BuildContext context) async {
  final newTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (newTime == null) return;

  print(newTime.format(context));
}

class DateTimePickerFeild extends StatelessWidget {
  const DateTimePickerFeild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                dateTimePicker(context);
              },
              child: Container(
                height: 45,
                width: 80,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    '',
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

class DatePickerFeild extends StatelessWidget {
  const DatePickerFeild({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                datePicker(context, label);
              },
              child: Container(
                height: 45,
                width: 80,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    '',
                    style: TextStyle(fontFamily: 'poppins'),
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

class PatientLists extends StatelessWidget {
  const PatientLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            print(' was click');
            //context.read<AppointmentCubit>().searchAppointments();
          },
          child: (Container(
            child: Text('test'),
          )),
        );
      },
    );

    /*  return Container(
      child: Text('Appointments list'),
      
    ); */
  }
}

class FirstName extends StatelessWidget {
  const FirstName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("First Name"),
        ),
        TextFormField(
          onChanged: (firstname) =>
              context.read<RegistrationCubit>().setFirstName(firstname),
          obscureText: true,
          autofocus: true,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          validator: (String? value) {
            if (value!.isEmpty || value.length <= 7) {
              return 'Please enter  a validate password';
            } else {
              return null;
            }
          },
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
        TextFormField(
          onChanged: (lastname) =>
              context.read<RegistrationCubit>().setLastName(lastname),
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
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  a validate email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}
//TODO:  Date Picker

class DateOfBirth extends StatelessWidget {
  const DateOfBirth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Date Of Birth"),
        ),
        TextFormField(
          onChanged: (dateofBirth) =>
              context.read<RegistrationCubit>().setFirstName(dateofBirth),
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
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  your date of birth';
            }
            return null;
          },
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
        TextFormField(
          onChanged: (gender) =>
              context.read<RegistrationCubit>().setFirstName(gender),
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
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  a validate email address';
            }
            return null;
          },
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
        TextFormField(
          onChanged: (religion) =>
              context.read<RegistrationCubit>().setFirstName(religion),
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
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  a validate email address';
            }
            return null;
          },
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
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (educationlevel) =>
              context.read<RegistrationCubit>().setFirstName(educationlevel),
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
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  a validate email address';
            }
            return null;
          },
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
    // return BlocBuilder<LoginCubitCubit, LoginCubitState>(
    // builder: (context, state) {
    return Container(
      width: 300,
      height: 60,
      padding: const EdgeInsets.all(2),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: ElevatedButton(
          autofocus: true,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 121, 113, 234)),
          ),
          child: const Text('Conintue'),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              //send a request to backend
              // context.read<LoginCubitCubit>().login();
            }
          },
        ),
      ),
    );
    // },
    //);
  }
}

/*   Column formSection() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FirstName(),
                  SizedBox(height: 30),
                  LastName(),
                  SizedBox(height: 30),
                  DateOfBirth(),
                  SizedBox(height: 30),
                  Gender(),
                  SizedBox(height: 30),
                  Religion(),
                  SizedBox(height: 30),
                  EducationLevel(),
                  SizedBox(height: 30),
                  // Email()
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _SubmitButton(
            formKey: _formKey,
          ),
          const SizedBox(
            height: 30,
          ),
        ]);
  } */