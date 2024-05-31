extension GetOrNullMap<K, V> on Map<K, V> {
  V? getOrNullMap(K key) {
    return this.containsKey(key) ? this[key] : null;
  }
}

extension ListUtil<E> on Iterable<E> {
  bool isNullOrEmpty() {
    return this == null || this.isEmpty;
  }
  bool isNotNullOrEmpty() {
    return this != null && this.isNotEmpty;
  }
}
