import 'package:restofl/data/model/resto.dart';
import 'package:flutter/material.dart';

class RestoDetailPage extends StatelessWidget {
  static const routeName = '/resto_detail';

  final Resto resto;

  const RestoDetailPage({@required this.resto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text(resto.name),
      ), */
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Hero(
                  tag: resto.name,
                  child: Image.network(
                    "${resto.pictureId}",
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
            /* Image.network(resto.pictureId), */
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resto.name,
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
                        ' ${resto.city}',
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
                        ' ${resto.rating}',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    resto.description,
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
                      children: resto.menus.foods.map((name) {
                        return new Card(
                          elevation: 7.0,
                          child: new Container(
                            child: new Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '• ${name.toString()}',
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
                      children: resto.menus.drinks.map((name) {
                        return new Card(
                          elevation: 7.0,
                          child: new Container(
                            child: new Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '• ${name.toString()}',
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
