import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sports_controller.dart';
import 'news_view.dart';
import 'basketball_view.dart';
import 'football_view.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final RxInt currentIndex = 0.obs;

  final pages = [
    const NewsView(),
    const BasketballView(),
    const FootballView(),
  ];

  final titles = ['Headlines', 'Basketball', 'Football'];

  @override
  Widget build(BuildContext context) {
    Get.put(SportsController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(titles[currentIndex.value])),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Obx(() => pages[currentIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: currentIndex.value,
            onTap: (index) => currentIndex.value = index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'Headlines',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_basketball),
                label: 'Basketball',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_football),
                label: 'Football',
              ),
            ],
          )),
    );
  }
}
