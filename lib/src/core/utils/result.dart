import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Type aliases for Result types using Either from dartz
typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = ResultFuture<void>;
typedef Result<T> = Either<Failure, T>;
