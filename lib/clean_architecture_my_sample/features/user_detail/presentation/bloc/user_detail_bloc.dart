import 'package:first_flutter/clean_architecture_my_sample/core/error/failures.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/domain/use_cases/get_user_detail.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/presentation/bloc/user_detail_event.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/presentation/bloc/user_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserDetail getUserDetail;

  UserDetailBloc({required this.getUserDetail})
      : super(UserDetailEmptyState()) {
    on<GetUserDetailEvent>((event, emit) async {
      emit(UserDetailLoadingState());

      final result = await getUserDetail.execute(Params(userId: event.userId));
      result.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(UserDetailErrorState(message: SERVER_FAILURE_MESSAGE));
            break;
          case CacheFailure:
            emit(UserDetailErrorState(message: CACHE_FAILURE_MESSAGE));
            break;
          default:
            emit(UserDetailErrorState(message: 'Unexpected error'));
            break;
        }
      }, (user) => emit(UserDetailLoadedState(user: user)));
    });
  }
}
