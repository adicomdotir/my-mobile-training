import 'package:first_flutter/flutter_app_testing/models/favorites.dart';
import 'package:first_flutter/flutter_app_testing/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Sample'),
        actions: [
          TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, FavoritesPage.routeName);
              },
              icon: Icon(Icons.favorite_border),
              label: Text('Favorites'))
        ],
      ),
      body: ListView.builder(
          itemCount: 100,
          cacheExtent: 20,
          padding: EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (ctx, index) => ItemTile(index)),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(this.itemNo);

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favorites>(context);
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoritesList.items.contains(itemNo)
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          onPressed: () {
            !favoritesList.items.contains(itemNo)
                ? favoritesList.add(itemNo)
                : favoritesList.remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text(favoritesList.items.contains(itemNo)
                    ? 'Added to favorites.'
                    : 'Removed from favorites.')));
          },
        ),
      ),
    );
  }
}
