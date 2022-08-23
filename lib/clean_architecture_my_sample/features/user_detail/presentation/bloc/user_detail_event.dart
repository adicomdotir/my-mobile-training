import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserDetailEvent extends UserDetailEvent {
  final int userId;

  GetUserDetailEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}