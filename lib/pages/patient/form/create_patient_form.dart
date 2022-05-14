import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:onye_front_ened/Widgets/DropDown.dart';
import 'package:onye_front_ened/Widgets/InputField.dart';
import 'package:onye_front_ened/components/util/Modal.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
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
    GlobalKey<FormState>(),
  ];
  final PatientFormValidator validator = PatientFormValidator();
  final PageController _pageController = PageController();

  void nextPage() {
    _pageController.nextPage(
        curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }

  @override
  void initState() {
    // TODO: implement initState
    PageController _pageController = PageController();
    super.initState();
    if (context.read<LoginBloc>().state.homeToken.isEmpty) {
      //redirect to home
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/dashboard");
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var refToBasicInfo = BasicInfoFormBody(
      formKey: _formKeys[0],
      validator: validator,
    );
    var refToContactInfo = ContactInfoFormBody(
      formKey: _formKeys[1],
      validator: validator,
    );
    var refToAdditionalInfo = AdditionalInfoFormBody(
      formKey: _formKeys[2],
      validator: validator,
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  child: PageView(
                    controller: _pageController,
                    children: [
                      SingleChildScrollView(
                        child: BasicInfoFormBody(
                            formKey: _formKeys[0], validator: validator),
                      ),
                      SingleChildScrollView(
                        child: ContactInfoFormBody(
                            formKey: _formKeys[1], validator: validator),
                      ),
                      SingleChildScrollView(
                        child: AdditionalInfoFormBody(
                            formKey: _formKeys[2], validator: validator),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[200],
                      ),
                      onPressed: () {
                        if (_pageController.page! > 0) {

                          _pageController.previousPage(
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 300));
                        } else {
                         context.read<PatientCubit>().clearState();
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  ElevatedButton(
                    child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 56, 155, 152),
                    ),
                    onPressed: () async {
                      if (_pageController.page == 0) {
                        if (refToBasicInfo.formsAreValid()) {
                          nextPage();
                        }
                      } else if (_pageController.page == 1) {
                        if (refToContactInfo.formsAreValid()) {
                          nextPage();
                        }
                      } else if (_pageController.page == 2) {
                        if (refToAdditionalInfo.formsAreValid()) {
                          var response = await context
                              .read<PatientCubit>()
                              .createNewPatient(
                                  token: context
                                      .read<LoginBloc>()
                                      .state
                                      .homeToken);

                          if (response != null &&
                              response.body.contains('errors')) {
                            dynamic errors =
                                json.decode(response.body)['errors'];
                            String errorsJson = jsonEncode(errors);

                            if (errorsJson.contains('phoneNumber')) {
                              validator.phoneNumberError =
                                  jsonDecode(errorsJson)['phoneNumber'];
                            }
                            if (errorsJson.contains('email')) {
                              validator.emailError =
                                  jsonDecode(errorsJson)['email'];
                            }
                          }

                          if (response != null) {
                            switch (response.statusCode) {
                              case 201:
                                context.read<PatientCubit>().clearState();
                             /*    Messages.showMessage(
                                    const Icon(
                                      IconData(0xf635,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.green,
                                    ),
                                    'Patient created'); */
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const Dashboard())),
                                    ModalRoute.withName('/dashboard'));
                                break;
                              case 400:
                             /*    Messages.showMessage(
                                    const Icon(
                                      IconData(0xe237,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.red,
                                    ),
                                    'Could not create patient, invalid input'); */
                                break;
                              default:
                              /*   Messages.showMessage(
                                    const Icon(
                                      IconData(0xe237,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.red,
                                    ),
                                    'Could not create patient'); */
                            }
                          } else {
                           /*  Messages.showMessage(
                                const Icon(
                                  IconData(0xe237, fontFamily: 'MaterialIcons'),
                                  color: Colors.red,
                                ),
                                'Could not create patient, invalid input'); */
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
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

  bool formsAreValid() {
    bool isValid = true;
    if (!formKey.currentState!.validate()) {
      isValid = false;
    }
    return isValid;
  }

  @override
  State<BasicInfoFormBody> createState() =>
      _BasicInfoFormBodyState(formKey: formKey, validator: validator);
}

class _BasicInfoFormBodyState extends State<BasicInfoFormBody> {
  final GlobalKey<FormState> formKey;
  final PatientFormValidator validator;

  void setGender(String? value) {
    context.read<PatientCubit>().setGender(value);
  }

  void setReligion(String? value) {
    context.read<PatientCubit>().setReligion(value);
  }

  void setEducationLevel(String? value) {
    context.read<PatientCubit>().setEducationLevel(value);
  }

  void setEthnicity(String? value) {
    context.read<PatientCubit>().setEthnicity(value);
  }

  void setContactPreference(String? value) {
    context.read<PatientCubit>().setContactPreference(value);
  }

  void setFirstName(String? firstName) {
    context.read<PatientCubit>().setFirstName(firstName);
  }

  void setMiddleName(String? firstName) {
    context.read<PatientCubit>().setMiddleName(firstName);
  }

  void setLastName(String? firstName) {
    context.read<PatientCubit>().setLastName(firstName);
  }

  _BasicInfoFormBodyState({required this.formKey, required this.validator});

  @override
  Widget build(BuildContext context) {
    Widget adjustableSpacer = SizedBox(
      height: MediaQuery.of(context).size.height * .02,
    );
    return BlocBuilder<PatientCubit, PatientState>(builder: (context, state) {
      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .8,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        adjustableSpacer,
                        InputField(
                          label: 'First Name',
                          setValue: setFirstName,
                          isRequired: true,
                        ),
                        adjustableSpacer,
                        InputField(
                          label: 'Middle Name',
                          setValue: setMiddleName,
                          isRequired: false,
                        ),
                        adjustableSpacer,
                        InputField(
                          label: 'Last Name',
                          setValue: setLastName,
                          isRequired: true,
                        ),
                        adjustableSpacer,
                        const DatePickerField(),
                        adjustableSpacer,
                        DropDown(
                          label: 'Gender',
                          options: const ['MALE', 'FEMALE', 'OTHER'],
                          setValue: setGender,
                        ),
                        adjustableSpacer,
                        DropDown(
                          label: 'Religion',
                          options: const [
                            '  HINDUISM',
                            'BUDDHISM',
                            'JUDAISM',
                            'CHRISTIANITY',
                            'ISLAM',
                            'OTHER',
                          ],
                          setValue: setReligion,
                        ),
                        adjustableSpacer,
                        DropDown(
                          label: 'Education Level',
                          options: const [
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
                          ],
                          setValue: setReligion,
                        ),
                        adjustableSpacer,
                        DropDown(
                          label: 'Ethnicity',
                          options: const [
                            'HAUSA',
                            'YORUBA',
                            'IJAW',
                            'IGBO',
                            'IBIBIO',
                            'TIV',
                            'FULANI',
                            'KANURI',
                            'OTHER',
                          ],
                          setValue: setEthnicity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

//TODO: Refactor later
class ContactInfoFormBody extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ContactInfoFormBody({
    Key? key,
    required this.formKey,
    required this.validator,
  }) : super();

  final GlobalKey<FormState> formKey;
  final PatientFormValidator validator;

  bool formsAreValid() {
    bool isValid = true;
    if (!formKey.currentState!.validate()) {
      isValid = false;
    }
    return isValid;
  }

  @override
  State<ContactInfoFormBody> createState() =>
      _ContactInfoFormBodyState(formKey: formKey, validator: validator);
}

class _ContactInfoFormBodyState extends State<ContactInfoFormBody> {
  final GlobalKey<FormState> formKey;
  final PatientFormValidator validator;

  void setContactPreference(String? value) {
    context.read<PatientCubit>().setContactPreference(value);
  }

  void setLastName(String? firstName) {
    context.read<PatientCubit>().setLastName(firstName);
  }

  _ContactInfoFormBodyState({required this.formKey, required this.validator});

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
                    PhoneNumber(validator: validator),
                    const SizedBox(height: 10),
                    Email(validator: validator),
                    const SizedBox(height: 10),
                    const Address(),
                    const SizedBox(height: 10),
                    DropDown(
                      label: 'Contact Preference',
                      options: const ['PHONE', 'SMS', 'EMAIL'],
                      setValue: setContactPreference,
                    ),
                    //const ContactPreference(),
                    const SizedBox(height: 10),
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
    required this.formKey,
    required this.validator,
  }) : super();

  final GlobalKey<FormState> formKey;
  final PatientFormValidator validator;

  bool formsAreValid() {
    bool isValid = true;
    if (!formKey.currentState!.validate()) {
      isValid = false;
    }
    return isValid;
  }

  @override
  State<AdditionalInfoFormBody> createState() =>
      _AdditionalInfoFormBodyState(formKey: formKey, validator: validator);
}

class _AdditionalInfoFormBodyState extends State<AdditionalInfoFormBody> {
  final GlobalKey<FormState> formKey;
  final PatientFormValidator validator;

  _AdditionalInfoFormBodyState(
      {required this.formKey, required this.validator});

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
                    EmergencyContact(),
                  ],
                ),
              ),
            ),
          ]);
    });
  }
}

class DatePickerField extends StatelessWidget {
  const DatePickerField({Key? key}) : super(key: key);

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

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key, required this.validator}) : super(key: key);

  final PatientFormValidator validator;

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
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Phone number is required'),
              (value) {
                return validator.phoneNumberError;
              }
            ]),
          ),
        ),
      ],
    );
  }
}

class Email extends StatelessWidget {
  const Email({Key? key, required this.validator}) : super(key: key);

  final PatientFormValidator validator;

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
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.email(context,
                  errorText: 'Not a valid e-mail address'),
              (value) {
                return validator.emailError;
              }
            ]),
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
          width: 320,
          child: TextFormField(
            onChanged: (addressLine1) =>
                context.read<PatientCubit>().setAddressLine1(addressLine1),
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
            autovalidateMode: AutovalidateMode.always,
            validator: (value) {
              if (!allAddressFieldsValid(context) &&
                  value != null &&
                  value.isEmpty) {
                return 'Line 1 is required to complete address';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 320,
          child: TextFormField(
            onChanged: (addressLine2) =>
                context.read<PatientCubit>().setAddressLine2(addressLine2),
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
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: 155,
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
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (!allAddressFieldsValid(context) &&
                      value != null &&
                      value.isEmpty) {
                    return 'Zip code is required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 155,
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
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (!allAddressFieldsValid(context) &&
                      value != null &&
                      value.isEmpty) {
                    return 'City is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool allAddressFieldsValid(BuildContext context) {
    if (context.read<PatientCubit>().state.addressLine1 == null &&
        context.read<PatientCubit>().state.zipCode == null &&
        context.read<PatientCubit>().state.city == null) {
      return true;
    }

    if (context.read<PatientCubit>().state.addressLine1 == null ||
        context.read<PatientCubit>().state.addressLine1!.isEmpty) {
      return false;
    }
    if (context.read<PatientCubit>().state.zipCode == null ||
        context.read<PatientCubit>().state.zipCode!.isEmpty) {
      return false;
    }
    if (context.read<PatientCubit>().state.city == null ||
        context.read<PatientCubit>().state.city!.isEmpty) {
      return false;
    }

    return true;
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
            autovalidateMode: AutovalidateMode.always,
            validator: (value) {
              if (!allEmergencyContactFieldsAreValid(context) &&
                  value != null &&
                  value.isEmpty) {
                return 'Name is required to complete emergency contact';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
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
            autovalidateMode: AutovalidateMode.always,
            validator: (value) {
              if (!allEmergencyContactFieldsAreValid(context) &&
                  value != null &&
                  value.isEmpty) {
                return 'Phone number is required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
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
            autovalidateMode: AutovalidateMode.always,
            validator: (value) {
              if (!allEmergencyContactFieldsAreValid(context) &&
                  value != null &&
                  value.isEmpty) {
                return 'Relationship is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
  
  bool allEmergencyContactFieldsAreValid(BuildContext context) {
    if (context.read<PatientCubit>().state.emergencyContactName == null &&
        context.read<PatientCubit>().state.emergencyContactPhoneNumber ==
            null &&
        context.read<PatientCubit>().state.emergencyContactRelationship ==
            null) {
      return true;
    }

    if (context.read<PatientCubit>().state.emergencyContactName == null ||
        context.read<PatientCubit>().state.emergencyContactName!.isEmpty) {
      return false;
    }
    if (context.read<PatientCubit>().state.emergencyContactPhoneNumber ==
            null ||
        context
            .read<PatientCubit>()
            .state
            .emergencyContactPhoneNumber!
            .isEmpty) {
      return false;
    }
    if (context.read<PatientCubit>().state.emergencyContactRelationship ==
            null ||
        context
            .read<PatientCubit>()
            .state
            .emergencyContactRelationship!
            .isEmpty) {
      return false;
    }

    return true;
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
              validator.clearErrors();
              if (formsAreValid()) {
                var response = await context
                    .read<PatientCubit>()
                    .createNewPatient(
                        token: context.read<LoginBloc>().state.homeToken);

                if (response != null && response.body.contains('errors')) {
                  dynamic errors = json.decode(response.body)['errors'];
                  String errorsJson = jsonEncode(errors);

                  if (errorsJson.contains('phoneNumber')) {
                    validator.phoneNumberError =
                        jsonDecode(errorsJson)['phoneNumber'];
                  }
                  if (errorsJson.contains('email')) {
                    validator.emailError = jsonDecode(errorsJson)['email'];
                  }
                }

                bool valid = formsAreValid();

                if (response != null) {
                  switch (response.statusCode) {
                    case 201:
                      context.read<PatientCubit>().clearState();
                      /* Messages.showMessage(
                          const Icon(
                            IconData(0xf635, fontFamily: 'MaterialIcons'),
                            color: Colors.green,
                          ),
                          'Patient created'); */
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: ((context) => const Dashboard())),
                          ModalRoute.withName('/dashboard'));
                      break;
                    case 400:
                      if (!valid) {
                      /*   Messages.showMessage(
                            const Icon(
                              IconData(0xe237, fontFamily: 'MaterialIcons'),
                              color: Colors.red,
                            ),
                            'Could not create patient, invalid input'); */
                      }
                      break;
                    default:
                   /*    Messages.showMessage(
                          const Icon(
                            IconData(0xe237, fontFamily: 'MaterialIcons'),
                            color: Colors.red,
                          ),
                          'Could not create patient'); */
                  }
                }
              } else {
               /*  Messages.showMessage(
                    const Icon(
                      IconData(0xe237, fontFamily: 'MaterialIcons'),
                      color: Colors.red,
                    ),
                    'Could not create patient, invalid input'); */
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
