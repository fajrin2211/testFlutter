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
      //define bloc provider
      body: BlocProvider(
        create: (context) =>
            UserProfileCubit()..getWatchlist(), // get the watchlist api
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
        //listener state set action when the state event on process
        if (state is WatchListSuccess) {
          setState(() {
            dataWatchlist = state.data;
          });
        }
        if (state is WatchListFailed) {
          //show snackbar when its fail
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state is FavoriteSuccess) {
          setState(() {
            dataFavorite = state.data;
          });
        }
        if (state is FavoriteFailed) {
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
          //show loading indicator when the state is loading
          return LoadingIndicator();
        } else {
          return Container(
            width: double.infinity,
            child: DefaultTabController(
              length: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
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
                        //tab item page
                        WatchlistScreen(data: dataWatchlist!),
                        WatchlistScreen(data: dataFavorite),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
