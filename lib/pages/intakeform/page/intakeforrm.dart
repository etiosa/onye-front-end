// stores ExpansionPanel state information
import 'package:flutter/material.dart';
import 'package:onye_front_ened/pages/intakeform/forms/current_medication.dart';
import 'package:onye_front_ened/pages/intakeform/forms/family_history.dart';
import 'package:onye_front_ened/pages/intakeform/forms/past_medical_contions.dart';
import 'package:onye_front_ened/pages/intakeform/forms/vitals.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class Category {
  Category({required this.headerValue, required this.content});
  String headerValue;
  bool isExpended = false;
  Widget content;
}

//take an array list of Category

List<Category> generateCatgories(List<String> categories) {
  return List.generate(categories.length, (index) {
    return Category(headerValue: categories[index], content: widgets[index]);
  });
}

class IntakeForm extends StatefulWidget {
  const IntakeForm({Key? key}) : super(key: key);

  @override
  State<IntakeForm> createState() => _IntakeFormState();
}

List<String> test = [
  'Vital',
  'currentMedications',
  'pastMedicalConditions',
  'familyHistory'
];
List<Widget> widgets = [
  Vitals(),
  CurrentMedications(),
  PastMedicalConditions(),
  FamilyHistory()
];

class _IntakeFormState extends State<IntakeForm> {
  // final List<Item> _data = generateItems(3);

  final List<Category> _header = generateCatgories(test);

//map each category to a widget
//generate map and widget

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 253, 253),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Vitals()
             
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      dividerColor: const Color.fromARGB(255, 56, 155, 152),
      elevation: 1,
      expandedHeaderPadding: const EdgeInsets.all(10.0),
      animationDuration: const Duration(milliseconds: 200),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _header[index].isExpended = !isExpanded;
        });
      },
      children: _header.map<ExpansionPanel>((Category item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // const SizedBox(height: 10,),
               
                ],
              ),
            );
          },
          body: item.content,
          isExpanded: item.isExpended,
        );
      }).toList(),
    );
  }
}

class Vitals extends StatelessWidget {
  const Vitals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Address"),
        ),
        SizedBox(
          width: 320,
          height: 50,
          child: TextFormField(
         /*    onChanged: (addressLine1) =>
                context.read<PatientCubit>().setAddressLine1(addressLine1), */
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
          height: 50,
          child: TextFormField(
            /* onChanged: (addressLine2) =>
                context.read<PatientCubit>().setAddressLine2(addressLine2), */
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

           SizedBox(
          width: 320,
          height: 50,
          child: TextFormField(
            /* onChanged: (addressLine2) =>
                context.read<PatientCubit>().setAddressLine2(addressLine2), */
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
        Column(
          children: [
            SizedBox(
              width: 320,
              height: 50,
              child: TextFormField(
                /* onChanged: (addressLine2) =>
                    context.read<PatientCubit>().setAddressLine2(addressLine2), */
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
                SizedBox(
              width: 320,
              height: 50,
              child: TextFormField(
                /* onChanged: (addressLine2) =>
                    context.read<PatientCubit>().setAddressLine2(addressLine2), */
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
            )
          ],
        ),
      
      ],
    );
  }

  bool allAddressFieldsValid(BuildContext context) {
   /*  if (context.read<PatientCubit>().state.addressLine1 == null &&
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
 */
    return true;
  }
}



//an array of inPut 
class CurrentMedications extends StatefulWidget {
  CurrentMedications({Key? key}) : super(key: key);

  @override
  State<CurrentMedications> createState() => _CurrentMedicationsState();
}

class _CurrentMedicationsState extends State<CurrentMedications> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



//array of input
class PastMedicationCondtions extends StatelessWidget {
  const PastMedicationCondtions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FamilyHistory extends StatefulWidget {
  const FamilyHistory({ Key? key }) : super(key: key);

  @override
  State<FamilyHistory> createState() => _FamilyHistoryState();
}

class _FamilyHistoryState extends State<FamilyHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}