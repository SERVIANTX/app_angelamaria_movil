// ignore_for_file: non_constant_identifier_names, camel_case_types


class data_Confirmed_Order{

  late int id_order;
  data_Confirmed_Order(this.id_order);

  data_Confirmed_Order.fromJson(Map<String, dynamic> json){
    id_order = int.parse(json['id_order']);
  }

}