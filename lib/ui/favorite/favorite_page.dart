import 'package:provider/provider.dart';
import 'package:restofl/provider/database_provider.dart';
import 'package:restofl/utils/result_state.dart';
import 'package:restofl/widgets/card_resto.dart';
import 'package:restofl/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  static const String favoriteTitle = 'Favorite';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favoriteTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(favoriteTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CardResto(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
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
