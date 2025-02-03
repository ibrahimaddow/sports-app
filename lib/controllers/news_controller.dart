import 'package:get/get.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';

class NewsController extends GetxController {
  final NewsService _newsService = NewsService();
  final RxList<Article> generalArticles = <Article>[].obs;
  final RxList<Article> basketballArticles = <Article>[].obs;
  final RxList<Article> footballArticles = <Article>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchAllNews();
    super.onInit();
  }

  Future<void> fetchAllNews() async {
    try {
      isLoading.value = true;
      await Future.wait([
        fetchGeneralNews(),
        fetchBasketballNews(),
        fetchFootballNews(),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGeneralNews() async {
    try {
      final articles = await _newsService.getTopHeadlines();
      generalArticles.value = articles;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load general news');
    }
  }

  Future<void> fetchBasketballNews() async {
    try {
      final articles = await _newsService.getNewsByCategory('basketball');
      basketballArticles.value = articles;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load basketball news');
    }
  }

  Future<void> fetchFootballNews() async {
    try {
      final articles = await _newsService.getNewsByCategory('football');
      footballArticles.value = articles;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load football news');
    }
  }

  Future<void> refreshNews(String category) async {
    switch (category) {
      case 'general':
        await fetchGeneralNews();
        break;
      case 'basketball':
        await fetchBasketballNews();
        break;
      case 'football':
        await fetchFootballNews();
        break;
    }
  }
}
