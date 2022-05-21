class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String link;
  String email;

  Contacts(this.phone, this.link, this.email);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.contacts, this.customer);
}