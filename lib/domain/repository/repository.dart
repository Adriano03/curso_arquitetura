import 'package:curso_arquitetura/data/network/failure.dart';
import 'package:curso_arquitetura/data/request/request.dart';
import 'package:curso_arquitetura/domain/models/model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
