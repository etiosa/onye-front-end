import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';

import '../../../components/util/Modal.dart';
import '../../../session/auth_session.dart';
import '../../../util/util.dart';
import '../form/additional_information.dart';
import '../form/basic_information.dart';
import '../form/contact_information.dart';
import '../form/validator/patient_form_validator.dart';

class PatientProfile extends StatefulWidget {
  PatientProfile({Key? key}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PatientFormValidator validator = PatientFormValidator();
  final PageController _pageController = PageController();
  AuthSession authsession = AuthSession();

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  void nextPage() {
    _pageController.nextPage(
        curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Util.hasTokenExpired()) {
      //relogin
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Modal(
            inclueAction: true,
            actionButtons: TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/login'));
                  //Navigator.of(context).pushNamed("/login");
                }),
            context: context,
            modalType: 'failed',
            modalBody: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 40,
                ),
                Text('Token expires, please relogin'),
                SizedBox(height: 20),
                Icon(
                  Icons.error,
                  color: Colors.redAccent,
                  size: 100,
                )
              ],
            ),
            progressDetails: 'relogin');
      });
    } else {
      final AuthSession authsession = AuthSession();
      authsession.getHomeToken()?.then((token) async {
        context.read<PatientCubit>().fetchPatient(
            token: token,
            patientId: context.read<PatientCubit>().state.selectedPatientId);
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

    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<PatientCubit, PatientState>(
              listener: ((context, state) {
        //fecthing the patient detail
        print(state.fetchpatientstate);

        if (state.fetchpatientstate == FETCHPATIENTSTATE.inprogress) {
          Modal(
              context: context,
              modalType: '',
              inclueAction: false,
              modalBody: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Fetching patient'),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.grey[500],
                        strokeWidth: 4,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 56, 155, 152)),
                      )),
                ],
              ),
              progressDetails: 'Fetching patient');
        }  if (state.fetchpatientstate == FETCHPATIENTSTATE.fetch) {
          Navigator.popUntil(context,
              ModalRoute.withName('/dashboard/patient/patientprofile'));
        } if (state.fetchpatientstate == FETCHPATIENTSTATE.error ||
            state.fetchpatientstate == FETCHPATIENTSTATE.unknownm) {
          Modal(
              inclueAction: true,
              actionButtons: TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/dashboard/patient'));
                    context.read<PatientCubit>().resetFecthAndSaveState();

                    // context.read<RegisterationCubit>().setRegisterState();
                  }),
              context: context,
              modalType: 'failed',
              modalBody: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    height: 40,
                  ),
                  Text('Unable to fetch patient, please try again'),
                  SizedBox(height: 20),
                  Icon(
                    Icons.error,
                    color: Colors.redAccent,
                    size: 100,
                  )
                ],
              ),
              progressDetails: "Unable to fetch patient, please try again");
        }
        if (state.patienteditstate == PATIENTEDITSTATE.inprogress) {
          Modal(
              context: context,
              modalType: '',
              inclueAction: false,
              modalBody: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Saving patient in progress'),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.grey[500],
                        strokeWidth: 4,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 56, 155, 152)),
                      )),
                ],
              ),
              progressDetails: 'Saving patient in progress');
        }
        if (state.patienteditstate == PATIENTEDITSTATE.save) {
          Modal(
              context: context,
              modalType: '',
              inclueAction: true,
              actionButtons: TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/dashboard/patient'));
                    context.read<PatientCubit>().resetFecthAndSaveState();

                    //after save we need to restart the state
                    //context.read<RegisterationCubit>().setRegisterState();
                  }),
              modalBody: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Text('Sucessful Saved Patient information'),
                  SizedBox(height: 30),
                  Icon(
                    Icons.check,
                    size: 100,
                    color: Color.fromARGB(255, 56, 155, 152),
                  )
                ],
              ),
              progressDetails: 'Sucessful Saved Patient information');
        }
        if (state.patienteditstate == PATIENTEDITSTATE.unknown ||
            state.patienteditstate == PATIENTEDITSTATE.unknown) {
          Modal(
              inclueAction: true,
              actionButtons: TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/dashboard/patient'));
                    context.read<PatientCubit>().resetFecthAndSaveState();
                    // context.read<RegisterationCubit>().setRegisterState();
                  }),
              context: context,
              modalType: 'failed',
              modalBody: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    height: 40,
                  ),
                  Text('Unable to save patient, please try again'),
                  SizedBox(height: 20),
                  Icon(
                    Icons.error,
                    color: Colors.redAccent,
                    size: 100,
                  )
                ],
              ),
              progressDetails: "Unable to save patient, please try again");
        }
      }), builder: (context, state) {
        if (state.fetchpatientstate == FETCHPATIENTSTATE.fetch) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20),
                  child: Text(
                    "Edit patient record",
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
                                duration: const Duration(milliseconds: 300));
                          } else {
                            context.read<PatientCubit>().clearState();
                              context.read<PatientCubit>().resetFecthAndSaveState();

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
                            authsession.getHomeToken()!.then((homeToken) {
                              if (homeToken != '') {
                                context.read<PatientCubit>().editPatient(
                                    token: homeToken,
                                    patientId: state.selectedPatientId);
                              }
                            });

                            /*  var response = await context
                                .read<PatientCubit>()
                                .createNewPatient(
                                    token: context
                                        .read<LoginBloc>()
                                        .state
                                        .homeToken); */

                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return (Container());
      })),
    );
  }
}


/* Column(children: [
              BasicInfoFormBody(formKey: formKey, validator: validator)
            ])*/