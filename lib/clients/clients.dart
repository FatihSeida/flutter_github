import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class GithubClient {
  // GithubClient({
  //   this.httpClient,
  //   this.baseUrl = "https://api.github.com/search",
  // }) : this.httpClient = httpClient;

  final String baseUrl = "https://api.github.com/search";

  // http.Client httpClient;

  Future<Repositories> repositorySearch(String term, int page) async {
    final response = await http.get(Uri.parse("$baseUrl/repositories?q=$term&per_page=10&page=$page"));
    final results = json.decode(response.body.toString());
    print(results);
    if (response.statusCode == 200) {
      print(response.statusCode);
      return Repositories.fromMap(results);
    } else {
      throw SearchResultError.fromJson(results);
    }
  }

  Future<Issues> issueSearch(String term, int page) async {
    final url = Uri.parse("$baseUrl/issues?q=$term&per_page=10&page=$page");
    final response = await http.get(url);
    final results = json.decode(response.body.toString());
    print(results);
    if (response.statusCode == 200) {
      return Issues.fromMap(results);
    } else {
      throw SearchResultError.fromJson(results);
    }
  }

  Future<Users> userSearch(String term, int page) async {
    final response = await http
        .get(Uri.parse("$baseUrl/users?q=$term&per_page=10&page=$page"));
    final results = json.decode(response.body.toString());
    print(results);
    if (response.statusCode == 200) {
      print(response.statusCode);
      return Users.fromMap(results);
    } else {
      throw SearchResultError.fromJson(results);
    }
  }
}
