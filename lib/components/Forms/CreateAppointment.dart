import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:onye_front_ened/components/util/Messages.dart';
import 'package:onye_front_ened/features/appointment/appointment_cubit.dart';
import 'package:onye_front_ened/features/login_cubit/login_cubit.dart';
import 'package:onye_front_ened/pages/appointment/Appointments.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

//TODO: Refactor
class _CreateAppointmentState extends State<CreateAppointment> {
  int _index = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*   if (context.read<LoginCubit>().state.homeToken.isEmpty) {
      //redirect to home
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/");
      });
    } */
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
                "Create Appointment",
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
                    if (_index < 2) {
                      setState(() {
                        _index += 1;
                      });
                    }
                  },
                  controlsBuilder: (context, details) {
                    return (Row(
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
                                      details.currentStep == 2
                                          ? Colors.transparent
                                          : const Color.fromARGB(
                                              255, 56, 155, 152)),
                                ),
                                onPressed: details.onStepContinue,
                                child: Text(
                                    details.currentStep == 2 ? '' : 'Next')),
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
                                      Colors.transparent),
                                ),
                                onPressed: details.onStepCancel,
                                child: const Text(
                                  'cancel',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ),
                      ],
                    ));
                  },
                  onStepTapped: (int index) {
                    switch (index) {
                      case 0:
                        setState(() {
                          _index = index;
                        });
                        break;
                      case 1:
                        if (context
                            .read<AppointmentCubit>()
                            .state
                            .selectedPatientId
                            .isNotEmpty) {
                          setState(() {
                            _index = index;
                          });
                        }
                        break;
                      case 2:
                        if (context
                                .read<AppointmentCubit>()
                                .state
                                .selectedMedicalPeronnelId
                                .isNotEmpty &&
                            context
                                .read<AppointmentCubit>()
                                .state
                                .selectedPatientId
                                .isNotEmpty) {
                          setState(() {
                            _index = index;
                          });
                        }
                        break;
                      default:
                        break;
                    }
                  },
                  steps: <Step>[
                    Step(
                        state: StepState.editing,
                        isActive: _index == 0,
                        title: const Text(
                          'Select patient',
                          style: TextStyle(fontSize: 13),
                        ),
                        content: SearchPatientBody(
                          formIndex: 0,
                        )),
                    Step(
                        state: StepState.editing,
                        isActive: _index == 1,
                        title: const Text(
                          'Select doctor',
                          style: TextStyle(fontSize: 13),
                        ),
                        content: SearchDoctorBody(
                          formIndex: 1,
                        )),
                    Step(
                      state: StepState.editing,
                      isActive: _index == 2,
                      title: const Text(
                        'Appointment',
                        style: TextStyle(fontSize: 13),
                      ),
                      content: Register(
                        formIndex: 2,
                      ),
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
}

class StepButtons extends StatelessWidget {
  StepButtons({Key? key, required this.controlDetials}) : super(key: key);
  ControlsDetails controlDetials;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
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
              child: Text(controlDetials.currentStep == 2 ? '' : 'Next'),
              onPressed: () {
                controlDetials.onStepContinue;
              },
            ),
          ),
        ),
        const SizedBox(width: 20),
        Container(
          width: 100,
          height: 60,
          padding: const EdgeInsets.all(2),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: ElevatedButton(
              autofocus: true,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                controlDetials.onStepCancel;
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SearchDoctorBody extends StatefulWidget {
  SearchDoctorBody({Key? key, required this.formIndex}) : super(key: key);
  int formIndex;

  @override
  State<SearchDoctorBody> createState() => _SearchDoctorBodyState();
}

class _SearchDoctorBodyState extends State<SearchDoctorBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
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
                    SearchBar(
                      formIndex: widget.formIndex,
                      field: 'Search doctor',
                    ),
                    const SizedBox(height: 10),
                    const DoctorList(),
                  ],
                ),
              ),
            ),
          ]);
    });
  }
}

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
                  const SizedBox(height: 10),
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
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      DatePickerFeild(
                        label: 'Date',
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      DateTimePickerFeild(
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
                            if (context
                                    .read<AppointmentCubit>()
                                    .state
                                    .selectedMedicalPeronnelId
                                    .isNotEmpty &&
                                context
                                    .read<AppointmentCubit>()
                                    .state
                                    .selectedPatientId
                                    .isNotEmpty) {
                              var response = context
                                  .read<AppointmentCubit>()
                                  .createAppointmenmt(
                                      patientID: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .selectedPatientId,
                                      medicalId: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .selectedMedicalPeronnelId,
                                      token: context
                                          .read<LoginCubit>()
                                          .state
                                          .homeToken,
                                      reasonForVisit: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .resonsForVist,
                                      typeOfVisit: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .typeOfVist);

                              response.then((value) => {
                                    if (value != null &&
                                        value.statusCode == 201)
                                      {
                                        Messages.showMessage(
                                            const Icon(
                                              IconData(0xf635,
                                                  fontFamily: 'MaterialIcons'),
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
                                                  fontFamily: 'MaterialIcons'),
                                              color: Colors.red,
                                            ),
                                            'Appointment could not be created'),
                                      }
                                  });
                            }
                          },
                          child: const Text('Submit')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]);
  }
}

Future dateTimePicker(BuildContext context, String label) async {
  final newTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (newTime == null) return;
  String formatTime = newTime.format(context);

  context.read<AppointmentCubit>().setStartTime(formatTime);
  print(context.read<AppointmentCubit>().state.startTime);
}

class DateTimePickerFeild extends StatelessWidget {
  const DateTimePickerFeild({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        print(state);
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
                dateTimePicker(context, label);
              },
              child: Container(
                height: 45,
                width: 100,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: TimeContent(
                      label: label,
                    )),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class TimeContent extends StatelessWidget {
  const TimeContent({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label == 'From') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(
          context.read<AppointmentCubit>().state.startTime,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    if (label == 'To') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(context.read<AppointmentCubit>().state.endTime,
            style: const TextStyle(fontSize: 12)),
      );
    }
    return Text(context.read<AppointmentCubit>().state.startTime);
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
      context.read<AppointmentCubit>().setStartDate(formattedDate);
      break;
    case 'To':
      context.read<AppointmentCubit>().setEndDate(formattedDate);

      break;
    default:
      break;
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
                width: 100,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextContent(
                    label: label,
                  ),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label == 'From') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(
          context.read<AppointmentCubit>().state.startDate,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    if (label == 'To') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(context.read<AppointmentCubit>().state.endDate,
            style: const TextStyle(fontSize: 12)),
      );
    }
    return Text(context.read<AppointmentCubit>().state.startDate);
  }
}

class SearchPatientBody extends StatefulWidget {
  SearchPatientBody({Key? key, required this.formIndex}) : super();

  int formIndex;

  @override
  State<SearchPatientBody> createState() => _SearchPatientBodyState();
}

class _SearchPatientBodyState extends State<SearchPatientBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
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
                    SearchBar(
                      formIndex: widget.formIndex,
                      field: 'Search patient',
                    ),
                    const SizedBox(height: 10),
                    const PatientList(),
                  ],
                ),
              ),
            ),
          ]);
    });
  }
}

class SearchBar extends StatelessWidget {
  SearchBar({Key? key, required this.formIndex, required this.field})
      : super(key: key);
  int formIndex;
  String field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Text(field),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onFieldSubmitted: (query) => {
              if (field == 'Search patient')
                {
                  context.read<AppointmentCubit>().searchPatients(
                      query: query,
                      token: context.read<LoginCubit>().state.homeToken)
                },
              if (field == 'Search doctor')
                {
                  context.read<AppointmentCubit>().searchDoctors(
                      query: query,
                      token: context.read<LoginCubit>().state.homeToken)
                },
            },
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
                return 'Please enter a valid search query';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    String? selectedDctorId = '';
    int selectedIndex = -1;

    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
      if (SEARCHSTATE.startsearch == state.searchState &&
          state.doctorsList.isEmpty) {
        return Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 1.5,
            padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 1.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 48,
                                height: 48,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 1.0),
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 10.0,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 10.0,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 10.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      )))
            ]));
      }

      if (SEARCHSTATE.notFound == state.searchState ||
          state.doctorsList.isEmpty) {
        return (const Center(
          child: SizedBox(
            height: 70,
            width: 180,
            child: Card(
              margin: EdgeInsets.only(top: 10),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('No result'),
              ),
            ),
          ),
        ));
      }
      return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemCount: state.doctorsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              key: ValueKey(state.doctorsList[index]['name']),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                    '${state.doctorsList[index]['firstName']} ${state.doctorsList[index]['middleName']} ${state.doctorsList[index]['lastName']}'),
                selected: (selectedIndex == index),
                selectedColor: Colors.amber,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    selectedDctorId = state.doctorsList[index]['id'];
                    context
                        .read<AppointmentCubit>()
                        .setSelectedMedicalPersonnelId(selectedDctorId);
                  });
                },
              ),
            );
          });
    });
  }
}

class DropDown extends StatefulWidget {
  DropDown({Key? key, required this.label, required this.options})
      : super(
          key: key,
        );
  String label;
  List<String> options;

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? _selectedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(widget.label),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: const Color.fromARGB(255, 205, 226, 226),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: const Color.fromARGB(255, 205, 226, 226),
                isExpanded: true,
                value: _selectedText,
                hint: const Text("Select contact preference"),
                items: widget.options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedText = val.toString();
                    if (widget.label == 'Type of Visit') {
                      context
                          .read<AppointmentCubit>()
                          .setTypeOfVisit(_selectedText);
                    }

                    if (widget.label == 'Reason for Visit') {
                      context
                          .read<AppointmentCubit>()
                          .setReasonForVisit(_selectedText);
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PatientList extends StatefulWidget {
  const PatientList({
    Key? key,
  }) : super();

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  Widget build(BuildContext context) {
    String? selectedPatientId = '';
    int selectedIndex = -1;

    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
      if (state.patientsList.isEmpty) {
        return (const Center(
          child: SizedBox(
            height: 70,
            width: 180,
            child: Card(
              margin: EdgeInsets.only(top: 10),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('No patient found'),
              ),
            ),
          ),
        ));
      }
      return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemCount: state.patientsList.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
              key: ValueKey(state.patientsList[index]['name']),
              margin: const EdgeInsets.all(10),
              child: Stack(alignment: Alignment.topRight, children: [
                /*   Selected(
                  selectedIndex: state.selectedPatientIndexs,
                  currentIndex: index,
                ), */
                ListTile(
                  title: Text(
                      '${state.patientsList[index]['firstName']} ${state.patientsList[index]['middleName']} ${state.patientsList[index]['lastName']}'),
                  selected: (selectedIndex == index),
                  selectedColor: Colors.amber,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedPatientId = state.patientsList[index]['id'];

                      context
                          .read<AppointmentCubit>()
                          .setSelectedPatientIndex(selectedIndex);

                      context
                          .read<AppointmentCubit>()
                          .setPatientId(selectedPatientId);
                    });
                  },
                ),
              ]),
            );
          });
    });
  }
}

// ignore: must_be_immutable
class Selected extends StatefulWidget {
  Selected({Key? key, required this.currentIndex, required this.selectedIndex})
      : super(key: key);
  int selectedIndex;
  int currentIndex;

  @override
  State<Selected> createState() => _SelectedState();
}

class _SelectedState extends State<Selected> {
  @override
  Widget build(BuildContext context) {
    if (widget.selectedIndex == widget.currentIndex) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: Icon(
          Icons.check_circle,
          color: Colors.transparent,
        ),
      );
    }
  }
}
