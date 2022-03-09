part of 'formdropdown_cubit.dart';

class FormdropdownState extends Equatable {
  const FormdropdownState(
      {this.educationLevel = const [],
      this.ethnicity = const [],
      this.gender = const [],
      this.religion = const []});

  final List<String> gender;
  final List<String> religion;
  final List<String> ethnicity;
  final List<String> educationLevel;

  @override
  List<Object> get props => [];

  FormdropdownState copyWith({
    List<String>? gender,
    List<String>? religion,
    List<String>? ethnicity,
    List<String>? educationLevel,
  }) {
    return FormdropdownState(
      gender: gender ?? this.gender,
      religion: religion ?? this.religion,
      ethnicity: ethnicity ?? this.ethnicity,
      educationLevel: educationLevel ?? this.educationLevel,
    );
  }
}
