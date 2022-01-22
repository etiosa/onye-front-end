import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'connection_cubit_state.dart';

class ConnectionCubitCubit extends Cubit<ConnectionCubitState> {
  ConnectionCubitCubit() : super(ConnectionCubitInitial());
}
