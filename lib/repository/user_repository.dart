import 'package:asset_mobile/model/user_response.dart';
import 'package:asset_mobile/repository/user_api_provider.dart';

class UserRepository{
  UserApiProvider _apiProvider = UserApiProvider();

  Future<UserResponse> getUser(){
    return _apiProvider.getUser();
  }
}