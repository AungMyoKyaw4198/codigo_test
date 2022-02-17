import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_002/ob/movie_ob.dart';
import 'package:test_002/ob/response_ob.dart';
import 'package:test_002/utils/app_constant.dart';

class MainScreenBloc {
  final PublishSubject<ResponseOb> _upcomingMoviesController =
      PublishSubject<ResponseOb>();
  final PublishSubject<ResponseOb> _popularMoviesController =
      PublishSubject<ResponseOb>();

  Stream<ResponseOb> getUpcomingMovieControllerStream() =>
      _upcomingMoviesController.stream;
  Stream<ResponseOb> getPopularMovieControllerStream() =>
      _popularMoviesController.stream;

  dispose() {
    _upcomingMoviesController.close();
    _popularMoviesController.close();
  }

  int upcomingPage = 1;
  int popularPage = 1;

  getUpcomingMovies() async {
    upcomingPage = 1;

    ResponseOb _resp = ResponseOb(msgState: MsgState.loading);
    _upcomingMoviesController.sink.add(_resp);
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          '$UPCOMING_URL?api_key=$apiKey&language=en-US&page=$upcomingPage');
      if (response.statusCode == 200) {
        _resp.msgState = MsgState.data;
        MovieList _movieList = MovieList.fromJson(response.data);
        _resp.data = _movieList;
        _resp.pageState = PageState.first;
        _upcomingMoviesController.sink.add(_resp);
      } else if (response.statusCode == 401) {
        _resp.msgState = MsgState.error;
        _resp.data = response.statusMessage;
        _upcomingMoviesController.sink.add(_resp);
      } else if (response.statusCode == 404) {
        _resp.msgState = MsgState.error;
        _resp.data = response.statusMessage;
        _upcomingMoviesController.sink.add(_resp);
      }
    } catch (e) {
      _resp.msgState = MsgState.error;
      _resp.data = 'Unknown Error Occur!';
      _upcomingMoviesController.sink.add(_resp);
    }
  }

  loadUpcomingMovies() async {
    upcomingPage++;

    ResponseOb _resp = ResponseOb(msgState: MsgState.loading);
    // _upcomingMoviesController.sink.add(_resp);
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          '$UPCOMING_URL?api_key=$apiKey&language=en-US&page=$upcomingPage');
      if (response.statusCode == 200) {
        _resp.msgState = MsgState.data;
        MovieList _movieList = MovieList.fromJson(response.data);
        _resp.data = _movieList;
        _resp.pageState = PageState.load;
        _upcomingMoviesController.sink.add(_resp);
      } else if (response.statusCode == 401) {
        _resp.msgState = MsgState.error;
        _resp.data = response.statusMessage;
        _upcomingMoviesController.sink.add(_resp);
      } else if (response.statusCode == 404) {
        _resp.msgState = MsgState.error;
        _resp.data = response.statusMessage;
        _upcomingMoviesController.sink.add(_resp);
      }
    } catch (e) {
      _resp.msgState = MsgState.error;
      _resp.data = 'Unknown Error Occur!';
      _upcomingMoviesController.sink.add(_resp);
    }
  }

  getPopularMovies() async {
    popularPage = 1;
    ResponseOb _resp = ResponseOb(msgState: MsgState.loading);
    _popularMoviesController.sink.add(_resp);
    final Dio _dio = Dio();
    try {
      var response = await _dio
          .get('$POPULAR_URL?api_key=$apiKey&language=en-US&page=$popularPage');
      if (response.statusCode == 200) {
        _resp.msgState = MsgState.data;
        MovieList _movieList = MovieList.fromJson(response.data);
        _resp.data = _movieList;
        _resp.pageState = PageState.first;
        _popularMoviesController.sink.add(_resp);
      } else if (response.statusCode == 401) {
        _resp.msgState = MsgState.error;
        _resp.data = response.statusMessage;
        _popularMoviesController.sink.add(_resp);
      } else if (response.statusCode == 404) {
        _resp.msgState = MsgState.error;
        _resp.data = response.statusMessage;
        _popularMoviesController.sink.add(_resp);
      }
    } catch (e) {
      _resp.msgState = MsgState.error;
      _resp.data = 'Unknown Error Occur!';
      _popularMoviesController.sink.add(_resp);
    }
  }

  loadPopularMovies() async {
    popularPage++;
    ResponseOb _resp = ResponseOb(msgState: MsgState.loading);
    final Dio _dio = Dio();
    try {
      var response = await _dio
          .get('$POPULAR_URL?api_key=$apiKey&language=en-US&page=$popularPage');
      if (response.statusCode == 200) {
        _resp.msgState = MsgState.data;
        MovieList _movieList = MovieList.fromJson(response.data);
        _resp.data = _movieList;
        _resp.pageState = PageState.load;
        _popularMoviesController.sink.add(_resp);
      } else if (response.statusCode == 401) {
        _resp.msgState = MsgState.error;
        _resp.data = response.statusMessage;
        _popularMoviesController.sink.add(_resp);
      } else if (response.statusCode == 404) {
        _resp.msgState = MsgState.error;
        _resp.data = response.statusMessage;
        _popularMoviesController.sink.add(_resp);
      }
    } catch (e) {
      _resp.msgState = MsgState.error;
      _resp.data = 'Unknown Error Occur!';
      _popularMoviesController.sink.add(_resp);
    }
  }
}
