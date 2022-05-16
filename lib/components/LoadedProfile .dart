import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/Button.dart';
import 'package:onye_front_ened/components/util/DesktopMenu.dart';
import 'package:onye_front_ened/components/util/MobileDashboardMenu.dart';

import '../pages/auth/state/login_bloc.dart';

class LoadedProfile extends StatefulWidget {
  const LoadedProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadedProfile> createState() => _LoadedProfileState();
}

class _LoadedProfileState extends State<LoadedProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Button(
          height: 40,
          label: 'Logout',
          onPressed: () async {
            logout(context);
          },
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
            children: [
              Text(
                getDay(context),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        MediaQuery.of(context).size.width >= 730 ? 50 : 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${context.read<LoginBloc>().state.firstName} ${context.read<LoginBloc>().state.lastName}',
                style: const TextStyle(fontSize: 17, fontFamily: 'poppins'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                context.read<LoginBloc>().state.specialty.toLowerCase(),
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'poppins',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                context.read<LoginBloc>().state.hospital,
                style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
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

  String getDay(BuildContext context) {
    int currentTime = DateTime.now().hour;
    if (currentTime >= 0 && currentTime <= 11) {
      return 'Good Morning';
    }

    if (currentTime >= 12 && currentTime <= 18) {
      return "Good Afternoon";
    }

    if (currentTime >=18 && currentTime <= 24) {
      return "Good Evening";
    }
    return "Good Evening";
  }
}

void logout(BuildContext context) async {
  context.read<LoginBloc>().add(LogOut());
  WidgetsBinding.instance?.addPostFrameCallback((_) {
    Navigator.popAndPushNamed(context, '/login');
  });
}
