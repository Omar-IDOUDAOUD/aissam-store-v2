
extension Map2Extension<E> on List<E> {
  List<T> map2<T>(T Function(E element) transform) {
    // Create a new list with the same length as the original list.
    final List<T> result = [];

    int i = 0;
    final l = length;
    while (i < l) {
      result[i] = transform(this[i]);
      i++;
    }

    return result.toList();
  }
}
