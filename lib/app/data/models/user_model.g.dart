// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    userNo: json['userNo'] as String,
    email: json['email'] as String,
    authentication_token: json['authentication_token'] as String,
    refreshToken: json['refreshToken'] as String,
    profile: json['profile'] == null
        ? null
        : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userNo': instance.userNo,
      'email': instance.email,
      'authentication_token': instance.authentication_token,
      'refreshToken': instance.refreshToken,
      'profile': instance.profile,
    };

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    userNo: json['userNo'] as String,
    gender: json['gender'] as String,
    description: json['description'] as String,
    email: json['email'] as String,
    photo_url: json['photo_url'] ??
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwQnaX0HIMtehoJnZsojyjD2P0u0YNl9IYyM3TJAaM4_QMgHqMpmYp_RfId466ou30Vs4&usqp=CAU',
    address: json['address'] as String,
    refreshToken: json['refreshToken'] as String,
    phone_number: json['phone_number'] as String,
  )
    ..first_name = json['first_name'] as String
    ..last_name = json['last_name'] as String
    ..date_of_birth = json['date_of_birth'] == null
        ? null
        : DateTime.parse(json['date_of_birth'] as String);
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'userNo': instance.userNo,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'photo_url': instance.photo_url,
      'description': instance.description,
      'address': instance.address,
      'gender': instance.gender,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'refreshToken': instance.refreshToken,
      'date_of_birth': instance.date_of_birth?.toIso8601String(),
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
