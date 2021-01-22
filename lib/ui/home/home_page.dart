import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:restofl/ui/home/resto_list_page.dart';
import 'package:restofl/ui/favorite/favorite_page.dart';
import 'package:restofl/ui/search/search_page.dart';
import 'package:restofl/widgets/platform_widget.dart';
import 'package:restofl/provider/restaurant_provider.dart';
import 'package:restofl/provider/search_provider.dart';
import 'package:restofl/data/api/api_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _catalogueText = 'Catalogue';
  static const String _searchText = 'Search';

  List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: RestoListPage(),
    ),
    ChangeNotifierProvider<SearchProvider>(
      create: (_) => SearchProvider(apiService: ApiService()),
      child: SearchPage(),
    ),
    FavoritePage(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS
          ? CupertinoIcons.building_2_fill
          : Icons.food_bank_outlined),
      label: _catalogueText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
      label: _searchText,
    ),
    BottomNavigationBarItem(
      icon:
          Icon(Platform.isIOS ? CupertinoIcons.heart : Icons.favorite_outline),
      label: FavoritePage.favoriteTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
