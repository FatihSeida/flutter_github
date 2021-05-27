import 'package:meta/meta.dart';

import 'package:sejutacita_flutter_github/cache/cache.dart';
import 'package:sejutacita_flutter_github/clients/clients.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

class GithubUser {
  const GithubUser({@required this.cache, @required this.client});

  final UserCache cache;
  final GithubClient client;

  Future<Users> userSearch(String term) async {
    final cachedResult = cache.get(term);
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await client.userSearch(term);
    cache.set(term, result);
    return result;
  }
}
