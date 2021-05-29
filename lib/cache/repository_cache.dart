import '/models/models.dart';

class RepositoryCache {
  final _cache = <String, Repositories>{};

  Repositories get(String term) => _cache[term];

  void set(String term, Repositories result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);

  void removeAll() => _cache.clear();
}
