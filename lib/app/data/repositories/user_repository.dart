import 'package:flutter/material.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider apiClient;

  UserRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<UserModel>getProfile(String userNo) async {
    return apiClient.getProfile(userNo);
  }
}