import 'dart:convert';
import 'dart:developer';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_user/model/user.dart';

Future saveUser(User value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? data = json.encode(value.toJson());

  await prefs.setString('user', data);
}

Future decreaseConteurUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int? cnt = prefs.getInt('conteur');

  cnt = cnt! - 1;

  await prefs.setInt('conteur', cnt);

}

Future increaseConteurUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int? cnt = prefs.getInt('conteur');

  // if (cnt! <= 3) {
    cnt = cnt! + 1;
    await prefs.setInt('conteur', cnt);

  //   print(' conteur tec  increase $cnt ');
  // }
}

Future createConteurUser(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
log('createConteurUser $value');
  if (value > 3) {
    await prefs.setInt('conteur', 0);
  } else {
    await prefs.setInt('conteur', 3 - value);
  }
}

// Future createConteurUserTest() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   await prefs.setInt('conteur', 3);

//   print(prefs.getInt('conteur'));
// }

Future<int> getCounterUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int cnt = prefs.getInt('conteur')!;

  print(' get conteur tec  $cnt ');
  return cnt;
}

Future<User?> getUser(String key) async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getString(key) != null) {
    User user = User.fromJson(json.decode(prefs.getString(key)!));
    return user;
  }

  return null;
}

Future<void> dropSessionUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.remove('user');
  await preferences.clear();
}
