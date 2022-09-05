// ignore_for_file: non_constant_identifier_names, camel_case_types

class Data_OrdersInTransit{

  late int id_order;
  late String date_order;
  late String address_order;
  late String phone_order;
  late String notes_order;
  late String displayname_customer;
  late int id_customer;

  Data_OrdersInTransit(this.id_order,this.id_customer,this.address_order,this.phone_order,this.date_order,this.notes_order,this.displayname_customer);

  Data_OrdersInTransit.fromJson(Map<String, dynamic> json){
    id_order = int.parse(json['id_order']);
    id_customer = int.parse(json['id_customer']);
    address_order = json['address_order'];
    phone_order = json['phone_order'];
    date_order = json['date_order'];
    notes_order = json['notes_order'];
    displayname_customer = json['displayname_customer'];
  }

}