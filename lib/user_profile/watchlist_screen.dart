import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testflutterapp/api_url.dart';
import 'package:testflutterapp/component/showModal.dart';
import 'package:testflutterapp/detail/detail_screen.dart';
import 'package:testflutterapp/home/home_cubit.dart';
import 'package:testflutterapp/home/home_state.dart';
import 'package:testflutterapp/home/now_playing_model.dart';

class WatchlistScreen extends StatefulWidget {
  final dynamic data;
  const WatchlistScreen({required this.data});
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  List<dynamic> dataRes = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      dataRes.clear();
      for (var i = 0; i < widget.data["results"].length; i++) {
        dataRes.add(widget.data["results"][i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10.0, // Horizontal spacing
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.7
            // Aspect ratio of each item
            ),
        padding: EdgeInsets.all(10),
        itemCount: dataRes.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(id: dataRes[index]["id"]),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      image: NetworkImage(
                          ApiUrl.baseImg + dataRes[index]["poster_path"]),
                      fit: BoxFit.cover)),
              // child: Center(
              //   child: Text(dataRes[index]["poster_path"].toString()),
              // ),
            ),
          );
        },
      ),
    );
  }
}
