// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    userNo: json['userNo'] as String,
    role: json['role'] as String,
    fullName: json['fullName'] as String,
    address: json['address'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userNo': instance.userNo,
      'fullName': instance.fullName,
      'address': instance.address,
      'phone': instance.phone,
      'role': instance.role,
    };
