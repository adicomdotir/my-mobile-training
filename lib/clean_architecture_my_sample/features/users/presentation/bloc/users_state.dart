import 'package:equatable/equatable.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersEmptyState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadedState extends UsersState {
  final List<User> users;

  UsersLoadedState({required this.users});

  @override
  List<Object?> get props => [users];
}

class UsersErrorState extends UsersState {
  final String message;

  UsersErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
