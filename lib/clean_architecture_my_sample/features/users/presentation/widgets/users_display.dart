import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UsersDisplay extends StatelessWidget {
  final List<User> users;

  const UsersDisplay({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Container(
                height: 48,
                child: Center(
                    child: Text(
                  users[index].name,
                  style: TextStyle(fontSize: 24),
                )));
          },
        ));
  }
}
