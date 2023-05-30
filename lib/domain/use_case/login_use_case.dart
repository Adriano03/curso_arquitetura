import 'package:curso_arquitetura/app/functions.dart';
import 'package:curso_arquitetura/data/request/request.dart';
import 'package:dartz/dartz.dart';

import 'package:curso_arquitetura/data/network/failure.dart';
import 'package:curso_arquitetura/domain/models/model.dart';
import 'package:curso_arquitetura/domain/repository/repository.dart';
import 'package:curso_arquitetura/domain/use_case/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUserCaseInput, Authentication> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUserCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();

    return await _repository.login(
      LoginRequest(
        email: input.email,
        password: input.password,
        imei: deviceInfo.identifier,
        deviceType: deviceInfo.name,
      ),
    );
  }
}

class LoginUserCaseInput {
  String email;
  String password;

  LoginUserCaseInput(this.email, this.password);
}
