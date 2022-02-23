import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/features/appointment/state/appointment_cubit.dart';

import '../../auth/state/login_cubit.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

//TODO: Refactor
class _AppointmentFormState extends State<AppointmentForm> {
  int _index = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                "Create appointment",
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
                  onStepTapped: (int index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  steps: <Step>[
                    Step(
                        state: StepState.editing,
                        isActive: _index == 0,
                        title: const Text('Select patient'),
                        content: const SearchPatientBody()),
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

class SearchPatientBody extends StatefulWidget {
  const SearchPatientBody({
    Key? key,
  }) : super();

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
                  children: const [
                    SearchBar(),
                    SizedBox(height: 10),
                    PatientList(),
                  ],
                ),
              ),
            ),
          ]);
    });
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 1.0),
          child: Text("Search patient"),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onFieldSubmitted: (query) =>
                context.read<AppointmentCubit>().searchPatients(
                    query: query,
                    token: context.read<LoginCubit>().state.homeToken),
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
      return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemCount: state.patientsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              key: ValueKey(state.patientsList[index]['name']),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                    '${state.patientsList[index]['firstName']} ${state.patientsList[index]['middleName']} ${state.patientsList[index]['lastName']}'),
                selected: (selectedIndex == index),
                selectedColor: Colors.amber,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    selectedPatientId = state.patientsList[index]['id'];
                  });
                  print(index);
                  print(selectedIndex);
                  print(selectedPatientId);
                },
              ),
            );
          });
    });
  }
}
