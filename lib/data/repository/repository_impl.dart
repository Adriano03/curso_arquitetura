import 'package:curso_arquitetura/data/data_source/remote_data_source.dart';
import 'package:curso_arquitetura/data/mapper/mapper.dart';
import 'package:curso_arquitetura/data/network/error_handler.dart';
import 'package:curso_arquitetura/data/network/failure.dart';
import 'package:curso_arquitetura/data/network/network_info.dart';
import 'package:curso_arquitetura/data/request/request.dart';
import 'package:curso_arquitetura/domain/models/model.dart';
import 'package:curso_arquitetura/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // é seguro chamar a api;
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // retorna dados. (Right)
          return Right(response.toDomain());
        } else {
          // retorna logica erro (Left)
          return Left(
            Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // retorna erro de conexão;
      return Left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }
}
