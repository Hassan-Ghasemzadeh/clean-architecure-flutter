import 'package:cleanarchitecureflutter/core/usecase/usecase.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;
  GetRandomNumberTrivia({
    required this.repository,
  });
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
