import 'package:first_flutter/shoes_shop_app/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main(List<String> args) {
  runApp(Shop());
}

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  List<Product> listProduct = [
    Product(
      name: "T - SHIRT",
      price: "126",
      image: "https://deltapayam.com/wp-content/uploads/2021/12/Untitled-1-192-800x491.jpg"
    ),
    Product(
      name: "SHIRT",
      price: "100",
      image: "https://deltapayam.com/wp-content/uploads/2021/12/Untitled-1-192-800x491.jpg"
    ),
    Product(
      name: "FLEECE",
      price: "134",
      image: "https://deltapayam.com/wp-content/uploads/2021/12/Untitled-1-192-800x491.jpg"
    ),
    Product(
      name: "SWEATER",
      price: "96",
      image: "https://deltapayam.com/wp-content/uploads/2021/12/Untitled-1-192-800x491.jpg"
    )
  ];
  List category = [
    'Men',
    'Women',
    'Kids',
    'Bags',
  ];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Classify',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  children: List.generate(category.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            i = index;
                          });
                        },
                        child: Text(category[index], style: TextStyle(
                          fontSize: 18,
                          color: index == i ? Colors.black : Colors.grey
                        ),),
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: listProduct.length,
                    itemBuilder: (BuildContext context, int index) => 
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)
                              ),
                              child: Image.network(
                                listProduct[index].image
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(listProduct[index].name, style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15
                                          ),),
                                          Text(listProduct[index].price + " items", style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12
                                          ),),
                                        ],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Colors.amber
                                        ),
                                        child: Icon(Icons.arrow_forward,
                                          color: Colors.white, size: 15,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ), staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
