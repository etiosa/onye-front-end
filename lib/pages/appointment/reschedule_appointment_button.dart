import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/pages/appointment/appointment_datepicker_field.dart';
import 'package:onye_front_ened/pages/appointment/appointment_dropdown.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';

import '../../session/auth_session.dart';
import '../appointment_datetimepicker_field.dart';
import '../appointments.dart';

class RescheduleAppointmentButton extends StatelessWidget {
  RescheduleAppointmentButton({Key? key, required this.appointment})
      : super(key: key);

  dynamic appointment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 50,
        width: 130,
        child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 56, 155, 152)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
            onPressed: () {
              var dateFormat = DateFormat('yyyy-MM-dd');
              String? date =
                  dateFormat.format(DateTime.parse(appointment['dateTime']));
              String? time = TimeOfDay.fromDateTime(
                      DateTime.parse(appointment['dateTime']))
                  .format(context);

              context.read<AppointmentCubit>().setAppointmentDate(date);
              context.read<AppointmentCubit>().setAppointmentTime(time);
              showDialogConfirmation(context, appointment);
            },
            child: const Text('Edit')),
      ),
    );
  }

  Future<String?> showDialogConfirmation(
      BuildContext context, dynamic appointment) {
    final AuthSession authsession = AuthSession();
    dynamic homeToken;

    authsession.getHomeToken()?.then((value) => homeToken = value);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Edit appointment'),
        actions: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              AppointmentDropDown(
                  label: 'Language Preference',
                  initialValue: 'EN',
                  options: const ['EN']),
              const SizedBox(height: 25),
              AppointmentDropDown(
                  label: 'Type of Visit',
                  initialValue: appointment['typeOfVisit'],
                  options: const ['Follow-up', 'Consultation']),
              const SizedBox(height: 25),
              AppointmentDropDown(
                  label: 'Reason for Visit',
                  initialValue: appointment['reasonForVisit'],
                  options: const [
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
                  AppointmentDatePickerField(
                    label: 'Date',
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  AppointmentDateTimePickerField(
                    label: 'Time',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              TextButton(
                onPressed: () => {
                  Navigator.pop(context, 'Cancel'),
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    var response =
                        context.read<AppointmentCubit>().updateAppointment(
                              id: appointment['id'],
                              date: context
                                  .read<AppointmentCubit>()
                                  .state
                                  .appointmentDate,
                              time: context
                                  .read<AppointmentCubit>()
                                  .state
                                  .appointmentTime,
                              languagePreference: 'en',
                              typeOfVisit: context
                                  .read<AppointmentCubit>()
                                  .state
                                  .typeOfVisit,
                              reasonForVisit: context
                                  .read<AppointmentCubit>()
                                  .state
                                  .reasonForVisit,
                              token: homeToken,
                            );

                    response.then((value) => {
                          if (value != null && value.statusCode == 202)
                            {
                              context.read<AppointmentCubit>().clearState(),
                              /* Messages.showMessage(
                                  const Icon(
                                    IconData(0xf635,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.green,
                                  ),
                                  'Appointment updated'), */
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const Appointments())),
                                  ModalRoute.withName('/dashboard'))
                            }
                          else if (value != null && value.statusCode == 400)
                            {
                              /*  Messages.showMessage(
                                  const Icon(
                                    IconData(0xe237,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.red,
                                  ),
                                  'Could not update appointment'), */
                            }
                        });
                  },
                  child: const Text('Save')),
            ],
          ),
        ],
      ),
    );
  }
}
