import '../cache/cache.dart';
import '../clients/clients.dart';
import '../models/models.dart';

class UserRepository {
  const UserRepository({required this.cache, required this.client});

  final UserCache cache;
  final GithubClient client;

  Future<Users> userSearch(String term, [int page = 1]) async {
    final result = await client.userSearch(term, page);
    cache.set(term, result);
    return result;
  }
}
