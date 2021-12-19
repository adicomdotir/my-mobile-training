import 'package:first_flutter/hotel_app/hotel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(HotelPage());
}

class HotelPage extends StatefulWidget {
  const HotelPage({ Key? key }) : super(key: key);

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  List<Hotel> listModel = [
    Hotel(
      name: "Grand Royal Hotel",
      address: "Barcelona, Spain",
      price: "\$ 180",
      image: "https://pix6.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768"
    ),
    Hotel(
      name: "Queen Hotel",
      address: "Barcelona, Spain",
      price: "\$ 299",
      image: "https://pix6.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768"
    ),
    Hotel(
      name: "King Villa Resort",
      address: "Barcelona, Spain",
      price: "\$ 450",
      image: "https://pix6.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text('Favorites', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Upcoming'),
                      Text('Finished'),
                      Text('Favorites'),
                    ],
                  ),
                ),
                Expanded(child: ListView.builder(
                  itemCount: listModel.length,
                  itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)
                              ),
                              child: Image.network(
                                listModel[index].image,
                                fit: BoxFit.cover,
                                height: 150,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Text(listModel[index].name, style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height: 5,),
                                  Text(listModel[index].address),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(listModel[index].price, style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                  SizedBox(height: 10,)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}