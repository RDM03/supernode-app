class Either<TValue, TError> {
  final TValue value;
  final TError error;
  bool get success => error == null;

  Either._({this.value, this.error});
  Either.value(TValue value) : this._(value: value);
  Either.error(TError error) : this._(error: error);
}

extension FutureExtension<T> on Future<T> {
  Future<Either<T, TError>> withError<TError extends Object>() {
    return this
        .then((t) => Either<T, TError>.value(t))
        .onError<TError>((error, stackTrace) => Either<T, TError>.error(error));
  }
}
