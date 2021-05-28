import 'package:meta/meta.dart';

import 'package:sejutacita_flutter_github/cache/cache.dart';
import 'package:sejutacita_flutter_github/clients/clients.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

class UserRepository {
  const UserRepository({@required this.cache, @required this.client});

  final UserCache cache;
  final GithubClient client;

  Future<Users> userSearch(String term, [int page = 1]) async {
    final result = await client.userSearch(term, page);
    cache.set(term, result);
    return result;
  }
}
