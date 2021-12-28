import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Sheypoor());
}

class Sheypoor extends StatelessWidget {
  Sheypoor({Key? key}) : super(key: key);

  final List<Ads> listAds = [
    Ads(
        title: 'اپارتمان 100 متری',
        address: 'اردبیل خ انقلاب',
        count: 3,
        image: 'https://pix6.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768'),
    Ads(
        title: 'خانه ویلایی دو طبقه',
        address: 'اردبیل خ شهدا',
        count: 3,
        image: 'https://pix6.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768'),
    Ads(
        title: 'اپارتمان 3 خواب',
        address: 'اردبیل میدان ایثار',
        count: 3,
        image: 'https://pix6.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768'),
    Ads(
        title: 'اپارتمان نقلی 50 متر',
        address: 'اردبیل خ دانشگاه',
        count: 3,
        image: 'https://pix6.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: ListView.builder(
              itemCount: listAds.length,
              itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 200,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  listAds[index].title,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'قیمت توافقی',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      'لحظاتی پیش',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.right,
                                    ),
                                    Spacer(),
                                    Text(
                                      listAds[index].address,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Stack(children: [
                              Image.network(listAds[index].image, height: 180, fit: BoxFit.cover, width: 150,),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                  color: Colors.black.withOpacity(0.4)
                                ),
                                child: Padding(padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                                child: Row(children: [
                                  Text(listAds[index].count.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 10,),
                                  Icon(Icons.camera_alt, color: Colors.white,)
                                ],),),
                              ))
                            ],),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}

class Ads {
  String title;
  String image;
  String address;
  int count;

  Ads(
      {required this.title,
      required this.image,
      required this.address,
      required this.count});
}
