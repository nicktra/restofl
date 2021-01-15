import 'package:restofl/data/model/resto.dart';
import 'package:restofl/ui/detail/resto_detail_page.dart';
import 'package:restofl/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RestoListPage extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future:
          DefaultAssetBundle.of(context).loadString('assets/local_resto.json'),
      builder: (context, snapshot) {
        final List<Resto> restos = parseResto(snapshot.data);
        return ListView.builder(
          itemCount: restos.length,
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return _buildRestoItem(context, restos[index]);
          },
        );
      },
    );
  }

  Widget _buildRestoItem(BuildContext context, Resto resto) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RestoDetailPage.routeName,
              arguments: resto);
        },
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: resto.name,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                        child: Image.network(
                          resto.pictureId,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18,
                        right: 18,
                      ),
                      child: Text(
                        resto.name,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18,
                        right: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.teal[400],
                                size: 16,
                              ),
                              Text(
                                resto.city,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber[400],
                                size: 16,
                              ),
                              Text(
                                resto.rating.toString(),
                                style: Theme.of(context).textTheme.subtitle1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RestoFL'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('RestoFL'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
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
