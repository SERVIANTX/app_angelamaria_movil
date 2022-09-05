// ignore_for_file: non_constant_identifier_names, camel_case_types

class data_Orders_Delivered{

  late int id_order;


  data_Orders_Delivered(this.id_order);

  data_Orders_Delivered.fromJson(Map<String, dynamic> json){
    id_order = int.parse(json['id_order']);
  }

}