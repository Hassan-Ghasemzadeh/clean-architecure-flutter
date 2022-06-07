import 'dart:io';

import 'package:cleanarchitecureflutter/core/network/network_info.dart';
import 'package:cleanarchitecureflutter/core/util/input_converter.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/presentation/bloc/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

final ic = GetIt.I;

Future<void> init() async {
  //! Features - Number Trivia
  initFeatures();
  //! Core
  initCore();
  //! util
}

void initFeatures() {
  //bloc
  ic.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: ic(),
      getTriviaForRandomNumber: ic(),
      inputConverter: ic()));

  //usecase

  ic.registerLazySingleton(() => GetConcreteNumberTrivia(repository: ic()));

  ic.registerLazySingleton(() => GetRandomNumberTrivia(repository: ic()));

  //repository
  ic.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: ic(),
      remoteDataSource: ic(),
      networkInfo: ic(),
    ),
  );

  //data source
  //! remote data source
  ic.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: ic(),
    ),
  );

  //! local data source
  ic.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: ic(),
    ),
  );
}

void initCore() async {
  ic.registerLazySingleton(() => InputConverter());

  //network info
  ic.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      ic(),
    ),
  );

  //shared preference
  final sharedPreferences = await SharedPreferences.getInstance();
  ic.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  ic.registerLazySingleton(() => HttpClient());
}
