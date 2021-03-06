// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:stunning_tribble/domain/count/count_failure.dart';

abstract class CountRepositoryImp {
  /// Count model
  ///
  /// Increment one
  Future<Either<CountFailure, int>> increment(int count);
}

class CountRepository implements CountRepositoryImp {
  @override
  Future<Either<CountFailure, int>> increment(count) async {
    try {
      return right(++count);
    } catch (e) {
      return left(CountFailure(message: "$e"));
    }
  }
}
