import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/components/util/Messages.dart';
import 'package:onye_front_ened/pages/registration/page/registrations.dart';
import 'package:shimmer/shimmer.dart';

class CreateRegistration extends StatefulWidget {
  const CreateRegistration({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<CreateRegistration> createState() => _CreateRegistrationState();
}

//TODO: Refactor
class _CreateRegistrationState extends State<CreateRegistration> {
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
                "Create Registration",
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
                      child: Text('register'),
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
                    Register(formIndex: 1),
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
            padding: const EdgeInsets.all(10.0),
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
                                .selectedPatientId
                                .isNotEmpty) {
                              var response = context
                                  .read<AppointmentCubit>()
                                  .createRegistration(
                                      token: context
                                          .read<LoginCubit>()
                                          .state
                                          .homeToken,
                                      medicalId: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .selectedMedicalPersonnelId,
                                      patientID: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .selectedPatientId,
                                      typeOfVisit: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .typeOfVisit,
                                      reasons: context
                                          .read<AppointmentCubit>()
                                          .state
                                          .reasonForVisit);

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
                                            'Registration created'),
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const Registration())),
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
                                            'Could not create registration'),
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
                  height: 50,
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
                    child: Text(
                      '  ${state.patientsList[index]['firstName']} ${state.patientsList[index]['middleName'] ?? ''} ${state.patientsList[index]['lastName']}',
                      style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              );
            }),
      );
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
