import 'package:provider/provider.dart';
import 'package:restofl/provider/search_provider.dart';
import 'package:restofl/widgets/platform_widget.dart';
import 'package:restofl/widgets/card_resto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search-page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const String searchTitle = 'Search';

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
                            "Welcome to RestoFL\nSearch Local Restaurant Here",
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
      context.read<SearchProvider>().fetchSearchRestaurant(text);
    }
    setState(() {});
  }

  Widget _buildList(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (state.state == ResultState.HasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardResto(restaurant: restaurant);
              },
            );
          } else if (state.state == ResultState.NoData) {
            return Container(
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
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_cellular_off,
                    color: Colors.teal[400],
                    size: 32,
                  ),
                  Text(
                    "No Internet Connection\nPlease Turn On Internet",
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return Text('');
          }
        }
      },
    );
  }
}
