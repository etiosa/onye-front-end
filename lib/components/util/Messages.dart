import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Messages {
  static void showMessage(Icon icon, String text) {
    showToastWidget(
      Container(
        width: 220.0,
        height: 50.0,
        color: const Color.fromRGBO(240, 240, 240, 0.9),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: icon,
                ),
                TextSpan(text: '   $text'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
