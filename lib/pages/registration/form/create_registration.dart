import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/button.dart';
import 'package:onye_front_ened/Widgets/pagination.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/pages/registration/form/patient_list.dart';
import 'package:onye_front_ened/pages/registration/page/registrations.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';

import '../../patient/state/patient_cubit.dart';

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
    if (context.read<LoginBloc>().state.homeToken.isEmpty) {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 25.0, right: 200),
                  child: Text(
                    "Create Registration",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
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
              Center(
                child: Padding(
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
              ),
            ],
          ),
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
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      DropDown(
                          label: 'Language Preference', options: const ['EN']),
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
                                        const Color.fromARGB(
                                            255, 56, 155, 152)),
                                  ),
                                  onPressed: () {
                                    if (context
                                        .read<RegisterationCubit>()
                                        .state
                                        .selectedPatientId
                                        .isNotEmpty) {
                                      var response = context
                                          .read<RegisterationCubit>()
                                          .createRegistration(
                                              token: context
                                                  .read<LoginBloc>()
                                                  .state
                                                  .homeToken,
                                              patientID: context
                                                  .read<RegisterationCubit>()
                                                  .state
                                                  .selectedPatientId,
                                              typeOfVisit: context
                                                  .read<RegisterationCubit>()
                                                  .state
                                                  .typeOfVisit,
                                              reasons: context
                                                  .read<RegisterationCubit>()
                                                  .state
                                                  .reasonForVisit);

                                      response.then((value) => {
                                            if (value != null &&
                                                value.statusCode == 201)
                                              {
                                                context
                                                    .read<RegisterationCubit>()
                                                    .clearState(),
                                            /*     Messages.showMessage(
                                                    const Icon(
                                                      IconData(0xf635,
                                                          fontFamily:
                                                              'MaterialIcons'),
                                                      color: Colors.green,
                                                    ),
                                                    'Registration created'), */
                                            /*     Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                const Registration())),
                                                        ModalRoute.withName(
                                                            '/dashboard')) */
                                              }
                                            else if (value != null &&
                                                value.statusCode == 400)
                                              {
                                             /*    Messages.showMessage(
                                                    const Icon(
                                                      IconData(0xe237,
                                                          fontFamily:
                                                              'MaterialIcons'),
                                                      color: Colors.red,
                                                    ),
                                                    'Could not create registration'), */
                                              }
                                          });
                                    }
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
                                        const Color.fromARGB(
                                            255, 129, 175, 174)),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<RegisterationCubit>()
                                        .clearState();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const Registration())),
                                        ModalRoute.withName(
                                            '/dashboard/checkin'));
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
            ),
          ]),
    );
  }
}

//TODO: REPLACE REGISTERATION WITH PATIENTCUBIT
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
    return BlocBuilder<PatientCubit, PatientState>(builder: (context, state) {
      return Column(
        children: [
          PatientList(
            pageController: widget.pageController,
          ),
          Pagination(
            maxPageCounter: context.read<PatientCubit>().state.maxPageNumber,
            typeofSearch: 'patient',
          )
        ],
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
    final fieldText = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Text(field),
        ),
        SizedBox(
          height: 40,
          width: 320,
          child: TextFormField(
            controller: fieldText,
            onChanged: (query) => {
              context.read<PatientCubit>().setSearchParams(query),
            },
            onFieldSubmitted: (query) => {
              context.read<PatientCubit>().setSearchParams(query),
              context.read<PatientCubit>().searchPatients(
                  query: query,
                  nextPage: 0,
                  token: context.read<LoginBloc>().state.homeToken),
              fieldText.clear()
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
        Button(
            height: 50,
            width: 100,
            label: 'Search',
            onPressed: () {
              context.read<PatientCubit>().searchPatients(
                nextPage: 0,
                  query: context.read<PatientCubit>().state.searchParams,
                  token: context.read<LoginBloc>().state.homeToken);
              fieldText.clear();
            })
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
                          .read<RegisterationCubit>()
                          .setTypeOfVisit(_selectedText);
                    }

                    if (widget.label == 'Reason for Visit') {
                      context
                          .read<RegisterationCubit>()
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
