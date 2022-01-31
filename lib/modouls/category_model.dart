class CategoryModel{

  late bool status;
  late CategoryDataModel data;

  CategoryModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=CategoryDataModel.fromJson(json['data']);
  }

}
class CategoryDataModel{
  late int currentPage;
  late List<DataModel> dataModel=[];

  CategoryDataModel.fromJson(Map<String,dynamic>json){
    currentPage = json['current_page'];
    json['data'].forEach((element)
        {
          dataModel.add(DataModel.fromJson(element));
        });

  }
}
class DataModel{
   late int id;
   late String name;
   late String image;
  DataModel.fromJson(Map<String,dynamic>json){
      id=json['id'];
      name=json['name'];
      image=json['image'];

  }

}