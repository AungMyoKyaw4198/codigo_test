import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_002/ob/movie_ob.dart';
import 'package:test_002/ob/response_ob.dart';
import 'package:test_002/provider/fav_movie_provider.dart';
import 'package:test_002/screens/detail_screen/detail_screen.dart';
import 'package:test_002/utils/app_constant.dart';

import 'main_screen_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenBloc _mainScreenBloc = MainScreenBloc();
  final RefreshController _upcomingRefreshController = RefreshController();
  final RefreshController _popularRefreshController = RefreshController();

  late List<Movie>? upcomingMovies;
  late List<Movie>? popularMovies;

  @override
  void initState() {
    _mainScreenBloc.getUpcomingMovies();
    _mainScreenBloc
        .getUpcomingMovieControllerStream()
        .listen((ResponseOb resp) {
      if (resp.msgState == MsgState.data) {
        if (resp.pageState == PageState.first) {
          _upcomingRefreshController.refreshCompleted();
          _upcomingRefreshController.resetNoData();
        }

        if (resp.pageState == PageState.load) {
          _upcomingRefreshController.loadComplete();
        }

        if (resp.pageState == PageState.end) {
          _upcomingRefreshController.loadNoData();
        }
      }
    });

    _mainScreenBloc.getPopularMovies();
    _mainScreenBloc.getPopularMovieControllerStream().listen((ResponseOb resp) {
      if (resp.msgState == MsgState.data) {
        if (resp.pageState == PageState.first) {
          _popularRefreshController.refreshCompleted();
          _popularRefreshController.resetNoData();
        }

        if (resp.pageState == PageState.load) {
          _popularRefreshController.loadComplete();
        }

        if (resp.pageState == PageState.end) {
          _popularRefreshController.loadNoData();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _mainScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            // Title
            const Text(
              'What are you looking for ?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 20,
            ),

            // Popular Movies
            const Text(
              'Upcoming Movies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<ResponseOb>(
                stream: _mainScreenBloc.getUpcomingMovieControllerStream(),
                initialData: ResponseOb(msgState: MsgState.loading),
                builder:
                    (BuildContext context, AsyncSnapshot<ResponseOb> snapshot) {
                  ResponseOb responseOb = snapshot.data!;
                  if (responseOb.msgState == MsgState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  } else if (responseOb.msgState == MsgState.data) {
                    if (responseOb.pageState == PageState.first) {
                      MovieList movieList = responseOb.data;
                      upcomingMovies = movieList.movies;
                    }

                    if (responseOb.pageState == PageState.load) {
                      MovieList movieList = responseOb.data;
                      upcomingMovies!.addAll(movieList.movies!);
                    }

                    return Consumer<FavMovieProvider>(
                        builder: (context, favMovies, child) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: SmartRefresher(
                          controller: _upcomingRefreshController,
                          enablePullDown: true,
                          enablePullUp: true,
                          onRefresh: () {
                            _mainScreenBloc.getUpcomingMovies();
                          },
                          onLoading: () {
                            _mainScreenBloc.loadUpcomingMovies();
                          },
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: upcomingMovies!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DetailScreen(
                                          movie: upcomingMovies![index]);
                                    }));
                                  },
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 150,
                                              width: 100,
                                              child: Image.network(IMAGE_URL +
                                                  upcomingMovies![index]
                                                      .posterPath!),
                                            ),
                                            Positioned(
                                              left: 50,
                                              child: favMovies.favMovies
                                                      .contains(upcomingMovies![
                                                          index])
                                                  ? IconButton(
                                                      icon: const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        Provider.of<FavMovieProvider>(
                                                                context,
                                                                listen: false)
                                                            .removeFavMovie(
                                                                upcomingMovies![
                                                                    index]);
                                                      },
                                                    )
                                                  : IconButton(
                                                      icon: const Icon(Icons
                                                          .favorite_outline),
                                                      onPressed: () {
                                                        Provider.of<FavMovieProvider>(
                                                                context,
                                                                listen: false)
                                                            .addFavMovie(
                                                                upcomingMovies![
                                                                    index]);
                                                      },
                                                    ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          upcomingMovies![index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              // fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    });
                  } else {
                    String errorMessage = responseOb.data;
                    return Center(
                      child: Text(errorMessage),
                    );
                  }
                }),

            const SizedBox(
              height: 20,
            ),

            // Upcoming Movies
            const Text(
              'Popular Movies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<ResponseOb>(
                stream: _mainScreenBloc.getPopularMovieControllerStream(),
                initialData: ResponseOb(msgState: MsgState.loading),
                builder:
                    (BuildContext context, AsyncSnapshot<ResponseOb> snapshot) {
                  ResponseOb responseOb = snapshot.data!;
                  if (responseOb.msgState == MsgState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  } else if (responseOb.msgState == MsgState.data) {
                    if (responseOb.pageState == PageState.first) {
                      MovieList movieList = responseOb.data;
                      popularMovies = movieList.movies;
                    }

                    if (responseOb.pageState == PageState.load) {
                      MovieList movieList = responseOb.data;
                      popularMovies!.addAll(movieList.movies!);
                    }

                    return Consumer<FavMovieProvider>(
                        builder: (context, favMovies, child) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: SmartRefresher(
                          controller: _popularRefreshController,
                          enablePullDown: true,
                          enablePullUp: true,
                          onRefresh: () {
                            _mainScreenBloc.getPopularMovies();
                          },
                          onLoading: () {
                            _mainScreenBloc.loadPopularMovies();
                          },
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: popularMovies!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DetailScreen(
                                          movie: popularMovies![index]);
                                    }));
                                  },
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 150,
                                              width: 100,
                                              child: Image.network(IMAGE_URL +
                                                  popularMovies![index]
                                                      .posterPath!),
                                            ),
                                            Positioned(
                                              left: 50,
                                              child: favMovies.favMovies
                                                      .contains(
                                                          popularMovies![index])
                                                  ? IconButton(
                                                      icon: const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        Provider.of<FavMovieProvider>(
                                                                context,
                                                                listen: false)
                                                            .removeFavMovie(
                                                                popularMovies![
                                                                    index]);
                                                      },
                                                    )
                                                  : IconButton(
                                                      icon: const Icon(Icons
                                                          .favorite_outline),
                                                      onPressed: () {
                                                        Provider.of<FavMovieProvider>(
                                                                context,
                                                                listen: false)
                                                            .addFavMovie(
                                                                popularMovies![
                                                                    index]);
                                                      },
                                                    ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          popularMovies![index].title ?? 'null',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              // fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    });
                  } else {
                    String errorMessage = responseOb.data;
                    return Center(
                      child: Text(errorMessage),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
