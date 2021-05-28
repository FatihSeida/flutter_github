import 'package:sejutacita_flutter_github/models/models.dart';

class UserCache {
  final _cache = <String, Users>{};

  Users get(String term) => _cache[term];

  void set(String term, Users result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);

  void removeAll() => _cache.clear();
}
