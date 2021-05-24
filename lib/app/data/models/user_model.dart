import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String userNo;
  String email;
  String authentication_token;
  String refreshToken;
  ProfileModel profile;

  UserModel({
    this.userNo,
    this.email,
    this.authentication_token,
    this.refreshToken,
    this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class ProfileModel {
  String userNo;
  String first_name;
  String last_name;
  @JsonKey(
      defaultValue:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwQnaX0HIMtehoJnZsojyjD2P0u0YNl9IYyM3TJAaM4_QMgHqMpmYp_RfId466ou30Vs4&usqp=CAU")
  String photo_url;
  String description;
  String address;
  String gender;
  String phone_number;
  String email;
  String refreshToken;
  DateTime date_of_birth;

  String get fullName => first_name + last_name;

  ProfileModel(
      {this.userNo,
      this.gender,
      this.description,
      this.email,
      photo_url,
      this.address,
      this.refreshToken,
      this.phone_number})
      : photo_url = photo_url ??
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwQnaX0HIMtehoJnZsojyjD2P0u0YNl9IYyM3TJAaM4_QMgHqMpmYp_RfId466ou30Vs4&usqp=CAU";

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

@JsonSerializable()
class LoginResponse {
  UserModel user;

  LoginResponse({
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
