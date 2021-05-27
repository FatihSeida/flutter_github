import 'dart:async';
import 'package:meta/meta.dart';

import 'package:sejutacita_flutter_github/cache/cache.dart';
import 'package:sejutacita_flutter_github/clients/clients.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

class GithubRepository {
  const GithubRepository({@required this.cache, @required this.client});

  final RepositoryCache cache;
  final GithubClient client;

  Future<Repositories> repositorySearch(String term) async {
    final cachedResult = cache.get(term);
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await client.repositorySearch(term);
    cache.set(term, result);
    return result;
  }
}
