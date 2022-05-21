import 'package:first_flutter/clean_architecture_app/data/network/failure.dart';
import 'package:first_flutter/clean_architecture_app/data/request/request.dart';
import 'package:first_flutter/clean_architecture_app/domain/model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}