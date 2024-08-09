import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testflutterapp/component/loading_indicator.dart';
import 'package:testflutterapp/user_profile/user_profile_cubit.dart';
import 'package:testflutterapp/user_profile/user_profile_state.dart';
import 'package:testflutterapp/user_profile/watchlist_screen.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber[700],
      ),
      body: BlocProvider(
        create: (context) => UserProfileCubit()..getWatchlist(),
        child: UserProfileScreenPage(),
      ),
    );
  }
}

class UserProfileScreenPage extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreenPage> {
  dynamic dataWatchlist;
  dynamic dataFavorite;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileCubit>(context)..getFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is WatchListSuccess) {
          // Navigator.pop(context);
          setState(() {
            dataWatchlist = state.data;
          });
        }
        if (state is WatchListFailed) {
          // Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state is FavoriteSuccess) {
          // Navigator.pop(context);
          setState(() {
            dataFavorite = state.data;
          });
        }
        if (state is FavoriteFailed) {
          // Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is UserProfileLoading) {
          return LoadingIndicator();
        } else {
          return Container(
            // padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Expanded(
              child: DefaultTabController(
                length: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  // padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        child: TabBar(
                          isScrollable: true,
                          labelColor: Colors.amber[700],
                          indicatorColor: Colors.amber[700],
                          unselectedLabelColor: Colors.black12,
                          tabs: [
                            Tab(
                              text: "Watchlist",
                            ),
                            Tab(
                              text: "Favorite",
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          WatchlistScreen(data: dataWatchlist!),
                          WatchlistScreen(data: dataFavorite),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
