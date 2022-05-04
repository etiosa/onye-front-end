
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void Modal(
    {required BuildContext context,
    int? paddingLeft,
    int? paddingRight,
    int? paddingTop,
    int? paddingBottom,
    required bool inclueAction,
    required String? modalType,
    required Widget modalBody,
    Widget? actionButtons,
    String? progressDetails}) {
  showDialog(
      barrierColor: const Color.fromARGB(10, 0, 0, 0),
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          insetPadding:
              const EdgeInsets.only(left: 1, right: 1, bottom: 100, top: 100),
          content: modalBody,
          actions: [
                  inclueAction?actionButtons!: Container()
          ],
        );
      });
}



