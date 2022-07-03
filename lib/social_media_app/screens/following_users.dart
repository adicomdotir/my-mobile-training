import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/user_model.dart';

class FollowingUsers extends StatelessWidget {
  const FollowingUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
          child: Text(
            'Following',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ),
        Container(
          height: 80,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10),
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            itemBuilder: (context, index) {
              User user = users[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2)),
                  child: ClipOval(
                    child: Image(
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        image: AssetImage(user.profileImageUrl!)),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
