import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:onye_front_ened/Widgets/button.dart';
import 'package:onye_front_ened/components/util/Modal.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/pages/eula/state/eula_bloc.dart';

class Eula extends StatelessWidget {
  const Eula({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / .4,
              child: const Contract(),
            ),
          ),
        ),
      ),
    );

    /*  */
  }
}

//TODO: change this to it's own block
class Contract extends StatelessWidget {
  const Contract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EulaBloc, EulaState>(listener: (context, state) {
      if (state.fetchingcontract == FETCHINGCONTRACT.loading) {
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
                const Text('Accept in Progress'),
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
            progressDetails: 'progrss');
      }

      if (state is BetaContractAccept) {
        Modal(
            context: context,
            modalType: '',
            inclueAction: true,
            actionButtons: TextButton(
                child: const Text('Close'),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    //TODO: once it's accept  remove this  from the stack and push to dashboard
                    Navigator.of(context, rootNavigator: true).pop(true);
                    Navigator.of(context, rootNavigator: true).pop(true);
                    Navigator.of(context).pushNamed("/dashboard");
                  });
                  //navigate to the dashboard
                }),
            modalBody: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 20,
                ),
                Text('Sucessful accept contract'),
                SizedBox(height: 30),
                Icon(
                  Icons.check,
                  size: 100,
                  color: Color.fromARGB(255, 56, 155, 152),
                )
              ],
            ),
            progressDetails: 'prog');
      }

      if (state.fetchingcontract == FETCHINGCONTRACT.unknown) {
        Modal(
            context: context,
            modalType: 'Unkown',
            inclueAction: true,
            actionButtons: TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(true);
                  Navigator.of(context, rootNavigator: true).pop(true);
                }),
            modalBody: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 40,
                ),
                Text('Uknow error, please login again'),
                SizedBox(height: 20),
                Icon(
                  Icons.dangerous,
                  color: Colors.redAccent,
                  size: 100,
                )
              ],
            ),
            progressDetails: 'Uknow error, please login again');
      }

   /*    if (state.fetchingcontract == FETCHINGCONTRACT.unknown ) {
        Modal(
            context: context,
            modalType: 'Unkown',
            inclueAction: true,
            actionButtons: TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(true);
                  Navigator.of(context, rootNavigator: true).pop(true);
                }),
            modalBody: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 40,
                ),
                Text('please login again'),
                SizedBox(height: 20),
                Icon(
                  Icons.dangerous,
                  color: Colors.redAccent,
                  size: 100,
                )
              ],
            ),
            progressDetails: 'please login again');
      } */
    }, builder: ((context, state) {
      if (state.fetchingcontract == FETCHINGCONTRACT.loading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text('Loading Contract'),
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
        );
      }

      if (state.fetchingcontract == FETCHINGCONTRACT.failed) {
        return const Center(
          child: Text("failed to load contract please check internet"),
        );
      }

      if (state.fetchingcontract == FETCHINGCONTRACT.unknown) {
        return const Center(
          child: Text("unable to load contract"),
        );
      }
      if (state.fetchingcontract == FETCHINGCONTRACT.loaded) {
        return SingleChildScrollView(
          child: Column(
            children: [
              MarkdownBody(
                data: state.betaContract,
                shrinkWrap: true,
              ),
              Button(
                  height: 50,
                  width: 200,
                  label: 'Accept',
                  onPressed: () {
                    acceptContract(context);
                  })
            ],
          ),
        );
      }

      return const Center(
        child: Text("no contract"),
      );
    }));
  }
}

void acceptContract(BuildContext context) {
  var token = context.read<LoginBloc>().state.homeToken;
  var userId = context.read<LoginBloc>().state.userId;
  context.read<EulaBloc>().add(AcceptContract(token: token, userId: userId));
}
