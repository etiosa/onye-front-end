import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:onye_front_ened/pages/patient/form/validator/patient_form_validator.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';

import '../../../Widgets/drop_down.dart';


//TODO: MOVE ALL SEPARATE COMPONENT TO DIFFERENT FILE
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
                    PhoneNumber(
                      validator: validator,
                      initValue: context.read<PatientCubit>().state.phoneNumber,
                    ),
                    const SizedBox(height: 10),
                    Email(
                      validator: validator,
                      initValue: context.read<PatientCubit>().state.email,
                    ),
                    const SizedBox(height: 10),
                    const Address(),
                    const SizedBox(height: 10),
                    DropDown(
                      label: 'Contact Preference',
                      options: const ['PHONE', 'SMS', 'EMAIL'],
                      setValue: setContactPreference,
                      initValue:
                          context.read<PatientCubit>().state.contactPreferences,
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

class Email extends StatelessWidget {
  const Email({Key? key, required this.validator, this.initValue})
      : super(key: key);

  final PatientFormValidator validator;
  final String? initValue;

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
            initialValue: initValue,
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
class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key, required this.validator, this.initValue})
      : super(key: key);

  final PatientFormValidator validator;
  final String? initValue;

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
            initialValue: initValue,
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
            initialValue: context.read<PatientCubit>().state.addressLine1,
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
            initialValue: context.read<PatientCubit>().state.addressLine2,
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
                initialValue: context.read<PatientCubit>().state.zipCode,
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
                initialValue: context.read<PatientCubit>().state.city,
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
