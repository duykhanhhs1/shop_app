// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    userNo: json['userNo'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    gender: json['gender'] as String,
    description: json['description'] as String,
    role: json['role'] as String,
    email: json['email'] as String,
    fullName: json['fullName'] as String,
    address: json['address'] as String,
    token: json['token'] as String,
    refreshToken: json['refreshToken'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userNo': instance.userNo,
      'fullName': instance.fullName,
      'description': instance.description,
      'address': instance.address,
      'gender': instance.gender,
      'phone': instance.phone,
      'email': instance.email,
      'role': instance.role,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
