import 'dart:async';

import '../cache/cache.dart';
import '../clients/clients.dart';
import '../models/models.dart';

class RepositoryOfRepository {
  const RepositoryOfRepository({required this.cache, required this.client});

  final RepositoryCache cache;
  final GithubClient client;

  Future<Repositories> repositorySearch(String term, [int page = 1]) async {
    final result = await client.repositorySearch(term, page);
    cache.set(term, result);
    return result;
  }
}
