import 'package:flutter/material.dart';

class FavoritesNotifier extends ChangeNotifier {
  // final _favBox = Hive.box('fav_box');
  List<dynamic> _ids = [];
  List<dynamic> _favorites = [];
  List<dynamic> _fav = [];

  List<dynamic> get ids => _ids;

  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }


   List<dynamic> get favorites => _favorites;

  set favorites(List<dynamic> newFav) {
    _favorites = newFav;
    notifyListeners();
  }

  List get fav => _fav;

  set fav(List newFav) {
    _fav = newFav;
    notifyListeners();
  }

   

  // getAllData(){
  //   final favData = _favBox.keys.map((key){
  //     final item = _favBox.get(key);
  //     return {
  //       "key" : key,
  //       "id" : item['id'],
  //       "name" : item['name'],
  //       "category" : item['category'],
  //       "imageUrl" : item['imageUrl'],
  //       "price" : item['price']
  //     };
  //   }).toList();
  //   _fav = favData.reversed.toList();
  // }

  

}