class DproductsModel {
  late bool status;
  late Data data;

  DproductsModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}
class Data {
  int? currentPage;
  late List<Products> data;
  String? firstPageUrl;
  int ?from;
  int ?lastPage;
  String? lastPageUrl;
  String? path;
  int ?perPage;
  int ?to;
  int ?total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data =  [];
    json['data'].forEach((element){data.add(Products.fromJson(element));});
    // List.generate(data!.length, (index) => SearchData.fromJson(json['data']));
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}


class Products {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int ?discount;
  String? image;
  String ?name;
  String ?description;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}