part of 'convert_bloc.dart';

@immutable
class ConvertState {
  final double rate;
  final double enteredValue;
  final double calculated;
  final bool secondUzs;

  const ConvertState({
    this.rate = 1,
    this.enteredValue = 0,
    this.calculated = 0,
    this.secondUzs = true,
  });

  ConvertState copyWith({double? rate, double? enteredValue, double? calculated, bool? secondUzs}) => ConvertState(
        rate: rate ?? this.rate,
        enteredValue: enteredValue ?? this.enteredValue,
        calculated: calculated ?? this.calculated,
        secondUzs: secondUzs ?? this.secondUzs,
      );
}
