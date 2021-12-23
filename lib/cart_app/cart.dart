import 'package:flutter/material.dart';
import 'cart_model.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartModel> listModel = [
    CartModel(
        name: 'Apple Juice',
        count: 0,
        price: "8.65",
        image:
            'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272'),
    CartModel(
        name: 'Pinapple Juice',
        count: 1,
        price: "9.40",
        image:
            'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272'),
    CartModel(
        name: 'Grapse Juice',
        count: 3,
        price: "10.50",
        image:
            'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=300,272'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF3B4450),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_left,
                      color: Colors.white,
                    ),
                    Spacer(),
                    Expanded(
                        child: Text(
                      'MY CART',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                    Spacer()
                  ],
                ),
              )),
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF1E2843),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                      itemCount: listModel.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  listModel[index].image,
                                  height: 150,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      listModel[index].name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Lorem ipsum dolor sit amet',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      '\$ ${listModel[index].price}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (listModel[index].count > 0) {
                                                listModel[index].count--;
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF1E2843),
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1
                                              )
                                            ),
                                            child: Icon(Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(listModel[index].count.toString(), 
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),),
                                        SizedBox(width: 10,),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              listModel[index].count++;
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF1E2843),
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1
                                              )
                                            ),
                                            child: Icon(Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }
}