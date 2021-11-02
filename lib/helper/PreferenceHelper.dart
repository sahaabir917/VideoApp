import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static SharedPreferences pref;

  void setJwtToken(String token) async{
    pref = await SharedPreferences.getInstance();
    pref.setString("jwtToken", token);
    pref.commit();
  }

  void setIsLoggedIn(bool isLogin) async {
    pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", isLogin);
    pref.commit();
  }

}