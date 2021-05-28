import 'package:meta/meta.dart';

import 'package:sejutacita_flutter_github/cache/cache.dart';
import 'package:sejutacita_flutter_github/clients/clients.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

class IssueRepository {
  const IssueRepository({@required this.cache, @required this.client});

  final IssueCache cache;
  final GithubClient client;

  Future<Issues> issueSearch(String term, [int page = 1]) async {
    final result = await client.issueSearch(term, page);
    cache.set(term, result);
    return result;
  }
}
