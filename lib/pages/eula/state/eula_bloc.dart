import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onye_front_ened/pages/eula/repository/eula_repository.dart';

part 'eula_event.dart';
part 'eula_state.dart';

class EulaBloc extends Bloc<EulaEvent, EulaState> {
  final EulaRepository _eulaRepository = EulaRepository();

  EulaBloc() : super(const EulaState()) {
    on<LoadBetaContract>(_setBetaContract);
    on<AcceptContract>(_acceptBetaContract);
  }

  void _setBetaContract(LoadBetaContract event, Emitter<EulaState> emit) async {
    emit(state.copywith(fetchingcontract: FETCHINGCONTRACT.loading));
    try {
      var licenseResponse =
          await _eulaRepository.getLicenseAgreement(token: event.token);

      final body = jsonDecode(licenseResponse!.body);
      final license = body['licenseAgreement'];
      final statusCode = licenseResponse.statusCode;
      if (statusCode != 200) {
        // add(LoadingErrorBetaContract(error: body));
        emit(state.copywith(error: body));
      } else {
        emit(state.copywith(
            betaContract: license, fetchingcontract: FETCHINGCONTRACT.loaded));
      }
    } catch (err) {
             emit(state.copywith(error: err.toString()));
    }
  }

  void _acceptBetaContract(
      AcceptContract event, Emitter<EulaState> emit) async {
    add(AccpetingBetaContract());

    try {
      var acceptContractReponse = await _eulaRepository.acceptContract(
          token: event.token, userId: event.userId);
      final statusCode = acceptContractReponse?.statusCode;
      if (statusCode == 204) {
        add(BetaContractAccept());
        emit(state.copywith(isContractAccept: true));
      } else {
        add(AcceptBetaFailed(acceptContractReponse!.body.toString()));
      }
    } catch (err) {
      add(AccepBetaContractUnknownError(err.toString()));
    }
  }
}
