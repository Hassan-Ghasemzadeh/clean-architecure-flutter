// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:cleanarchitecureflutter/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../core/error/exception.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Saves the [NumberTrivia] to the cache.
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const cachednumbertrivia = 'CHACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      cachednumbertrivia,
      json.encode(triviaToCache.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = sharedPreferences.getString(cachednumbertrivia);

    if (jsonString != null) {
      return NumberTriviaModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException();
    }
  }
}
