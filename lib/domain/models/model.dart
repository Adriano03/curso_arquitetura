class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class Customer {
  String? id;
  String? name;
  int? numberOfNotifications;

  Customer({
    this.id,
    this.name,
    this.numberOfNotifications,
  });
}

class Contacts {
  String? email;
  String? phone;
  String? link;

  Contacts({
    this.email,
    this.phone,
    this.link,
  });
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication({
    this.customer,
    this.contacts,
  });
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo({
    required this.name,
    required this.identifier,
    required this.version,
  });
}
