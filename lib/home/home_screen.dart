import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testflutterapp/component/loading_indicator.dart';
import 'package:testflutterapp/home/home_cubit.dart';
import 'package:testflutterapp/home/home_state.dart';
import 'package:testflutterapp/home/now_playing_model.dart';
import 'package:testflutterapp/home/now_playing_screen.dart';
import 'package:testflutterapp/home/popular_model.dart';
import 'package:testflutterapp/home/popular_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber[700],
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..getNowPlaying(),
        child: HomeScreenPage(),
      ),
    );
  }
}

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage> {
  NowPlayingModel? data;
  PopularModel? dataPopular;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context)..getPopular();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is NowPlayingSuccess) {
          // Navigator.pop(context);
          setState(() {
            data = state.data;
          });
        }
        if (state is NowPlayingFailed) {
          // Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is PopularSuccess) {
          // Navigator.pop(context);
          setState(() {
            dataPopular = state.data;
          });
        }
        if (state is PopularFailed) {
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
        if (state is HomeLoading) {
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
                              text: "Now Playing",
                            ),
                            Tab(
                              text: "Popular",
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          NowPlayingPage(
                            data: data!,
                          ),
                          PopularPage(data: dataPopular!),
                          // Text("wew")
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
