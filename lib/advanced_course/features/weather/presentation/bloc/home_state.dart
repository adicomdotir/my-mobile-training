import 'package:equatable/equatable.dart';
import 'package:first_flutter/advanced_course/features/weather/presentation/bloc/fw_status.dart';

import 'cw_status.dart';

class HomeState extends Equatable {
  final CwStatus cwStatus;
  final FwStatus fwStatus;

  const HomeState({required this.cwStatus, required this.fwStatus});

  HomeState copyWith({CwStatus? newCwStatus, FwStatus? newFwStatus}) {
    return HomeState(
        cwStatus: newCwStatus ?? cwStatus, fwStatus: newFwStatus ?? fwStatus);
  }

  @override
  List<Object?> get props => [cwStatus, fwStatus];
}
