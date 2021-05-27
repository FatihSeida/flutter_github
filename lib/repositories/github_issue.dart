import 'package:meta/meta.dart';

import 'package:sejutacita_flutter_github/cache/cache.dart';
import 'package:sejutacita_flutter_github/clients/clients.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

class GithubIssue {
  const GithubIssue({@required this.cache, @required this.client});

  final IssueCache cache;
  final GithubClient client;

  Future<Issues> issueSearch(String term, int page) async {
    final cachedResult = cache.get(term);
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await client.issueSearch(term, page);
    cache.set(term, result);
    return result;
  }
}
