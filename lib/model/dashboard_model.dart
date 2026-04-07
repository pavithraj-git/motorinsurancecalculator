class DashboardModel {
  int? id;
  String? image;
  String? title;

  DashboardModel({
    this.id,
    this.title,
    this.image
  });

  DashboardModel.fromJson(Map<String, dynamic> map){
    id = map['id'];
    title = map["title"];
    image = map["image"];
  }
}