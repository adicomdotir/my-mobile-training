import 'package:equatable/equatable.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';

abstract class UserDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserDetailEmptyState extends UserDetailState {}

class UserDetailLoadingState extends UserDetailState {}

class UserDetailLoadedState extends UserDetailState {
  final User user;

  UserDetailLoadedState({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserDetailErrorState extends UserDetailState {
  final String message;

  UserDetailErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
