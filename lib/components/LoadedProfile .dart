import 'package:flutter/material.dart';
import 'package:onye_front_ened/Widgets/Button.dart';
import 'package:onye_front_ened/components/util/DesktopMenu.dart';
import 'package:onye_front_ened/components/util/MobileDashboardMenu.dart';

class LoadedProfile extends StatelessWidget {
  const LoadedProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Button(
          height: 40,
          label: 'Logout',
          onPressed: () {},
          width: 100,
        ),
        Padding(
          padding: MediaQuery.of(context).size.width >= 730
              ? EdgeInsets.only(
                  left: MediaQuery.of(context).size.width >= 730 ? 160 : 60,
                  top: 100)
              : const EdgeInsets.only(left: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Good Morning',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        MediaQuery.of(context).size.width >= 730 ? 50 : 20),
              ),
              const Text(
                'Doctor Joe',
                style: TextStyle(fontSize: 17, fontFamily: 'poppins'),
              ),
              const Text(
                "Surgert",
                style: TextStyle(color: Color.fromARGB(255, 115, 109, 109)),
              ),
              const Text(
                "Hopistal",
                style: TextStyle(color: Color.fromARGB(255, 115, 109, 109)),
              )
            ],
          ),
        ),
        const SizedBox(height: 50),
        MediaQuery.of(context).size.width <= 730
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    MobileDashboardMenu(),
                  ],
                ),
              )
            : const DesktopMenu(),
      ],
    );
  }
}
