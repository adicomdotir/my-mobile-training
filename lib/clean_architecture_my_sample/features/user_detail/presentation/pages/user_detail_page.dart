import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/presentation/bloc/user_detail_bloc.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/presentation/bloc/user_detail_event.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/presentation/bloc/user_detail_state.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';
import 'package:first_flutter/clean_architecture_my_sample/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailPage extends StatelessWidget {
  final int id;
  const UserDetailPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<UserDetailBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserDetailBloc>()..add(GetUserDetailEvent(id)),
        child: Center(
          child: BlocBuilder<UserDetailBloc, UserDetailState>(
            builder: (context, state) {
              if (state is UserDetailLoadingState) {
                return CircularProgressIndicator();
              } else if (state is UserDetailLoadedState) {
                return UserDetailDisplay(state.user);
              } else
                return Container();
            },
          ),
        ));
  }
}

class UserDetailDisplay extends StatelessWidget {
  final User user;
  const UserDetailDisplay(this.user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [
              Text('Id'),
              Text('${user.id}'),
            ]),
            TableRow(children: [
              Text('Name'),
              Text('${user.name}'),
            ]),
            TableRow(children: [
              Text('UserName'),
              Text('${user.username}'),

            ]),
            TableRow(children: [
              Text('Email'),
              Text('${user.email}'),

            ]),
            TableRow(children: [
              Text('Phone'),
              Text('${user.phone}'),


            ]),
            TableRow(children: [
              Text('WebSite'),
              Text('${user.website}'),

            ]),
          ],
        ),
      );
  }
}
