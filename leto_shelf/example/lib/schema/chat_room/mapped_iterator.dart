class Val<T> {
  final T inner;

  const Val(this.inner);
}

class MappedIterator<T, O> extends Iterator<O> {
  final Iterator<T> inner;
  final O Function(T) mapper;
  Val<O>? _current;

  MappedIterator(this.inner, this.mapper);

  @override
  O get current {
    if (_current != null) {
      return _current!.inner;
    }
    final innerValue = mapper(inner.current);
    _current = Val(innerValue);
    return innerValue;
  }

  @override
  bool moveNext() {
    _current = null;
    return inner.moveNext();
  }
}
