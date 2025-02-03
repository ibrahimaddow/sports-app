import 'package:get/get.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';

class SportsController extends GetxController {
  final NewsService _newsService = NewsService();
  final RxList<Article> basketballNews = <Article>[].obs;
  final RxList<Article> footballNews = <Article>[].obs;
  final RxBool isLoadingBasketball = true.obs;
  final RxBool isLoadingFootball = true.obs;

  @override
  void onInit() {
    fetchBasketballNews();
    fetchFootballNews();
    super.onInit();
  }

  Future<void> fetchBasketballNews() async {
    try {
      isLoadingBasketball.value = true;
      final news = await _newsService.getNewsByCategory('basketball');
      basketballNews.value = news;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingBasketball.value = false;
    }
  }

  Future<void> fetchFootballNews() async {
    try {
      isLoadingFootball.value = true;
      final news = await _newsService.getNewsByCategory('football');
      footballNews.value = news;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingFootball.value = false;
    }
  }
}
