class HomeReportModel {
  String title;
  String color;
  int price;

  HomeReportModel({required this.title, required this.color, required this.price});

  Map<String, dynamic> toMap() {
    return {'title': title, 'color': color, 'price': price};
  }
}