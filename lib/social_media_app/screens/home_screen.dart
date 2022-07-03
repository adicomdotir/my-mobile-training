import 'package:first_flutter/social_media_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user_model.dart';
import 'following_users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'FRENZY',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 10),
        ),
        bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 3.0,
            labelColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
              fontSize: 18,
            ),
            tabs: [
              Tab(text: 'Trending'),
              Tab(text: 'Latest'),
            ]),
      ),
      body: ListView(
        children: [
          FollowingUsers()
        ],
      ),
    );
  }
}
