import 'movie_detail_entity.dart';

class TvDetailEntity {
  final int id;
  final String name;
  final String overview;
  final List<GenreEntity> genres;
  final String firstAirDate;
  final String lastAirDate;
  final bool inProduction;
  final String status;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final double voteAverage;
  final String posterPath;
  final String backdropPath;
  final List<ProductionCompanyEntity> productionCompanies;

  TvDetailEntity({
    required this.id,
    required this.name,
    required this.overview,
    required this.genres,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.inProduction,
    required this.status,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.voteAverage,
    required this.posterPath,
    required this.backdropPath,
    required this.productionCompanies,
  });
}
