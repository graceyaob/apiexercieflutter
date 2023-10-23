import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = Dio();
Future apipost() async {
  var token;
  try {
    Response response = await dio.post(
        "https://dpi-backend-develop.winlogic.pro/users/v1/login/",
        data: {'username': 'admin', 'password': 'Winlogic_2023'});
    if (response.statusCode == 200) {
      print("Connexion reussi Token");

      //Recupération du token
      token = response.data['token']['access'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return token;
    } else {
      print("erreur: ${response.statusCode}");
    }
  } on DioException catch (e) {
    print("erreur : $e");
    return token = null; // En cas d'erreur, retourne null
  }
}

/*Future apiget() async {
  try {
    
    String token = await apipost();
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final CancelToken cancelToken = CancelToken();
      await dio
          .get("https://dpi-backend-develop.winlogic.pro/accueils/v1/modules/",
              cancelToken: cancelToken)
          .then((response) {
        if (response.statusCode == 200) {
          List data = response.data;
          List first20 = data.take(20).toList();
          return first20;
        } else {
          print("erreur statut = ${response.statusCode}");
        }
      }).catchError((error) {
        if (CancelToken.isCancel(error)) {
          // La requête a été annulée
          print('Requête annulée');
        } else {
          // Gérer d'autres erreurs
        }
      });
    }
  } catch (e) {
    print('erreur: $e');
  }
  return []; //Retourne une liste vide en cas d'erreur
}*/

Future apiget() async {
  print('This is message from dio');
  var token = await apipost();
  print('this is token $token');
  dio.options.headers['Authorization'] = 'Bearer $token';
  if (token != null) {
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
  } else {
    print("désole");
  }
}
