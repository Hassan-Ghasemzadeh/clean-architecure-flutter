// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cleanarchitecureflutter/core/error/failures.dart';
import 'package:cleanarchitecureflutter/core/usecase/usecase.dart';
import 'package:cleanarchitecureflutter/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:cleanarchitecureflutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:cleanarchitecureflutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import '../../../domain/entities/number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverfailure = 'Server Failure';
const String invalidInputFailure = 'Invalid Input';
const String cacheFailure = 'Cache Failure';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getTriviaForRandomNumber;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getTriviaForRandomNumber,
    required this.inputConverter,
  }) : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetTriviaForConcreteNumber) {
        //final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);
        emit(Loading());
        final failureOrTrivia = await getConcreteNumberTrivia(
            Params(number: int.parse(event.numberString)));
        final result = await _getTriviaOrFailure(failureOrTrivia);
        emit(result);
      } else if (event is GetTriviaForRandomNumber) {
        emit(Loading());
        final failureOrTrivia = await getTriviaForRandomNumber(NoParams());

        final result = await _getTriviaOrFailure(failureOrTrivia);
        emit(result);
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverfailure;
      case CacheFailure:
        return cacheFailure;
      default:
        return 'Unexpected error';
    }
  }

  Future<NumberTriviaState> _getTriviaOrFailure(
      Either<Failure, NumberTrivia> failureOrTrivia) async {
    return failureOrTrivia.fold(
      (failure) => Error(
        message: _mapFailureToMessage(failure),
      ),
      (trivia) => Loaded(trivia: trivia),
    );
  }
}
