import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numberOfNotifications')
  int? numberOfNotifications;

  CustomerResponse({this.id, this.name, this.numberOfNotifications});

  // De json (from json)
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  // Para Json (to json)
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'link')
  String? link;

  ContactResponse({this.email, this.phone, this.link});

  // De json (from json)
  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);

  // Para Json (to json)
  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponses {
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contacts')
  ContactResponse? contacts;

  AuthenticationResponse({this.customer, this.contacts});

  // Buscar json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // Enviar Json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
