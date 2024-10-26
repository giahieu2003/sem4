import 'package:app_shop/models/auth/login_model.dart';
import 'package:app_shop/models/auth/signup_model.dart';
import 'package:app_shop/services/authhelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _isObsecure = false;
  bool get isObsecure => _isObsecure;
  set isObsecure(bool newState) {
    _isObsecure = newState;
    notifyListeners();
  }


  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newState) {
    _processing = newState;
    notifyListeners();
  }


  bool _loginResponseBool = false;
  bool get loginResponseBool => _loginResponseBool;
  set loginResponseBool(bool newState) {
    _loginResponseBool = newState;
    notifyListeners();
  }


  bool _responseBool = false;
  bool get responseBool => _responseBool;
  set responseBool(bool newState) {
    _responseBool = newState;
    notifyListeners();
  }


  bool? _loggeIn;
  bool get loggeIn => _loggeIn ?? false;
  set loggeIn(bool newState) {
    _loggeIn = newState;
    notifyListeners();
  }


  Future<bool> userLogin(LoginModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    processing = true;
    bool response = await Authhelper().login(model);
    processing = false;

    loginResponseBool = response;

    loggeIn = prefs.getBool('isLogged') ?? false;
    

    return loginResponseBool;
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('token');
    prefs.remove('userId');
    prefs.setBool('isLogged', false);
    loggeIn = prefs.getBool('isLogged') ?? false;

  }

  Future<bool> registerUser(SignupModel model) async {
    responseBool = await Authhelper().signup(model);

    return responseBool;
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggeIn = prefs.getBool('isLogged') ?? false;
  }
}