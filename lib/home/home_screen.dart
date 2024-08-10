import 'package:flutter/material.dart';
import 'package:testflutterapp/home/now_playing_screen.dart';

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
      body: Container(
        width: double.infinity,
        //builder tab atas
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                width: double
                    .infinity, // Make sure the width takes full available space
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.amber[700],
                  indicatorColor: Colors.amber[700],
                  unselectedLabelColor: Colors.black12,
                  tabs: [
                    // judul tab
                    Tab(text: "Now Playing"),
                    Tab(text: "Popular"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    NowPlayingPage(), // tabulasi page now_playing
                    PopularPage(), // tabulasi page popular
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
