import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';

import '../../../components/DropDown.dart';
import '../../../components/util/Messages.dart';
import '../../appointments.dart';
import 'create_appointment.dart';

class Register extends StatefulWidget {
  Register({Key? key, required this.formIndex}) : super(key: key);
  int formIndex;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
      return RegisterField(formKey: _formKey, widget: widget);
    });
  }
}

class RegisterField extends StatelessWidget {
  const RegisterField({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.widget,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final Register widget;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropDown(label: 'Language Preference', options: const ['EN']),
                  const SizedBox(height: 25),
                  DropDown(
                      label: 'Type of Visit',
                      options: const ['Follow-up', 'Consultation']),
                  const SizedBox(height: 25),
                  DropDown(label: 'Reason for Visit', options: const [
                    'Headache',
                    'Follow-up',
                    'Malaria',
                    'Fever',
                    'Injection',
                    'Test Result',
                    'Lab Test',
                    'PUD',
                    'Check Up',
                    'Consultation'
                  ]),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: const [
                      DatePickerField(
                        label: 'Date',
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      DateTimePickerField(
                        label: 'Time',
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 60,
                          width: 80,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 56, 155, 152)),
                              ),
                              onPressed: () {
                                var response =
                                    createAppointmentData(context: context);

                                response?.then((value) => {
                                      if (value != null &&
                                          value.statusCode == 201)
                                        {
                                          context
                                              .read<AppointmentCubit>()
                                              .clearState(),
                                          Messages.showMessage(
                                              const Icon(
                                                IconData(0xf635,
                                                    fontFamily:
                                                        'MaterialIcons'),
                                                color: Colors.green,
                                              ),
                                              'Appointment created'),
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          const Appointments())),
                                                  ModalRoute.withName(
                                                      '/dashboard'))
                                        }
                                      else if (value != null &&
                                          value.statusCode == 400)
                                        {
                                          Messages.showMessage(
                                              const Icon(
                                                IconData(0xe237,
                                                    fontFamily:
                                                        'MaterialIcons'),
                                                color: Colors.red,
                                              ),
                                              'Could not create appointment'),
                                        }
                                    });
                              },
                              child: const Text('Submit')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 60,
                          width: 80,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 129, 175, 174)),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const Appointments())),
                                    ModalRoute.withName(
                                        '/dashboard/appointment'));
                              },
                              child: const Text("Cancel")),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ]);
  }
}
