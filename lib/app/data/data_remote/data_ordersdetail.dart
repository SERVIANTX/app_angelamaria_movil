// ignore_for_file: non_constant_identifier_names, camel_case_types

class Data_OrdersDetail{
  late int quantity_orderdetail;
  late String name_product;
  late String image_product;
  late String url_category;
  late bool checked;

  Data_OrdersDetail(this.name_product,this.quantity_orderdetail,this.image_product,this.url_category,this.checked);

  Data_OrdersDetail.fromJson(Map<String, dynamic> json){
    checked = false;
    name_product = json['name_product'];
    quantity_orderdetail = int.parse(json['quantity_orderdetail']);
    image_product = json['picture_product'];
    url_category = json['url_category'];
  }

}