import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = Dio();
Future apipost() async {
  String token;
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    Response response = await dio.post(
        "https://dpi-backend-develop.winlogic.pro/users/v1/login/",
        data: {'username': 'admin', 'password': 'Winlogic_2023'});
    if (response.statusCode == 200) {
      print("Connexion reussi Token");

      //Recupération du token
      token = response.data['token']['access'];
      await prefs.setString('token', token);

      //return token;
      return prefs;
    } else {
      print("erreur: ${response.statusCode}");
    }
  } on DioException catch (e) {
    print("erreur : $e");
    // En cas d'erreur, retourne null
  }
}

Future apiget() async {
  print('This is message from dio');

  //recupéré le token stocké en local
  SharedPreferences token = await apipost();
  final String? jeton = token.getString('token');
  print('this is token $token');
  dio.options.headers['Authorization'] = 'Bearer $jeton';
  //if (token != null) {
  try {
    Response response = await dio
        .get("https://dpi-backend-develop.winlogic.pro/accueils/v1/modules/");
    print('This is message from dio 2');

    if (response.statusCode == 200) {
      print("Requete GET envoyé avec succès");
      List data = response.data;
      List first20 = data.take(20).toList();
      return first20;
    } else {
      print("erreur statut = ${response.statusCode}");
    }
  } catch (e) {
    print('erreur: $e');
  }
  /*} else {
    print("désole");
  }*/
}
