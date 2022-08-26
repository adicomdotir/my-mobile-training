import 'package:first_flutter/advanced_course/features/weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:first_flutter/advanced_course/features/weather/presentation/bloc/cw_status.dart';
import 'package:first_flutter/advanced_course/features/weather/presentation/bloc/home_event.dart';
import 'package:first_flutter/advanced_course/features/weather/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  HomeBloc({required this.getCurrentWeatherUseCase})
      : super(HomeState(cwStatus: CwLoading())) {
    on<LoadCwEvent>((event, emit) async {
      emit(state.copyWith(newCwStatus: CwLoading()));

      DataState dataState = await getCurrentWeatherUseCase(event.cityName);

      if (dataState is DataSuccess) {
        emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
      }
    });
  }
}
