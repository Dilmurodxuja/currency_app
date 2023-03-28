import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'convert_event.dart';
part 'convert_state.dart';

class ConvertBloc extends Bloc<ConvertEvent, ConvertState> {
  ConvertBloc() : super(ConvertState()) {
      on<EnterRateEvent>((event, emit) async{
        emit(state.copyWith(
            rate: double.parse(event.rate)
        ));
      });
      on<TypeAmountEvent>((event, emit) async{
        emit(state.copyWith(
          enteredValue: double.parse(event.amount)
        ));
        emit(state.copyWith( calculated: calculated ));
      });
      on<ChangeEvent>((event, emit) async{
        emit(state.copyWith(
          rate: 1 / state.rate,
          secondUzs: !state.secondUzs,
        ));
        emit(state.copyWith(
          calculated: calculated,
        ));
      });
    }

  double get calculated => state.rate * state.enteredValue;
}
