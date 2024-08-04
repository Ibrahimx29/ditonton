import 'package:core/core.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:core/presentation/widgets/watchlist_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
          .fetchWatchlistTvSeries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer2<WatchlistMovieNotifier, WatchlistTvSeriesNotifier>(
          builder: (context, movieNotifier, tvSeriesNotifier, child) {
            if (movieNotifier.watchlistState == RequestState.Loading ||
                tvSeriesNotifier.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (movieNotifier.watchlistState == RequestState.Error) {
              return Center(
                key: Key('error_message'),
                child: Text(movieNotifier.message),
              );
            } else if (tvSeriesNotifier.watchlistState == RequestState.Error) {
              return Center(
                key: Key('error_message'),
                child: Text(tvSeriesNotifier.message),
              );
            } else {
              final combinedList = [
                ...movieNotifier.watchlistMovies,
                ...tvSeriesNotifier.watchlistTvSeries,
              ];
              return ListView.builder(
                itemBuilder: (context, index) {
                  final item = combinedList[index];
                  return CombinedCard(item);
                },
                itemCount: combinedList.length,
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
