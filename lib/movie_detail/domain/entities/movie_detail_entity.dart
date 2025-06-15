class MovieDetailEntity {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final List<GenreEntity> genres;
  final String releaseDate;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final String posterPath;
  final String backdropPath;
  final String tagline;
  final bool adult;
  final String originalLanguage;
  final List<String> spokenLanguages;
  final List<String> productionCountries;
  final List<ProductionCompanyEntity> productionCompanies;
  final String homepage;
  final int budget;
  final int revenue;
  final String status;
  final String imdbId;
  final CollectionEntity? belongsToCollection;

  MovieDetailEntity({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.genres,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
    required this.backdropPath,
    required this.tagline,
    required this.adult,
    required this.originalLanguage,
    required this.spokenLanguages,
    required this.productionCountries,
    required this.productionCompanies,
    required this.homepage,
    required this.budget,
    required this.revenue,
    required this.status,
    required this.imdbId,
    this.belongsToCollection,
  });
}

class GenreEntity {
  final int id;
  final String name;

  GenreEntity({required this.id, required this.name});
}

class ProductionCompanyEntity {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  ProductionCompanyEntity({
    required this.id,
    required this.name,
    this.logoPath,
    required this.originCountry,
  });
}

class CollectionEntity {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  CollectionEntity({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
  });
}
