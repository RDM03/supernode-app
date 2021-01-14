class Wrap<T> {
  final T value;
  final bool loading;
  final dynamic error;

  const Wrap(
    this.value, {
    this.loading = false,
    this.error,
  }) : assert(!loading || (loading && error == null),
            'Error cannot be set when loading == true');

  const Wrap.pending() : this(null, loading: true);

  Wrap<T> withError(dynamic error) => Wrap(
        value,
        loading: false,
        error: error,
      );

  Wrap<T> withValue(T value) => Wrap(
        value,
        loading: false,
        error: null,
      );

  Wrap<T> withLoading() => Wrap(
        value,
        loading: true,
        error: null,
      );

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Wrap<T> &&
        o.value == value &&
        o.loading == loading &&
        o.error == error;
  }

  @override
  int get hashCode => value.hashCode ^ loading.hashCode ^ error.hashCode;
}
