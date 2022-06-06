// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cleanarchitecureflutter/core/error/exception.dart';
import 'package:dartz/dartz.dart';

import 'package:cleanarchitecureflutter/core/error/failures.dart';
import 'package:cleanarchitecureflutter/core/network/network_info.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../models/number_trivia_model.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  NumberTriviaLocalDataSource localDataSource;
  NumberTriviaRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  NumberTriviaRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int? number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number!);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTriviaModel>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localtrivia = await localDataSource.getLastNumberTrivia();
        return Right(localtrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
