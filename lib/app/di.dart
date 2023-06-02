import 'package:curso_arquitetura/app/app_preferences.dart';
import 'package:curso_arquitetura/data/data_source/remote_data_source.dart';
import 'package:curso_arquitetura/data/network/app_api.dart';
import 'package:curso_arquitetura/data/network/dio_factory.dart';
import 'package:curso_arquitetura/data/network/network_info.dart';
import 'package:curso_arquitetura/data/repository/repository_impl.dart';
import 'package:curso_arquitetura/domain/repository/repository.dart';
import 'package:curso_arquitetura/domain/use_case/login_use_case.dart';
import 'package:curso_arquitetura/presentation/login/login_view_model.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(DataConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
