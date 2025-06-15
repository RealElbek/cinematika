import '../../domain/entities/tv_entity.dart';

class TvModel {
  final String name;
  final int id;
  final List<int> genreIds;
  final String? posterPath;
  final double? voteAverage;
  final String? firstAirDate;

  TvModel({
    required this.name,
    required this.genreIds,
    required this.id,
    this.posterPath,
    this.voteAverage,
    this.firstAirDate,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) {
    return TvModel(
      name: json['name'] as String? ?? 'Unknown Name',
      id: json['id'] as int,
      genreIds: (json['genre_ids'] as List?)?.cast<int>() ?? [],
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      firstAirDate: json['first_air_date'] as String?,
    );
  }

  TvEntity toEntity() => TvEntity(
    name: name,
    id: id,
    genreIds: genreIds,
    posterPath: posterPath,
    voteAverage: voteAverage,
    firstAirDate: firstAirDate,
  );
}