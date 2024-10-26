import 'package:app_shop/controllers/favorites_provider.dart';
import 'package:app_shop/controllers/login_provider.dart';
import 'package:app_shop/views/shared/appstyle.dart';
import 'package:app_shop/views/ui/mainscreen.dart';
import 'package:app_shop/views/ui/noneuser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final _favBox = Hive.box('fav_box');

  Future<void> deleteFav(int key) async {
    await _favBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);

    List<dynamic> fav = [];
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "name": item['name'],
        "category": item['category'],
        "imageUrl": item['imageUrl'],
        "price": item['price']
      };
    }).toList();

    fav = favData.reversed.toList();

    return authNotifier.loggeIn == false
        ? const Noneuser()
        : Scaffold(
            backgroundColor: const Color(0xFFE2E2E2),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 35, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/top_image.png"),
                            fit: BoxFit.fill)),
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Favorites",
                          style: appstyle(30, Colors.white, FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                        itemCount: fav.length,
                        padding: const EdgeInsets.only(top: 100),
                        itemBuilder: (BuildContext context, int index) {
                          final shoe = fav[index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade500,
                                          spreadRadius: 5,
                                          blurRadius: 0.3,
                                          offset: const Offset(0, 1))
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: CachedNetworkImage(
                                            imageUrl: shoe['imageUrl'],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                shoe['name'],
                                                style: appstyle(
                                                    15,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                shoe['category'],
                                                style: appstyle(14, Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${shoe['price']}',
                                                    style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: GestureDetector(
                                        onTap: () {
                                          deleteFav(shoe['key']);
                                          favoritesNotifier.ids.removeWhere(
                                              (element) =>
                                                  element == shoe['id']);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen()));
                                        },
                                        child: const Icon(
                                            Ionicons.ios_heart_dislike),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
  }
}
