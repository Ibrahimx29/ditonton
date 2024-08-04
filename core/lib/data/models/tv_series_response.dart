import 'package:core/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TvModel> tvSeriesList;

  TvSeriesResponse({required this.tvSeriesList});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        tvSeriesList: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvSeriesList];
}
