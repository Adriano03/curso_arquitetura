// ignore_for_file: constant_identifier_names

import 'package:curso_arquitetura/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // Erro de resposta da API
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();

      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();

      case DioErrorType.badCertificate:
        return DataSource.DEFAULT.getFailure();

      case DioErrorType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }

      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();

      case DioErrorType.connectionError:
        return DataSource.NO_INTERNET_CONNECTION.getFailure();
      case DioErrorType.unknown:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);

      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
            ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);

      case DataSource.RECEIVE_TIMEOUT:
        return Failure(ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
            ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);

      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);

      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  // código de status da API
  static const int SUCCESS = 200; // Sucesso com os dados;
  static const int NO_CONTENT = 201; // Sucesso  sem conteúdo;
  static const int BAD_REQUEST = 400; // Falha, api rejeitada na requisição;
  static const int FORBIDDEN = 403; // Falha, api rejeitada na requisição;
  static const int UNAUTHORIZED = 401; // Falha, usuário não autorizado;
  static const int NOT_FOUND = 404; // // Falha, url da api não encontrada;
  static const int INTERNAL_SERVER_ERROR = 500; // Falha, servidor com problema;

  // código de status local
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  // código de status da API
  static const String SUCCESS = 'Sucesso';
  static const String NO_CONTENT = 'Sucesso, mas sem dados para mostrar';
  static const String BAD_REQUEST = 'Solicitação inválida. Tente novamente mais tarde';
  static const String FORBIDDEN = 'Requisição proibida. Tente novamente mais tarde';
  static const String UNAUTHORIZED = 'Usuário não autorizado. Tente novamente mais tarde';
  static const String NOT_FOUND = 'Url não encontrada. Tente novamente mais tarde';
  static const String INTERNAL_SERVER_ERROR = 'Erro no servidor. Tente novamente mais tarde';

  // código de status local
  static const String DEFAULT = 'Erro desconhecido. Tente novamente mais tarde';
  static const String CONNECT_TIMEOUT = 'Tempo limite excedido. Tente novamente mais tarde';
  static const String CANCEL = 'Requisição foi cancelada. Tente novamente mais tarde';
  static const String RECEIVE_TIMEOUT = 'Tempo limite excedido. Tente novamente mais tarde';
  static const String SEND_TIMEOUT = 'Tempo limite excedido. Tente novamente mais tarde';
  static const String CACHE_ERROR = 'Erro no cache. Tente novamente mais tarde';
  static const String NO_INTERNET_CONNECTION = 'Verifique sua conexão com a internet';
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
