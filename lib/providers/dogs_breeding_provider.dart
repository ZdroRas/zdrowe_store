import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import '../models/dogs_breeding.dart';


class DogsBreedingProvider extends ChangeNotifier {
  static const apiEndpoint = 'https://zdrowerasowe.ppk.org.pl/api/healthypurebred-breedings?id=1000&breed_id=';

  bool isLoading = true;
  String error = '';
  DogsBreeding dogsBreeding = DogsBreeding(items: []);
  DogsBreeding searchedBreeds = DogsBreeding(items: []);
  String searchedText = '';

  getDataFromApi(id) async {
    var accessToken = 'IerjnbPad@1bBzd%xPHk'
        '\$oC&uXfGfqda)CCi7Z5Kr2iE3W8zMg\$p@a)UciDIiJaxn&ti@#Tz1xu0)JfW8TE(3LV5bcy))&xjAQNnLnzvmD3OeXJNU&BT&RKfHa@u3lDLWvn8#rs'
        '\$utmnPkVU1cXUdGEQ(!hDFV9gXb5*zf@DBx9rBdg8ssKmTa&l1RNlNuKl!GZEPG)IHCC6e&1kY*wfOTdrpp#6JacqV(U7h1j()y*cNEI07@2)\$0ysy0';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      Response response = await http.get((Uri.parse(apiEndpoint + id)), headers: headers);
      print("log" + id);
      if (response.statusCode == 200) {
        dogsBreeding = dogsBreedingFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    updateData();
  }

  updateData() {
    searchedBreeds.items.clear();
    if (searchedText.isEmpty) {
      searchedBreeds.items.addAll(dogsBreeding.items);
    } else {
      searchedBreeds.items.addAll(dogsBreeding.items
          .where(
              (element) => element.name.toLowerCase().startsWith(searchedText))
          .toList());
    }
    notifyListeners();
  }

  // search(String breed) {
  //   searchedText = breed;
  //   updateData();
  // }
}