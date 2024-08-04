import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/tv_series_detail_page.dart';
import 'package:core/core.dart';

class CombinedCard extends StatelessWidget {
  final dynamic item;

  CombinedCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          if (item is Movie) {
            Navigator.pushNamed(
              context,
              MovieDetailPage.ROUTE_NAME,
              arguments: item.id,
            );
          } else if (item is Serial) {
            Navigator.pushNamed(
              context,
              TvSeriesDetailPage.ROUTE_NAME,
              arguments: item.id,
            );
          }
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item is Movie ? item.title ?? '-' : item.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      item.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${item.posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
