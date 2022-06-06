import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

class Params extends Equatable {
  final int? number;
  const Params({
    required this.number,
  });

  @override
  List<Object?> get props => [number];
}

abstract class UseCase<type, Params> {
  Future<Either<Failure, type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
