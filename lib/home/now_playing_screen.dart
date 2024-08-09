import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testflutterapp/api_url.dart';
import 'package:testflutterapp/component/showModal.dart';
import 'package:testflutterapp/detail/detail_screen.dart';
import 'package:testflutterapp/home/home_cubit.dart';
import 'package:testflutterapp/home/home_state.dart';
import 'package:testflutterapp/home/now_playing_model.dart';

class NowPlayingPage extends StatelessWidget {
  final NowPlayingModel data;
  const NowPlayingPage({required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: NowPlayingScreen(data: data),
      ),
    );
  }
}

class NowPlayingScreen extends StatefulWidget {
  final NowPlayingModel data;
  const NowPlayingScreen({required this.data});
  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  List<Result> dataRes = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      dataRes = widget.data.results;
    });
  }

  addWatchList(id) {
    Map<String, dynamic> body = {
      "media_type": "movie",
      "media_id": id.toString(),
      "watchlist": "true"
    };
    BlocProvider.of<HomeCubit>(context).postWatchlist(body);
    ShowModal().showLoading(context);
  }

  addFavorite(id) {
    Map<String, dynamic> body = {
      "media_type": "movie",
      "media_id": id.toString(),
      "favorite": "true"
    };
    BlocProvider.of<HomeCubit>(context).postFavorite(body);
    ShowModal().showLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is AddWatchListSuccess) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.msg),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
      if (state is AddWatchListFailed) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.msg),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
      if (state is AddFavoriteSuccess) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.msg),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
      if (state is AddFavoriteFailed) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.msg),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }, builder: (context, state) {
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
          itemCount: dataRes.take(6).length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled:
                      true, // Allows the bottom sheet to be scrollable
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),

                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dataRes[index].title,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          SizedBox(height: 16),
                          Text(
                            dataRes[index].overview,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    addWatchList(dataRes[index]
                                        .id); // Close the bottom sheet
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.format_list_bulleted_add,
                                        color: Colors.amber[700],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Add to Watchlist",
                                        style: TextStyle(
                                          color: Colors.amber[700],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    addFavorite(dataRes[index]
                                        .id); // Close the bottom sheet
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_task_rounded,
                                        color: Colors.amber[700],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Add to Favorite",
                                        style: TextStyle(
                                          color: Colors.amber[700],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                id: dataRes[index].id),
                                          ));
                                    },
                                    child: Text(
                                      "See Detail",
                                      style: TextStyle(
                                        color: Colors.amber[700],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: NetworkImage(
                            ApiUrl.baseImg + dataRes[index].posterPath),
                        fit: BoxFit.cover)),
                // child: Center(
                //   child: Text('Item $index'),
                // ),
              ),
            );
          },
        ),
      );
    });
  }
}
