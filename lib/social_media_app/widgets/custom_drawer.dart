import 'package:first_flutter/budget_app/screens/home_screen.dart';
import 'package:first_flutter/social_media_app/data/data.dart';
import 'package:first_flutter/social_media_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  _buildDrawerOption(Icon icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Stack(
          children: [
            Image(
              image: AssetImage(currentUser.backgroundImageUrl!),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Positioned(
                bottom: 20,
                left: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 3, color: Theme.of(context).primaryColor)),
                      child: ClipOval(
                        child: Image(
                          image: AssetImage(currentUser.profileImageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      currentUser.name!,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5),
                    )
                  ],
                ))
          ],
        ),
        _buildDrawerOption(
            Icon(Icons.dashboard),
            'Home',
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ))),
        _buildDrawerOption(Icon(Icons.chat), 'Chat', () {}),
        _buildDrawerOption(Icon(Icons.location_on), 'Map', () {}),
        _buildDrawerOption(Icon(Icons.account_circle), 'Your Profile', () {}),
        _buildDrawerOption(Icon(Icons.settings), 'Settings', () {}),
        Expanded(
            child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: _buildDrawerOption(
              Icon(Icons.directions_run),
              'Logout',
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(),
                  ))),
        ))
      ]),
    );
  }
}
