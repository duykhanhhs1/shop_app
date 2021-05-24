import 'package:flutter/material.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider apiClient;

  UserRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<UserModel> getUserLogged(String userNo) async {
    return apiClient.getUserLogged(userNo);
  }

  Future<UserModel> login(String username, String password) async {
    return apiClient.login(username, password);
  }

  Future<ProfileModel> getProfile() async {
    return apiClient.getProfile();
  }

  Future<void> register({String email, String password, UserModel user}) async {
    return apiClient.register(email: email, password: password, user: user);
  }

  ///ADMIN
  Future<List<UserModel>> getUsers() async {
    return apiClient.getUsers();
  }

  Future<void> removeUser(String userNo) async {
    return apiClient.removeUser(userNo);
  }

  Future<void> updateUser(UserModel user) {
    return apiClient.updateUser(user);
  }
}
