part of 'onye_bloc.dart';

abstract class OnyeEvent extends Equatable {
  const OnyeEvent();

  @override
  List<Object> get props => [];
}

class FetchDatas extends OnyeEvent  {}

