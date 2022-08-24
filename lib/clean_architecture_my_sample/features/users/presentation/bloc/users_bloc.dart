import 'package:bloc/bloc.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/error/failures.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/usecases/usecase.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/usecases/get_users.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/presentation/bloc/bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers getUsers;

  UsersBloc(
      {required GetUsers getUsers})
      : getUsers = getUsers,
        super(UsersEmptyState()) {

    on<GetUsersEvent>((event, emit) async {
      emit(UsersLoadingState());
      final result = await getUsers.execute(NoParams());
      result.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(UsersErrorState(message: SERVER_FAILURE_MESSAGE));
            break;
          case CacheFailure:
            emit(UsersErrorState(message: CACHE_FAILURE_MESSAGE));
            break;
          default:
            emit(UsersErrorState(message: 'Unexpected error'));
            break;
        }
      }, (users) => emit(UsersLoadedState(users: users)));
    });
  }
}
