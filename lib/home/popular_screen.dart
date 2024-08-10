import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testflutterapp/api_url.dart';
import 'package:testflutterapp/component/loading_indicator.dart';
import 'package:testflutterapp/component/showModal.dart';
import 'package:testflutterapp/detail/detail_screen.dart';
import 'package:testflutterapp/home/home_cubit.dart';
import 'package:testflutterapp/home/home_state.dart';
import 'package:testflutterapp/home/now_playing_model.dart';
import 'package:testflutterapp/home/popular_model.dart';

class PopularPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit()..getPopular(),
        child: PopularScreen(),
      ),
    );
  }
}

class PopularScreen extends StatefulWidget {
  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  List<DataPopular> dataRes = [];

  // function for add watchlist
  addWatchList(id) {
    Map<String, dynamic> body = {
      "media_type": "movie",
      "media_id": id.toString(),
      "watchlist": "true"
    };
    BlocProvider.of<HomeCubit>(context).postWatchlist(body);
    ShowModal().showLoading(context);
  }

  // function for add favorite
  addFavorite(id) {
    Map<String, dynamic> body = {
      "media_type": "movie",
      "media_id": id.toString(),
      "favorite": "true"
    };
    BlocProvider.of<HomeCubit>(context).postFavorite(body);
    ShowModal().showLoading(context);
  }

  // button widget in the modal bottom sheet
  Widget _buildButton(BuildContext context,
      {IconData? icon,
      required String label,
      required VoidCallback onPressed}) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(bottom: 10), // Added margin for spacing
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.amber[700]),
            SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(color: Colors.amber[700]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      // state event when api call has finished
      if (state is PopularSuccess) {
        setState(() {
          dataRes = state.data.results;
        });
      }

      if (state is PopularFailed) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.msg),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
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
      if (state is HomeLoading) {
        // show loading indicator when the page still load the data
        return LoadingIndicator();
      } else {
        return Container(
          width: double.infinity,
          // builder  of grid view
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10.0, // Horizontal spacing
              mainAxisSpacing: 10.0, // Vertical spacing
              childAspectRatio: 0.7, // Aspect ratio of each item
            ),
            padding: EdgeInsets.all(10),
            itemCount: dataRes.take(20).length,
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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
                                _buildButton(
                                  context,
                                  icon: Icons.format_list_bulleted_add,
                                  label: "Add to Watchlist",
                                  onPressed: () {
                                    Navigator.pop(context);
                                    addWatchList(dataRes[index]
                                        .id); // Close the bottom sheet and add watchlist
                                  },
                                ),
                                _buildButton(
                                  context,
                                  icon: Icons.add_task_rounded,
                                  label: "Add to Favorite",
                                  onPressed: () {
                                    Navigator.pop(context);
                                    addFavorite(dataRes[index]
                                        .id); // Close the bottom sheet and add favorite
                                  },
                                ),
                                _buildButton(
                                  context,
                                  label: "See Detail",
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(id: dataRes[index].id),
                                      ), // Close the bottom sheet and go to detail page
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Image.network(
                    ApiUrl.baseImg + dataRes[index].posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        // show image when loader is finished
                        return child;
                      } else {
                        // show loader indicator
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    // show error when loading image are failed
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Center(
                        child: Icon(Icons.error),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }
}
