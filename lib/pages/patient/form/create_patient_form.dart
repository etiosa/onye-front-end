import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/components/util/Messages.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/pages/dashboard.dart';
import 'package:onye_front_ened/pages/patient/form/validator/patient_form_validator.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';

class CreatePatientForm extends StatefulWidget {
  const CreatePatientForm({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<CreatePatientForm> createState() => _CreatePatientFormState();
}

//TODO: Refactor
class _CreatePatientFormState extends State<CreatePatientForm> {
  int _index = 0;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  final PatientFormValidator validator = PatientFormValidator();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<LoginCubit>().state.homeToken.isEmpty) {
      //redirect to home
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/dashboard");
      });
    }
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
                "Create patient record",
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
                        title: const Text('Basic info'),
                        content: BasicInfoFormBody(
                            formKey: _formKeys[0], validator: validator)),
                    Step(
                        state: StepState.editing,
                        isActive: _index == 1,
                        title: const Text('Contact info'),
                        content: ContactInfoFormBody(
                            formKey: _formKeys[1], validator: validator)),
                    Step(
                        state: StepState.complete,
                        isActive: _index == 2,
                        title: const Text('Additional info'),
                        content: AdditionalInfoFormBody(
                            formKeys: _formKeys, validator: validator)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future datePicker(BuildContext context) async {
    final initDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) return;
    context
        .read<PatientCubit>()
        .setDateOfBirth(newDate.toString().split(' ')[0]);
  }
}

class BasicInfoFormBody extends StatefulWidget {
  const BasicInfoFormBody({
    Key? key,
    required this.formKey,
    required this.validator,
  }) : super();

  final GlobalKey<FormState> formKey;
  final PatientFormValidator validator;

  @override
  State<BasicInfoFormBody> createState() =>
      _BasicInfoFormBodyState(formKey: formKey, validator: validator);
}

class _BasicInfoFormBodyState extends State<BasicInfoFormBody> {
  final GlobalKey<FormState> formKey;
  final PatientFormValidator validator;

  _BasicInfoFormBodyState({required this.formKey, required this.validator});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(builder: (context, state) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FirstName(validator: validator),
                    const SizedBox(height: 10),
                    MiddleName(),
                    const SizedBox(height: 10),
                    LastName(),
                    const SizedBox(height: 10),
                    DatePickerFeild(),
                    const SizedBox(height: 10),
                    Gender(),
                    const SizedBox(height: 10),
                    Religion(),
                    const SizedBox(height: 10),
                    EducationLevel(),
                    const SizedBox(height: 10),
                    Ethnicity(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ]);
    });
  }
}

//TODO: Refactor later
class ContactInfoFormBody extends StatefulWidget {
  const ContactInfoFormBody({
    Key? key,
    required this.formKey,
    required this.validator,
  }) : super();

  final GlobalKey<FormState> formKey;
  final PatientFormValidator validator;

  @override
  State<ContactInfoFormBody> createState() =>
      _ContactInfoFormBodyState(formKey: formKey);
}

class _ContactInfoFormBodyState extends State<ContactInfoFormBody> {
  final GlobalKey<FormState> formKey;

  _ContactInfoFormBodyState({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(builder: (context, state) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    PhoneNumber(),
                    SizedBox(height: 10),
                    Email(),
                    SizedBox(height: 10),
                    Address(),
                    SizedBox(height: 10),
                    ContactPreference(),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ]);
    });
  }
}

class AdditionalInfoFormBody extends StatefulWidget {
  const AdditionalInfoFormBody({
    Key? key,
    required this.formKeys,
    required this.validator,
  }) : super();

  final List<GlobalKey<FormState>> formKeys;
  final PatientFormValidator validator;

  @override
  State<AdditionalInfoFormBody> createState() =>
      _AdditionalInfoFormBodyState(formKeys: formKeys, validator: validator);
}

class _AdditionalInfoFormBodyState extends State<AdditionalInfoFormBody> {
  final List<GlobalKey<FormState>> formKeys;
  final PatientFormValidator validator;

  _AdditionalInfoFormBodyState(
      {required this.formKeys, required this.validator});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(builder: (context, state) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKeys[2],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const EmergencyContact(),
                    const SizedBox(height: 10),
                    _SubmitButton(formKeys: formKeys, validator: validator)
                  ],
                ),
              ),
            ),
          ]);
    });
  }
}

class DatePickerFeild extends StatelessWidget {
  const DatePickerFeild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<PatientCubit, PatientState>(
      builder: (context, state) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date Of Birth',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                _CreatePatientFormState().datePicker(context);
              },
              child: Container(
                height: 45,
                width: 320,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    state.dateOfBirth!,
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

class FirstName extends StatelessWidget {
  const FirstName({Key? key, required this.validator}) : super(key: key);

  final PatientFormValidator validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 1.0),
          child: Text("First Name"),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (firstName) =>
                context.read<PatientCubit>().setFirstName(firstName),
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
                return 'Please enter a valid first name';
              }
              print('validator is about to get called');
              print('validator firstName: ${validator.getFirstNameError()}');
              return validator.getFirstNameError();
            },
          ),
        ),
      ],
    );
  }
}

class MiddleName extends StatelessWidget {
  const MiddleName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 1.0),
          child: Text("Middle Name"),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (middleName) =>
                context.read<PatientCubit>().setMiddleName(middleName),
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
                return 'Please enter a valid middle name';
              }
              return null;
            },
          ),
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
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (lastName) =>
                context.read<PatientCubit>().setLastName(lastName),
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
                return 'Please enter a valid lasts name';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

//TODO: move this to a dropdown widget
class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String? _selectedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Gender"),
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
                hint: const Text("Select gender"),
                items: <String>['MALE', 'FEMALE', 'OTHER'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  context.read<PatientCubit>().setGender(val);
                  setState(() {
                    _selectedText = val.toString();
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

class Religion extends StatefulWidget {
  const Religion({Key? key}) : super(key: key);

  @override
  State<Religion> createState() => _ReligionState();
}

class _ReligionState extends State<Religion> {
  String? _selectedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Religion"),
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
                hint: const Text("Select religion"),
                items: <String>[
                  'HINDUISM',
                  'BUDDHISM',
                  'JUDAISM',
                  'CHRISTIANITY',
                  'ISLAM',
                  'OTHER',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  context.read<PatientCubit>().setReligion(val);
                  setState(() {
                    _selectedText = val.toString();
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

class EducationLevel extends StatefulWidget {
  const EducationLevel({Key? key}) : super(key: key);

  @override
  State<EducationLevel> createState() => _EducationLevelState();
}

class _EducationLevelState extends State<EducationLevel> {
  String? _selectedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Education Level"),
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
                hint: const Text("Select education level"),
                items: <String>[
                  'NONE',
                  'PRE_PRIMARY',
                  'PRIMARY',
                  'LOWER_SECONDARY',
                  'UPPER_SECONDARY',
                  'POST_SECONDARY',
                  'SHORT_CYCLE_TERTIARY',
                  'BACHELORS_DEGREE',
                  'MASTERS_DEGREE',
                  'DOCTORATE',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  context.read<PatientCubit>().setEducationLevel(val);
                  setState(() {
                    _selectedText = val.toString();
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

class Ethnicity extends StatefulWidget {
  const Ethnicity({Key? key}) : super(key: key);

  @override
  State<Ethnicity> createState() => _EthnicityState();
}

class _EthnicityState extends State<Ethnicity> {
  String? _selectedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Ethnicity"),
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
                hint: const Text("Select ethnicity"),
                items: <String>[
                  'HAUSA',
                  'YORUBA',
                  'IJAW',
                  'IGBO',
                  'IBIBIO',
                  'TIV',
                  'FULANI',
                  'KANURI',
                  'OTHER',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  context.read<PatientCubit>().setEthnicity(val);

                  setState(() {
                    _selectedText = val.toString();
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

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Phone Number"),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (phoneNumber) =>
                context.read<PatientCubit>().setPhoneNumber(phoneNumber),
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
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class Email extends StatelessWidget {
  const Email({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Email"),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (email) => context.read<PatientCubit>().setEmail(email),
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
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class Address extends StatelessWidget {
  const Address({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Address"),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (addressline1) =>
                context.read<PatientCubit>().setAddressLine1(addressline1),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              hintText: "Line 1",
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a address line';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (addressline2) =>
                context.read<PatientCubit>().setAddressLine2(addressline2),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              hintText: "Line 2",
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a address line';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (addressline3) =>
                context.read<PatientCubit>().setAddressLine3(addressline3),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              hintText: "Line 3",
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a address line';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (addressline4) =>
                context.read<PatientCubit>().setAddressLine4(addressline4),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              hintText: "Line 4",
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a address line';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (zipcode) =>
                context.read<PatientCubit>().setZipCode(zipcode),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              hintText: "Zip code",
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a zip code';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (city) => context.read<PatientCubit>().setCity(city),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              hintText: "City",
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a city';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class ContactPreference extends StatefulWidget {
  const ContactPreference({Key? key}) : super(key: key);

  @override
  State<ContactPreference> createState() => _ContactPreferenceState();
}

class _ContactPreferenceState extends State<ContactPreference> {
  String? _selectedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Contact Preference"),
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
                items: <String>['PHONE', 'SMS', 'EMAIL'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  context.read<PatientCubit>().setContactPreference(val);
                  setState(() {
                    _selectedText = val.toString();
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

class EmergencyContact extends StatelessWidget {
  const EmergencyContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Emergency Contact"),
        ),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (name) =>
                context.read<PatientCubit>().setEmergencyContactName(name),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              hintText: "Name",
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (phoneNumber) => context
                .read<PatientCubit>()
                .setEmergencyContactPhoneNumber(phoneNumber),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              hintText: "Phone number",
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          width: 320,
          child: TextFormField(
            onChanged: (relationship) => context
                .read<PatientCubit>()
                .setEmergencyContactRelationship(relationship),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              hintText: "Relationship",
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final List<GlobalKey<FormState>> formKeys;
  final PatientFormValidator validator;

  const _SubmitButton({required this.formKeys, required this.validator})
      : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(builder: (context, state) {
      return Container(
        width: 320,
        height: 45,
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
            child: const Text('Submit'),
            onPressed: () async {
              if (formsAreValid()) {
                var response = await context
                    .read<PatientCubit>()
                    .createNewPatient(
                        token: context.read<LoginCubit>().state.homeToken);

                validator.setFirstNameError('first name was wrong');

                if (formsAreValid()) {
                  if (response != null) {
                    switch (response.statusCode) {
                      case 201:
                        context.read<PatientCubit>().clearState();
                        Messages.showMessage(
                            const Icon(
                              IconData(0xf635, fontFamily: 'MaterialIcons'),
                              color: Colors.green,
                            ),
                            'Patient created');
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((context) => const Dashboard())),
                            ModalRoute.withName('/dashboard'));
                        break;
                      default:
                        Messages.showMessage(
                            const Icon(
                              IconData(0xe237, fontFamily: 'MaterialIcons'),
                              color: Colors.red,
                            ),
                            'Could not create patient');
                    }
                  }
                }
              }
            },
          ),
        ),
      );
    });
  }

  bool formsAreValid() {
    bool isValid = true;
    for (var formKey in formKeys) {
      if (!formKey.currentState!.validate()) {
        isValid = false;
      }
    }
    return isValid;
  }
}
