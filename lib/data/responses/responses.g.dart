// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponses _$BaseResponsesFromJson(Map<String, dynamic> json) =>
    BaseResponses()
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponsesToJson(BaseResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      numberOfNotifications: json['numberOfNotifications'] as int?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'numberOfNotifications': instance.numberOfNotifications,
    };

ContactResponse _$ContactResponseFromJson(Map<String, dynamic> json) =>
    ContactResponse(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$ContactResponseToJson(ContactResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'link': instance.link,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      customer: json['customer'] == null
          ? null
          : CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
      contacts: json['contacts'] == null
          ? null
          : ContactResponse.fromJson(json['contacts'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'customer': instance.customer,
      'contacts': instance.contacts,
    };
