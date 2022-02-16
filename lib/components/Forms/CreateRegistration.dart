import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/features/appointment/appointment_cubit.dart';

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

  @override
  void CreateRegistration() {
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
                "Create Registration",
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
                        content: SearchPatientBody(
                          formIndex: 0,
                        )),
                    Step(
                        state: StepState.editing,
                        isActive: _index == 1,
                        title: const Text('Select doctor'),
                        content: SearchDoctorBody(
                          formIndex: 1,
                        )),
                    Step(
                        state: StepState.editing,
                        isActive: _index == 2,
                        title: const Text('Register'),
                        content: Register(
                          formIndex: 2,
                        )),
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
                      field: '',
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
            onFieldSubmitted: (query) =>{
              if(field == 'Search patient'){
                context.read<AppointmentCubit>().searchPatients(query)
                },
                if(field == 'Search doctor'){
                  context.read<AppointmentCubit>().searchDoctors(query)


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
      print(state);
      if (state.patientsList.isEmpty) {
        return (
          const Center(
            child: SizedBox(
              height: 70,
              width: 180,
              child: Card(
                  margin: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('No patient was found'),
                ),),
            ),
         
        ));
      }
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
