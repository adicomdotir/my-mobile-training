import 'package:first_flutter/clean_architecture_my_sample/features/users/presentation/widgets/loading_widget.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/presentation/bloc/bloc.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/presentation/widgets/message_display.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/presentation/widgets/users_display.dart';
import 'package:first_flutter/clean_architecture_my_sample/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<UsersBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UsersBloc>(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  if (state is UsersEmptyState) {
                    return MessageDisplay(message: 'No Data');
                  } else if (state is UsersLoadingState) {
                    return LoadingWidget();
                  } else if (state is UsersLoadedState) {
                    return UsersDisplay(users: state.users);
                  } else if (state is UsersErrorState) {
                    return MessageDisplay(message: state.message);
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  return GestureDetector(
                    child: Icon(Icons.rotate_right),
                    onTap: () {
                      // context.read<UsersBloc>().add(GetUsersEvent());
                      BlocProvider.of<UsersBloc>(context, listen: false)
                          .add(GetUsersEvent());
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
