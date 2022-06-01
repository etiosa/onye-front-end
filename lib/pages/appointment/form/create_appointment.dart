import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/Widgets/pagination.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import '../../../Widgets/search_bar.dart';
import '../../../components/doctor_list.dart';
import '../../../components/patient_list.dart';
import '../../doctor/state/doctor_cubit_cubit.dart';
import 'register_form_view.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<CreateAppointment> createState() => _CreateRegistrationState();
}

class _CreateRegistrationState extends State<CreateAppointment> {
  //int _index = 0;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;

  @override
  void initState() {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25.0, left: 20),
              child: Text(
                "Create Appointment",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
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
                    //Search doctor
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SearchBar(
                          formIndex: 0,
                          field: 'Search doctor',
                        ),
                        const SizedBox(height: 10),
                        DoctorList(
                          pageController: controller,
                        ),
                      ],
                    ),
                    const Register(formIndex: 2)
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

Future dateTimePicker(BuildContext context, String label) async {
  final newTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (newTime == null) return;

  String formatTime = newTime.format(context);

  context.read<AppointmentCubit>().setAppointmentTime(formatTime);
}

class DateTimePickerField extends StatelessWidget {
  const DateTimePickerField({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                dateTimePicker(context, label);
              },
              child: Container(
                height: 45,
                width: 100,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TimeContent(
                      label: label,
                    )),
              ),
            ),
          ],
        ));
      },
    );
  }
}

//remove the from and too time content
class TimeContent extends StatelessWidget {
  const TimeContent({Key? key, required this.label}) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(context.read<AppointmentCubit>().state.appointmentTime);
  }
}

Future datePicker(BuildContext context, String label) async {
  var dateFormat = DateFormat('yyyy-MM-dd');

  final initDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 5));

  String formattedDate = dateFormat.format(newDate!);

  // ignore: unnecessary_null_comparison
  if (newDate == null) return;
  context.read<AppointmentCubit>().setAppointmentDate(formattedDate);
}

//extract the daetPickerField

class DatePickerField extends StatelessWidget {
  const DatePickerField({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                datePicker(context, label);
              },
              child: Container(
                height: 45,
                width: 100,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextContent(
                    label: label,
                  ),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
      child: Text(context.read<AppointmentCubit>().state.appointmentDate,
          style: const TextStyle(fontSize: 12)),
    );
  }
}

Future<Response?>? createAppointmentData({required BuildContext context}) {
  if (context.read<DoctorCubit>().state.selectedMedicalPersonnelId.isNotEmpty &&
      context.read<PatientCubit>().state.selectedPatientId.isNotEmpty) {
    var response = context.read<AppointmentCubit>().createAppointment(
        date: context.read<AppointmentCubit>().state.appointmentDate,
        time: context.read<AppointmentCubit>().state.appointmentTime,
        patientID: context.read<PatientCubit>().state.selectedPatientId,
        medicalId: context.read<DoctorCubit>().state.selectedMedicalPersonnelId,
        token: context.read<LoginBloc>().state.homeToken,
        reasonForVisit: context.read<AppointmentCubit>().state.reasonForVisit,
        typeOfVisit: context.read<AppointmentCubit>().state.typeOfVisit);
    return response;
  }
  return null;
}

// ignore: must_be_immutable
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
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(builder: (context, state) {
      return
          //const SizedBox(height: 10),
          Column(
        children: [
          PatientList(
            pageController: widget.pageController,
          ),
          Pagination(
            typeofSearch: 'patient',
            maxPageCounter: context.read<PatientCubit>().state.maxPageNumber,
          )
        ],
      );
    });
  }
}
