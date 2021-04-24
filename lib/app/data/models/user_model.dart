import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String userNo;
  String fullName;
  String imageUrl;
  String description;
  String address;
  String gender;
  String phone;
  String email;
  String role;
  String token;
  String refreshToken;
  DateTime createdAt;

  @JsonKey(ignore: true)
  bool isChecked;

  UserModel(
      {this.userNo,
      this.createdAt,
      this.gender,
      this.imageUrl,
      this.isChecked = false,
      this.description,
      this.role,
      this.email,
      this.fullName,
      this.address,
      this.token,
      this.refreshToken,
      this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
