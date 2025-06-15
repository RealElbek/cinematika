import '../../../domain/entities/tv_detail_entity.dart';
import 'movie_detail_model.dart';

class TvDetailModel {
  final int id;
  final String name;
  final String overview;
  final List<GenreModel> genres;
  final String firstAirDate;
  final String lastAirDate;
  final bool inProduction;
  final String status;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final double voteAverage;
  final String posterPath;
  final String backdropPath;
  final List<ProductionCompanyModel> productionCompanies;

  TvDetailModel({
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

  factory TvDetailModel.fromJson(Map<String, dynamic> json) {
    return TvDetailModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      genres: (json['genres'] as List)
          .map((genre) => GenreModel.fromJson(genre))
          .toList(),
      firstAirDate: json['first_air_date'],
      lastAirDate: json['last_air_date'],
      inProduction: json['in_production'],
      status: json['status'],
      numberOfSeasons: json['number_of_seasons'],
      numberOfEpisodes: json['number_of_episodes'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      productionCompanies: (json['production_companies'] as List)
          .map((company) => ProductionCompanyModel.fromJson(company))
          .toList(),
    );
  }

  TvDetailEntity toEntity() {
    return TvDetailEntity(
      id: id,
      name: name,
      overview: overview,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      firstAirDate: firstAirDate,
      lastAirDate: lastAirDate,
      inProduction: inProduction,
      status: status,
      numberOfSeasons: numberOfSeasons,
      numberOfEpisodes: numberOfEpisodes,
      voteAverage: voteAverage,
      posterPath: posterPath,
      backdropPath: backdropPath,
      productionCompanies:
      productionCompanies.map((e) => e.toEntity()).toList(),
    );
  }
}
