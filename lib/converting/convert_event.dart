part of 'convert_bloc.dart';

@immutable
abstract class ConvertEvent {}

class ChangeEvent extends ConvertEvent{ }
class TypeAmountEvent extends ConvertEvent{
  final String amount;

  TypeAmountEvent(this.amount);
}
class EnterRateEvent extends ConvertEvent{
  final String rate;

  EnterRateEvent(this.rate);
}