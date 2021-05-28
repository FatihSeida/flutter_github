import 'dart:async';
import 'package:meta/meta.dart';

import 'package:sejutacita_flutter_github/cache/cache.dart';
import 'package:sejutacita_flutter_github/clients/clients.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

class RepositoryOfRepository {
  const RepositoryOfRepository({@required this.cache, @required this.client});

  final RepositoryCache cache;
  final GithubClient client;

  Future<Repositories> repositorySearch(String term, [int page = 1]) async {
    final result = await client.repositorySearch(term, page);
    cache.set(term, result);
    return result;
  }
}
