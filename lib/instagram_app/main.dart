import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

void main(List<String> args) {
  runApp(Instagram());
}

var faker = Faker();

class Instagram extends StatefulWidget {
  const Instagram({ Key? key }) : super(key: key);

  @override
  _InstagramState createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {

  List imageList = [
    'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272',
    'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272',
    'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272',
    'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272'
  ];

  List<Post> listPost = List.generate(faker.randomGenerator.integer(10, min: 5), (index) {
    return Post(
      name: faker.person.name(),
      image: faker.image.image(),
      profile: faker.image.image(width: 50, height: 50)
    );
  });

  @override
  Widget build(BuildContext context) {
    listPost.forEach((element) {
      print(element.name);
      print(element.image);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text('Popular', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                          ),),
                          Spacer(),
                          Icon(Icons.search)
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 90,
                      margin: EdgeInsets.symmetric(
                        horizontal: 16
                      ),
                      child: ListView.builder(
                        itemCount: imageList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                imageList[index],
                                width: 70,
                                fit: BoxFit.cover
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listPost.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 350,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      listPost[index].profile,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(listPost[index].name, style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),),
                                  Spacer(),
                                  MaterialButton(
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    minWidth: 40,
                                    height: 30,
                                    color: Colors.black54,
                                    child: Text('follow', style: TextStyle(
                                      color: Colors.white
                                    )),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      listPost[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Icon(Icons.favorite_border, size: 20),
                                  SizedBox(width: 30,),
                                  Icon(Icons.rounded_corner, size: 20),
                                  SizedBox(width: 30,),
                                  Icon(Icons.share, size: 20),
                                  SizedBox(width: 30,),
                                ],
                              )
                            ],
                          ),
                        ),
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

class Post {
  String name;
  String profile;
  String image;

  Post({required this.name, required this.profile, required this.image});
}