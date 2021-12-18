import 'package:first_flutter/shoes_shop_app/product.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Store());
}

class Store extends StatefulWidget {
  const Store({ Key? key }) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  List<Product> listProduct = [
    Product(
      name: "Nike Air Flex",
      price: "220",
      image: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/c32ed0a0-7df4-431e-a23a-5187775cd6d8/air-vapormax-2021-fk-mens-shoes-NpTfFz.png"
    ),
    Product(
      name: "Nike Epic Fantom",
      price: "200",
      image: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/c32ed0a0-7df4-431e-a23a-5187775cd6d8/air-vapormax-2021-fk-mens-shoes-NpTfFz.png"
    ),
    Product(
      name: "Nike Air Zoom",
      price: "122.8",
      image: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/c32ed0a0-7df4-431e-a23a-5187775cd6d8/air-vapormax-2021-fk-mens-shoes-NpTfFz.png"
    )
  ];
  List listName = [
    "ALL PRODUCTS",
    "SHOES",
    "SANDALS",
  ];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Nike',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.filter_alt_outlined, size: 30,),
                    SizedBox(width: 16,),
                    Icon(Icons.search, size: 30,),
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listName.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            i = index;
                          });
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(listName[index], style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: i == index ? Colors.black : Colors.grey
                              ),),
                            ),
                            SizedBox(height: 10,),
                            i == index ? Container(
                              height: 2, width: 50, color: Colors.blue,
                            ) : Container()
                          ],
                        ),
                      );
                    }
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2
                    ),
                    itemCount: listProduct.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFF1F1F1)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  listProduct[index].image,
                                  height: 75,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Text(listProduct[index].name),
                                Text("\$${listProduct[index].price}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}