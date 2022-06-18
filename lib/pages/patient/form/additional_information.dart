import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/patient/form/validator/patient_form_validator.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';

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
            initialValue:
                context.read<PatientCubit>().state.emergencyContactName,
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
            initialValue:
                context.read<PatientCubit>().state.emergencyContactPhoneNumber,
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
            initialValue:
                context.read<PatientCubit>().state.emergencyContactRelationship,
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
