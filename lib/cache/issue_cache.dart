import 'package:sejutacita_flutter_github/models/models.dart';

class IssueCache {
  final _cache = <String, Issues>{};

  Issues get(String term) => _cache[term];

  void set(String term, Issues result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
