import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:testflutterapp/api_url.dart';
import 'package:testflutterapp/component/loading_indicator.dart';
import 'package:testflutterapp/detail/detail_cubit.dart';
import 'package:testflutterapp/detail/detail_movie_model.dart';
import 'package:testflutterapp/detail/detail_state.dart';
import 'package:testflutterapp/detail/similiar_movie_model.dart';

class DetailScreen extends StatelessWidget {
  final int id;
  const DetailScreen({required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Detail Movie",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.amber[700],
        ),
        body: BlocProvider(
          create: (context) => DetailCubit()..getDetail(id),
          child: DetailPage(
            id: id,
          ),
        ));
  }
}

class DetailPage extends StatefulWidget {
  final int id;
  const DetailPage({required this.id});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailMovieModel? detailData;
  List<dynamic> similiarData = [];
  List<String> genres = [];
  String? backdrop;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: 100),
      () async {
        await BlocProvider.of<DetailCubit>(context)
          ..getSimiliar(widget.id);
      },
    );
  }

  double roundToDecimalPlaces(double value, int places) {
    num mod = pow(10.0, places.toDouble());
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailCubit, DetailState>(
      listener: (context, state) {
        if (state is DetailSuccess) {
          setState(() {
            detailData = state.data;
            backdrop = detailData!.backdropPath != null
                ? ApiUrl.baseImg + detailData!.backdropPath!
                : "https://placehold.co/600x400";
          });
          for (var i = 0; i < detailData!.genres.length; i++) {
            genres.add(detailData!.genres[i].name);
          }
        }
        if (state is DetailFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is SimiliarSuccess) {
          setState(() {
            for (var i = 0; i < state.data.length; i++) {
              similiarData.add({
                "id": state.data[i]["id"],
                "poster_path": state.data[i]["poster_path"] != null
                    ? state.data[i]["poster_path"]
                    : "https://placehold.co/600x400"
              });
            }
          });
        }

        if (state is SimiliarFailed) {
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
        if (state is DetailLoading) {
          return LoadingIndicator();
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(backdrop!), fit: BoxFit.cover)),
                  child: Image.network(
                    ApiUrl.baseImg + detailData!.posterPath,
                    height: 200,
                    width: 95,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  color: Color.fromARGB(255, 50, 18, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              detailData!.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "(" +
                                formatDate(detailData!.releaseDate, [yyyy]) +
                                ")",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.greenAccent,
                                backgroundColor: Colors.grey[200],
                                strokeWidth: 2.0,
                                value: detailData!.voteAverage * 0.1,
                              ),
                              Text(
                                (roundToDecimalPlaces(
                                            detailData!.voteAverage, 1))
                                        .toString() +
                                    "%",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              "User Score",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                formatDate(detailData!.releaseDate,
                                        [dd, "/", mm, "/", yyyy]) +
                                    "(" +
                                    detailData!.originCountry[0] +
                                    ")",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 100,
                                child: Text(
                                  genres.join(", "),
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        detailData!.tagline,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Overview",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          detailData!.overview,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Budget : USD. " +
                            MoneyFormatter(
                                    amount: double.parse(
                                        detailData!.budget.toString()))
                                .output
                                .withoutFractionDigits,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Similiar Movie",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      similiarData != null
                          ? Container(
                              width: double.infinity,
                              height: 200,
                              padding: EdgeInsets.all(10),
                              child: Expanded(
                                  child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: similiarData.take(6).length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                              id: similiarData[index]["id"]),
                                        )),
                                    child: Container(
                                      width: 90,
                                      height: 150,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  ApiUrl.baseImg +
                                                      similiarData[index]
                                                          ["poster_path"]),
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                },
                              )),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
