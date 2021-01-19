import 'package:restofl/data/api/api_service.dart';
import 'package:restofl/data/model/restaurant_detail.dart';
import 'package:restofl/data/model/restaurant_list.dart' as restaurant_list;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RestoDetailPage extends StatefulWidget {
  static const routeName = '/resto_detail';

  final restaurant_list.Restaurant restaurant;

  const RestoDetailPage({@required this.restaurant});

  @override
  _RestoDetailPageState createState() => _RestoDetailPageState();
}

class _RestoDetailPageState extends State<RestoDetailPage> {
  Future<RestaurantDetail> _restaurantDetail;

  @override
  void initState() {
    _restaurantDetail = ApiService().getRestaurantDetail(widget.restaurant.id);
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _restaurantDetail,
      builder: (context, AsyncSnapshot<RestaurantDetail> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            var restaurant = snapshot.data.restaurant;
            return _buildItem(restaurant, context);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Text('');
          }
        }
      },
    );
  }

  Widget _buildItem(Restaurant restaurant, BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                restaurant.pictureId == null
                    ? Container(
                        height: 200,
                        child: Icon(Icons.error),
                      )
                    : Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          ApiService.baseUrlImage + restaurant.pictureId,
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Divider(color: Colors.grey),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.teal[400],
                      ),
                      Text(
                        ' ${restaurant.city}',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber[400],
                      ),
                      Text(
                        ' ${restaurant.rating}',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.grey),
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_dining,
                          color: Colors.green[300],
                        ),
                        Text(
                          ' Foods',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 150,
                    child: ListView(
                      padding: EdgeInsets.only(top: 0),
                      children: restaurant.menus.foods.map((x) {
                        return new Card(
                          elevation: 7.0,
                          child: new Container(
                            child: new Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '• ${x.name.toString()}',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_drink,
                          color: Colors.blue[300],
                        ),
                        Text(
                          ' Drinks',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 150,
                    child: ListView(
                      padding: EdgeInsets.only(top: 0),
                      children: restaurant.menus.drinks.map((x) {
                        return new Card(
                          elevation: 7.0,
                          child: new Container(
                            child: new Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '• ${x.name.toString()}',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
