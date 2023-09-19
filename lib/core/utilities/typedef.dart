import 'package:dartz/dartz.dart';
import 'package:tdd_block_lms/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultFutureVoid = ResultFuture<void>;

typedef DataMap = Map<String, dynamic>;
