import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/button.dart';
import '../pages/auth/state/login_bloc.dart';
import '../session/authSession.dart';

class DashboardProfile extends StatelessWidget {
  const DashboardProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      //change this Profile bloc using session
      builder: (context, state) {

        return SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               
                children: [
                 const  Padding(
                  padding: EdgeInsets.only(
                      top:2,
                      bottom: 1.0,
                      left:2),
                  child:  Text(
                    "Good afternoon", //take the user syste, current time ....base on that display greeting
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize:  30),
                  ),
                ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 55,
                        left: MediaQuery.of(context).size.width / 9),
                    child: Text(
                      '${context.read<LoginBloc>().state.firstName} ${context.read<LoginBloc>().state.lastName}',
                      style: const TextStyle(fontSize: 17, fontFamily: 'poppins'),
                    ),
                  ),
                     Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      context.read<LoginBloc>().state.department,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 115, 109, 109)),
                    ),
                  ),
                    const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      context.read<LoginBloc>().state.hospital,
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
                
              ),
           
            
            ],
          ),
        );
      },
    );
  }
}

