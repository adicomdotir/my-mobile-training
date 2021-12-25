import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Telegram());
}

class Telegram extends StatelessWidget {
  final List<Message> listMessage = [
    Message(
      name: 'محمد',
      image: 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272',
      message: 'سلام',
      time: '12 pm'
    ),
    Message(
      name: 'رضا',
      image: 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272',
      message: 'چه خبر',
      time: '11 pm'
    ),
    Message(
      name: 'جواد',
      image: 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272',
      message: 'کجایی؟',
      time: '9 pm'
    ),
    Message(
      name: 'حسین',
      image: 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272',
      message: 'چرا؟؟!!',
      time: '7 pm'
    ),
  ];

  Telegram({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                color: Color(0xFF54759e),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.menu, color: Colors.white),
                      SizedBox(width: 12,),
                      Text('Telegram',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search, color: Colors.white,)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listMessage.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              listMessage[index].image, width: 70, height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(listMessage[index].name,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(listMessage[index].message,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 2,),
                                Container(
                                  width: double.infinity,
                                  height: 0.5,
                                  color: Colors.grey
                                )
                              ],
                            ),
                          ),
                          Text(listMessage[index].time, 
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Message {
  String name;
  String message;
  String image;
  String time;

  Message({required this.name, required this.message, required this.image, required this.time});
}