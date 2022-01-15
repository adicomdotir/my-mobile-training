import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter/flutter_app_testing/models/favorites.dart';

class FavoritesPage extends StatelessWidget {
  static String routeName = '/favorites_page';

  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer<Favorites>(
        builder: (ctx, value, child) => ListView.builder(
            itemCount: value.items.length,
            padding: EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (ctx, index) => FavoriteItemTile(value.items[index])),
      ),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final int itemNo;
  const FavoriteItemTile(this.itemNo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('favorites_text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('remove_icon_$itemNo'),
          icon: Icon(Icons.close),
          onPressed: () {
            Provider.of<Favorites>(context, listen: false).remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Removed from favorites.'),
                duration: Duration(seconds: 1),
              )
            );
          },
        ),
      )
    );
  }
}