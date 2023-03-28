part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class GetLastEvent extends MainEvent{

}
class GetDateEvent extends MainEvent{
  final DateTime date;

  GetDateEvent(this.date);
}
class ChooseLang extends MainEvent{

}