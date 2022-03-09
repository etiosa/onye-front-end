import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/components/util/Messages.dart';
import 'package:onye_front_ened/pages/registration/page/registrations.dart';
import 'package:shimmer/shimmer.dart';

import '../../appointments.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<CreateAppointment> createState() => _CreateRegistrationState();
}

//TODO: Refactor
class _CreateRegistrationState extends State<CreateAppointment> {
  int _index = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<LoginCubit>().state.homeToken.isEmpty) {
      //redirect to home
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: currentPageIndex);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25.0, left: 20),
              child: Text(
                "Create Appointment",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    InkWell(
                      /*   onTap:()=>{ controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn),}, */
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 26, 155, 152),
                        ),
                        child: Center(
                            child: Text(
                          '${controller.initialPage + 1}',
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('search patient'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      /*   onTap:()=>{ controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn),}, */
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPageIndex == 1
                              ? const Color.fromARGB(255, 26, 155, 152)
                              : const Color.fromARGB(255, 205, 226, 226),
                        ),
                        height: 30,
                        width: 30,
                        child: const Center(child: Text('2')),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('select doctor'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      /*    onTap:()=>{ controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn),
                      }, */
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPageIndex == 1
                              ? const Color.fromARGB(255, 26, 155, 152)
                              : const Color.fromARGB(255, 205, 226, 226),
                        ),
                        height: 30,
                        width: 30,
                        child: const Center(child: Text('3')),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('appointment'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width / 1.05,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  pageSnapping: true,
                  controller: controller,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SearchBar(
                          formIndex: 0,
                          field: 'Search patient',
                        ),
                        const SizedBox(height: 20),
                        SearchPatientBody(
                          formIndex: 0,
                          pageController: controller,
                        ),
                      ],
                    ),
                    //Search doctor
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SearchBar(
                          formIndex: 0,
                          field: 'Search doctor',
                        ),
                        const SizedBox(height: 10),
                        DoctorList(
                          pageController: controller,
                        ),
                      ],
                    ),
                    Register(formIndex: 2)
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

Future dateTimePicker(BuildContext context, String label) async {
  final newTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (newTime == null) return;

  String formatTime = newTime.format(context);

  context.read<AppointmentCubit>().setAppointmentTime(formatTime);
}

class DateTimePickerField extends StatelessWidget {
  const DateTimePickerField({Key? key, required this.label}) : super(key: key);
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
                    padding: const EdgeInsets.all(1.0),
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
          context.read<AppointmentCubit>().state.appointmentTime,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    if (label == 'To') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(context.read<AppointmentCubit>().state.appointmentTime,
            style: const TextStyle(fontSize: 12)),
      );
    }
    return Text(context.read<AppointmentCubit>().state.appointmentTime);
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
  context.read<AppointmentCubit>().setAppointmentDate(formattedDate);
}

class DatePickerField extends StatelessWidget {
  const DatePickerField({Key? key, required this.label}) : super(key: key);
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
          context.read<AppointmentCubit>().state.appointmentDate,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
      child: Text(context.read<AppointmentCubit>().state.appointmentDate,
          style: const TextStyle(fontSize: 12)),
    );
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
                                    .selectedMedicalPersonnelId
                                    .isNotEmpty &&
                                context
                                    .read<AppointmentCubit>()
                                    .state
                                    .selectedPatientId
                                    .isNotEmpty) {
                              var response = context
                                  .read<AppointmentCubit>()
                                  .createAppointment(
                                      date:
                                          context
                                              .read<AppointmentCubit>()
                                              .state
                                              .appointmentDate,
                                      time:
                                          context
                                              .read<AppointmentCubit>()
                                              .state
                                              .appointmentTime,
                                      patientID:
                                          context
                                              .read<AppointmentCubit>()
                                              .state
                                              .selectedPatientId,
                                      medicalId: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .selectedMedicalPersonnelId,
                                      token: context
                                          .read<LoginCubit>()
                                          .state
                                          .homeToken,
                                      reasonForVisit: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .reasonForVisit,
                                      typeOfVisit: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .typeOfVisit);

                              response.then((value) => {
                                    if (value != null &&
                                        value.statusCode == 201)
                                      {
                                        context
                                            .read<AppointmentCubit>()
                                            .clearState(),
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
                                            'Could not create appointment'),
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

class SearchPatientBody extends StatefulWidget {
  SearchPatientBody(
      {Key? key, required this.formIndex, required this.pageController})
      : super();

  int formIndex;
  PageController pageController;

  @override
  State<SearchPatientBody> createState() => _SearchPatientBodyState();
}

class _SearchPatientBodyState extends State<SearchPatientBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
      return
          //const SizedBox(height: 10),
          PatientList(
        pageController: widget.pageController,
      );
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
  PatientList({
    required this.pageController,
    Key? key,
  }) : super();
  PageController pageController;

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  int selectedIndex = -1;
  String selectedPatientId = '';

  @override
  Widget build(BuildContext context) {
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
      return Expanded(
        flex: 1,
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemCount: state.patientsList.length,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    selectedPatientId = state.patientsList[index]['id'];

                    context
                        .read<AppointmentCubit>()
                        .setPatientId(selectedPatientId);
                    selectedIndex = index;
                    widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  });
                },
                child: Container(
                  width: 50,
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? const Color.fromARGB(255, 26, 155, 152)
                        : const Color.fromARGB(255, 248, 254, 254),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  ${state.patientsList[index]['firstName']} ${state.patientsList[index]['middleName'] ?? ''} ${state.patientsList[index]['lastName']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                       const  SizedBox(height:10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('patient number'),
                            Text(
                              '  ${state.patientsList[index]['patientNumber']} ',
                            ),
                          ],
                        ),
                            const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('phone number'),
                            Text(
                              '  ${state.patientsList[index]['phoneNumber']} ',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}

class DoctorList extends StatefulWidget {
  DoctorList({
    required this.pageController,
    Key? key,
  }) : super();
  PageController pageController;

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  int selectedIndex = -1;
  String selectedPatientId = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
      if (state.doctorsList.isEmpty) {
        return (const Center(
          child: SizedBox(
            height: 70,
            width: 180,
            child: Card(
              margin: EdgeInsets.only(top: 10),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('No Doctor found'),
              ),
            ),
          ),
        ));
      }
      return Expanded(
        flex: 1,
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemCount: state.doctorsList.length,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    selectedPatientId = state.doctorsList[index]['id'];

                    context
                        .read<AppointmentCubit>()
                        .setSelectedMedicalPersonnelId(selectedPatientId);
                    selectedIndex = index;
                    widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  });
                },
               
                  child: Container(
                    width: 50,
                    height: 120,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? const Color.fromARGB(255, 26, 155, 152)
                          : const Color.fromARGB(255, 248, 254, 254),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '  ${state.doctorsList[index]['firstName']} ${state.doctorsList[index]['middleName'] ?? ''} ${state.doctorsList[index]['lastName']}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('personnel number'),
                              Text(
                                '  ${state.doctorsList[index]['personnelNumber']} ',
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('phone number'),
                              Text(
                                '  ${state.doctorsList[index]['phoneNumber']} ',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
            
              );
            }),
      );
    });
  }
}
