import 'package:restofl/common/navigation.dart';
import 'package:restofl/data/model/restaurant_list.dart';
import 'package:restofl/data/api/api_service.dart';
import 'package:restofl/ui/detail/resto_detail_page.dart';
import 'package:flutter/material.dart';

class CardResto extends StatelessWidget {
  final Restaurant restaurant;

  const CardResto({Key key, @required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () =>
            Navigation.intentWithData(RestoDetailPage.routeName, restaurant),
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
                    restaurant.pictureId == null
                        ? Container(
                            width: 100,
                            child: Icon(Icons.error),
                          )
                        : Hero(
                            tag: restaurant.pictureId,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                              child: Image.network(
                                ApiService.baseUrlImage + restaurant.pictureId,
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
                        restaurant.name ?? "",
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
                                restaurant.city ?? "",
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
                                restaurant.rating.toString() ?? "0",
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
}
