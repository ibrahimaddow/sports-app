import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';

class NewsService {
  static const String apiKey = 'cd2de0bcc94949c2acd769e64f1a0450';
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> getTopHeadlines() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Article> articles = (data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Article>> getNewsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/everything?q=$category&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Article> articles = (data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
