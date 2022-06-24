import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/patient/form/validator/patient_form_validator.dart';

import '../../../Widgets/Input_field.dart';
import '../../../Widgets/drop_down.dart';
import '../state/patient_cubit.dart';

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
                          initValue:
                              context.read<PatientCubit>().state.firstName,
                        ),
                        adjustableSpacer,
                        InputField(
                          label: 'Middle Name',
                          setValue: setMiddleName,
                          isRequired: false,
                          initValue:
                              context.read<PatientCubit>().state.middleName,
                        ),
                        adjustableSpacer,
                        InputField(
                          label: 'Last Name',
                          setValue: setLastName,
                          isRequired: true,
                          initValue:
                              context.read<PatientCubit>().state.lastName,
                        ),
                        adjustableSpacer,
                        const DatePickerField(),
                        adjustableSpacer,
                        DropDown(
                            label: 'Gender',
                            options: const ['MALE', 'FEMALE', 'OTHER'],
                            setValue: setGender,
                            initValue:
                                context.read<PatientCubit>().state.gender), 
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
                          initValue:
                              context.read<PatientCubit>().state.religion,
                        ), 
                        adjustableSpacer,
                     /*      DropDown(
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
                            initValue: context
                                .read<PatientCubit>()
                                .state
                                .educationLevel), */  
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
                            initValue:
                                context.read<PatientCubit>().state.ethnicity) 
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

Future datePicker(BuildContext context) async {
  final initDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 5));
  if (newDate == null) return;
  context.read<PatientCubit>().setDateOfBirth(newDate.toString().split(' ')[0]);
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
                datePicker(context);
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
