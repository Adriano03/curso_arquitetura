// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:curso_arquitetura/app/extensions.dart';
import 'package:curso_arquitetura/data/responses/responses.dart';
import 'package:curso_arquitetura/domain/models/model.dart';

const EMPTY = '';
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id: this?.id.orEmpty() ?? EMPTY,
      name: this?.name?.orEmpty() ?? EMPTY,
      numberOfNotifications: this?.numberOfNotifications?.orZero() ?? ZERO,
    );
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contacts toDomain() {
    return Contacts(
      email: this?.email.orEmpty() ?? EMPTY,
      phone: this?.phone?.orEmpty() ?? EMPTY,
      link: this?.link?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      customer: this?.customer?.toDomain(),
      contacts: this?.contacts?.toDomain(),
    );
  }
}
