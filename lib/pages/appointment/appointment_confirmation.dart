import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  Confirmation(
      {Key? key, required this.appointmentList, required this.selectedIndex})
      : super(key: key);
  final List<dynamic> appointmentList;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 30,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
                (appointmentList[selectedIndex]['type'] == 'registration')
                    ? const Color.fromARGB(255, 56, 155, 152)
                    : Colors.grey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ))),
        onPressed: () => {
          (appointmentList[selectedIndex]['type'] == 'registration')
              ? showDialogConfirmation(context)
              : null
        },
        child: const Text('Checkin'),
      ),
    );
  }

  Future<String?> showDialogConfirmation(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Do you want to check this patient in'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
