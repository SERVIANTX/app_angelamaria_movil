// ignore_for_file: non_constant_identifier_names, camel_case_types

class data_Chart_Orders{

  late int id_order;
  late String date_created_order;


  data_Chart_Orders(this.id_order,this.date_created_order);

  data_Chart_Orders.fromJson(Map<String, dynamic> json){
    id_order = int.parse(json['id_order']);
    date_created_order = json['date_updated_order'];
  }

}