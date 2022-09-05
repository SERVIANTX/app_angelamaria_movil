// ignore_for_file: non_constant_identifier_names, camel_case_types

class data_Orders_Accepted{

  late int id_order;

  data_Orders_Accepted(this.id_order);

  data_Orders_Accepted.fromJson(Map<String, dynamic> json){
    id_order = int.parse(json['id_order']);
  }

}