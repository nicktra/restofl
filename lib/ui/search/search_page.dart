import 'package:restofl/widgets/platform_widget.dart';
import 'package:restofl/widgets/card_resto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restofl/data/api/api_service.dart';
import 'package:restofl/data/model/restaurant_search.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search-page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const String searchTitle = 'Search';
  Future<RestaurantSearch> _restaurantSearch;
  bool isEmpty = true;

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(searchTitle),
      ),
      body: _buildSearch(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(searchTitle),
      ),
      child: _buildSearch(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildSearch(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black.withOpacity(0.32)),
              ),
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue.shade400,
                    ),
                    hintText: "Search by name, category, or menu"),
                onChanged: onSearchTextChanged,
              ),
            ),
            isEmpty
                ? Container(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Image.asset(
                              "assets/images/animate-search-color.gif",
                              fit: BoxFit.cover,
                              height: 100, // set your height
                              width: 100,
                            ),
                          ),
                          Text(
                            "Welcome to RestoFL\nSearch Favorite restaurant Here",
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(child: _buildList(context)),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    if (text.isEmpty || text == "") {
      isEmpty = true;
      setState(() {});
      return;
    } else {
      isEmpty = false;
      _restaurantSearch = ApiService().getRestaurantSearch(text);
    }
    setState(() {});
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _restaurantSearch,
      builder: (context, AsyncSnapshot<RestaurantSearch> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return snapshot.data.restaurants.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = snapshot.data.restaurants[index];
                      return CardResto(restaurant: restaurant);
                    },
                  )
                : Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Image.asset(
                              "assets/images/data-not-found.png",
                              fit: BoxFit.cover,
                              height: 100, // set your height
                              width: 100,
                            ),
                          ),
                          Text(
                            "Not Found",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Text('');
          }
        }
      },
    );
  }
}
