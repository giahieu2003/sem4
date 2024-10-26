import 'package:app_shop/models/sneaker_model.dart';
import 'package:app_shop/services/config.dart';
import 'package:http/http.dart' as http;

class Helper {
  static var client = http.Client();
  // Male
  Future<List<Sneakers>> getMaleSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if(response.statusCode == 200) {
      final maleList = sneakersFromJson(response.body);
      var male = maleList.where((element) => element.category == "Men's Running");
      return male.toList();
    } else {
      throw Exception("Failed get sneakers list");
    }
  }

// Female
  Future<List<Sneakers>> getFemaleSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if(response.statusCode == 200) {
      final femaleList = sneakersFromJson(response.body);
      var female = femaleList.where((element) => element.category == "Women's Running");
      return female.toList();
    } else {
      throw Exception("Failed get sneakers list");
    }
  }

// Kids
  Future<List<Sneakers>> getKidsSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if(response.statusCode == 200) {
      final kidsList = sneakersFromJson(response.body);
      var kid = kidsList.where((element) => element.category == "Kids' Running");
      return kid.toList();
    } else {
      throw Exception("Failed get sneakers list");
    }
  }

  Future<List<Sneakers>> search(String searchQuery) async {
    var url = Uri.http(Config.apiUrl, "${Config.search}$searchQuery");

    var response = await client.get(url);

    if(response.statusCode == 200) {
      final results = sneakersFromJson(response.body);
      
      return results;
    } else {
      throw Exception("Failed get sneakers list");
    }
  }
}
