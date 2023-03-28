import 'package:bloc/bloc.dart';
import 'package:currency_app/core/api/currency_api.dart';
import 'package:meta/meta.dart';

import '../core/models/currency_model.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final CurrencyApi api;

  MainBloc(this.api) : super(MainState()) {
    on<GetLastEvent>((event, emit) async{
      emit(state.copyWith(status: Status.loading));
      try {
        emit(state.copyWith(
          status: Status.success,
          currencies: await api.getCurrencies(),
        ));
      } catch (e) {
        emit(state.copyWith(status: Status.fail, message: '$e'));
      }
    });
    on<GetDateEvent>((event, emit) async{
      emit(state.copyWith(status: Status.loading));
      try {
        emit(state.copyWith(
          status: Status.success,
          currencies: await api.getCurrencies(date: event.date),
        ));
      } catch (e) {
        emit(state.copyWith(status: Status.fail, message: '$e'));
      }
    });
    on<ChooseLang>((event, emit) {
      // emit();
    });
  }
}
