// ignore_for_file: non_constant_identifier_names, camel_case_types

class data_Orders_In_Transit{

  late int id_order;

  data_Orders_In_Transit(this.id_order);

  data_Orders_In_Transit.fromJson(Map<String, dynamic> json){
    id_order = int.parse(json['id_order']);
  }

}