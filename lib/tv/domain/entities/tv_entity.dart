import 'package:equatable/equatable.dart';

class TvEntity extends Equatable {
  final int id;
  final String name;
  final List<int> genreIds;
  final String? posterPath;
  final double? voteAverage;
  final String? firstAirDate;

  const TvEntity({
    required this.name,
    required this.genreIds,
    required this.id,
    this.posterPath,
    this.voteAverage,
    this.firstAirDate,
  });

  @override
  List<Object?> get props => [id, name, genreIds, posterPath, voteAverage, firstAirDate];
}