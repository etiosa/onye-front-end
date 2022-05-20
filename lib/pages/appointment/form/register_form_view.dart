import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';

import '../../../components/drop_down.dart';
import '../../../components/util/Modal.dart';
import '../../appointments.dart';
import 'create_appointment.dart';

class Register extends StatefulWidget {
 const  Register({Key? key, required this.formIndex}) : super(key: key);
  final int formIndex;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state.appointmentState == APPOINTMENTSTATE.inprogress) {
            Modal(
                context: context,
                modalType: '',
                inclueAction: false,
                modalBody: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Appointment In Progress'),
                    const SizedBox(height: 30),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.grey[500],
                          strokeWidth: 4,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 56, 155, 152)),
                        )),
                  ],
                ),
                progressDetails: 'Appointment In Progress');
          }

          if (state.appointmentState == APPOINTMENTSTATE.sucessful) {
            Modal(
                context: context,
                modalType: '',
                inclueAction: true,
                actionButtons: TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(true);
                      Navigator.of(context, rootNavigator: true).pop(true);
                      context.read<AppointmentCubit>().setAppointmentState();
                      context.read<AppointmentCubit>().clearState();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: ((context) => const Appointments())),
                          ModalRoute.withName('/dashboard'));
                    }),
                modalBody: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      height: 20,
                    ),
                    Text('appointment created'),
                    SizedBox(height: 30),
                    Icon(
                      Icons.check,
                      size: 100,
                      color: Color.fromARGB(255, 56, 155, 152),
                    )
                  ],
                ),
                progressDetails: 'appointment created');
          }

          if (state.appointmentState == APPOINTMENTSTATE.failed) {
            Modal(
                inclueAction: true,
                actionButtons: TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(true);
                      Navigator.of(context, rootNavigator: true).pop(true);
                      context.read<AppointmentCubit>().setAppointmentState();
                    }),
                context: context,
                modalType: 'failed',
                modalBody: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(state.appointmentError),
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.error,
                      color: Colors.redAccent,
                      size: 100,
                    )
                  ],
                ),
                progressDetails: state.appointmentError);
          }
        },
        child: RegisterField(formKey: _formKey, widget: widget));
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
                              createAppointmentData(context: context);
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
                                context.read<AppointmentCubit>().clearState();
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
