import 'package:core/bloc/watchlist_movies_bloc.dart';
import 'package:core/bloc/watchlist_tv_series_bloc.dart';
import 'package:core/core.dart';
import 'package:core/presentation/widgets/watchlist_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final movies = context.read<WatchlistMoviesBloc>();
      movies.add(FetchWatchlistMovies());
      final tvSeries = context.read<WatchlistTvSeriesBloc>();
      tvSeries.add(FetchWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    final movies = context.read<WatchlistMoviesBloc>();
    movies.add(FetchWatchlistMovies());
    final tvSeries = context.read<WatchlistTvSeriesBloc>();
    tvSeries.add(FetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, movieState) {
            return BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
              builder: (context, tvSeriesState) {
                if (movieState.state == RequestState.Loading ||
                    tvSeriesState.state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (movieState.state == RequestState.Error) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(movieState.message),
                  );
                } else if (tvSeriesState.state == RequestState.Error) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(tvSeriesState.message),
                  );
                } else {
                  final combinedList = [
                    ...movieState.movies,
                    ...tvSeriesState.tvSeries,
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
            );
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
