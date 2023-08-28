import 'package:flutter/material.dart';
import 'package:mvvm_pattren/repository/auth_repository.dart';
import 'package:mvvm_pattren/utils/Utils.dart';
import 'package:mvvm_pattren/utils/routes/routes.dart';
import 'package:mvvm_pattren/utils/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _authRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      print(value.toString());
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error.toString());
    });
  }
}
