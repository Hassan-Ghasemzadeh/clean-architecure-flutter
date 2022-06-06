//our test file name must end with _test.dart else it can't work

import 'package:cleanarchitecureflutter/core/usecase/usecase.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

@GenerateMocks([MockNumberTriviaRepository])
void main() {
  GetConcreteNumberTrivia usecase = GetConcreteNumberTrivia(
    repository: MockNumberTriviaRepository(),
  );
  MockNumberTriviaRepository mockNumberTriviaRepository =
      MockNumberTriviaRepository();
}
