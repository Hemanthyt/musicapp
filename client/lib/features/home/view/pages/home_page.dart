import 'package:client/core/logger/logger.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_pallate.dart';
import 'package:client/features/home/view/pages/library_page.dart';
import 'package:client/features/home/view/pages/profile-page.dart';
import 'package:client/features/home/view/pages/search-page.dart';
import 'package:client/features/home/view/pages/songs_page.dart';
import 'package:client/features/home/view/widgets/music_slab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;
  final pages = [
    const SongPage(),
    SearchPage(),
    const LibraryPage(),
  ];
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    LoggerHelper.debug(user.toString());
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(children: [
        pages[selectedIndex],
        const Positioned(
          bottom: 0,
          child: MusicSlab(),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 35, 255, 116),
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 0
                  ? 'assets/images/home_filled.png'
                  : 'assets/images/home_unfilled.png',
              color: selectedIndex == 0
                  ? const Color.fromARGB(255, 35, 255, 116)
                  : Pallete.inactiveBottomBarItemColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 1
                ? Icon(
                    IconlyBold.search,
                    color: selectedIndex == 1
                        ? const Color.fromARGB(255, 35, 255, 116)
                        : Pallete.inactiveBottomBarItemColor,
                  )
                : Icon(
                    IconlyLight.search,
                    color: selectedIndex == 1
                        ? const Color.fromARGB(255, 35, 255, 116)
                        : Pallete.inactiveBottomBarItemColor,
                  ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/library.png',
              color: selectedIndex == 2
                  ? const Color.fromARGB(255, 35, 255, 116)
                  : Pallete.inactiveBottomBarItemColor,
            ),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
