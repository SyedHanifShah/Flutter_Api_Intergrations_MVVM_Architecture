import 'package:mvvm_pattren/data/network/BaseApiServices.dart';
import 'package:mvvm_pattren/data/network/NetworkApiServices.dart';
import 'package:mvvm_pattren/res/app_endpoints.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppEndpoints.loginEndPoints, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
