import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';

// we use Either to handle exception left side of either is for handling exception and right side is for handling success
abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int? number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
