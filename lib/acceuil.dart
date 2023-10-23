import 'package:flutter/material.dart';
import 'listVilleLocal.dart';
import 'homes.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

int currentPage = 0; //position des pages
final PageController pageController =
    PageController(); //le cotrolleur des pages

class _AcceuilState extends State<Acceuil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: const [
          Home(),
          ListVille(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            pageController.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_max_outlined), label: "liste en ligne"),
          BottomNavigationBarItem(
              icon: Icon(Icons.abc_outlined), label: "Liste en local")
        ],
      ),
    );
  }
}
