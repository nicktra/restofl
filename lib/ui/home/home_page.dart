import 'package:flutter/material.dart';
import 'package:restofl/data/model/resto.dart';
import 'package:restofl/ui/detail/resto_detail_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RestoFL'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_resto.json'),
        builder: (context, snapshot) {
          final List<Resto> restos = parseResto(snapshot.data);
          print(restos);
          return ListView.builder(
            itemCount: restos.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              /* return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Image.network(
                  restos[index].restaurants[index].pictureId,
                  width: 100,
                ),
                title: Text(restos[index].restaurants[index].name),
                subtitle:
                    Text(restos[index].restaurants[index].rating.toString()),
              ); */
              return _buildRestoItem(context, restos[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildRestoItem(BuildContext context, Resto resto) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, RestoDetailPage.routeName, arguments: resto);
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
            color: Colors.white,
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
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color(0xff47455f),
                      fontWeight: FontWeight.w700,
                    ),
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
                  /* child: Text(
                    resto.city,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                  ), */
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(resto.city,
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber[400],
                            size: 16,
                          ),
                          Text(resto.rating.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black))
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
  );
  /* return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Image.network(
      resto.pictureId,
      width: 100,
    ),
    title: Text(resto.name),
    subtitle: Text(resto.rating.toString()),
    onTap: () {
      Navigator.pushNamed(context, RestoDetailPage.routeName, arguments: resto);
    },
  ); */
}
