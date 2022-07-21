// ignore_for_file: non_constant_identifier_names, camel_case_types

class Data_OrdersDetail{
  late int quantity_orderdetail;
  late String name_product;
  late String price_orderdetail;
  late String subtotal_orderdetail;
  late String image_product;
  late bool checked;

  Data_OrdersDetail(this.name_product,this.price_orderdetail,this.subtotal_orderdetail,this.quantity_orderdetail,this.image_product,this.checked);

  Data_OrdersDetail.fromJson(Map<String, dynamic> json){
    checked = false;
    name_product = json['name_product'];
    price_orderdetail = json['price_orderdetail'];
    subtotal_orderdetail = json['subtotal_orderdetail'];
    quantity_orderdetail = json['quantity_orderdetail'];
    image_product = json['image_product'];
  }

}