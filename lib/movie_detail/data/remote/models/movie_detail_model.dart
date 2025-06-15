import '../../../domain/entities/movie_detail_entity.dart';

class MovieDetailModel {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final List<GenreModel> genres;
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
  final List<ProductionCompanyModel> productionCompanies;
  final String homepage;
  final int budget;
  final int revenue;
  final String status;
  final String imdbId;
  final CollectionModel? belongsToCollection;

  MovieDetailModel({
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

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      genres: (json['genres'] as List).map((e) => GenreModel.fromJson(e)).toList(),
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      tagline: json['tagline'] ?? '',
      adult: json['adult'],
      originalLanguage: json['original_language'],
      spokenLanguages: (json['spoken_languages'] as List)
          .map((e) => e['english_name'] as String)
          .toList(),
      productionCountries: (json['production_countries'] as List)
          .map((e) => e['name'] as String)
          .toList(),
      productionCompanies: (json['production_companies'] as List)
          .map((e) => ProductionCompanyModel.fromJson(e))
          .toList(),
      homepage: json['homepage'] ?? '',
      budget: json['budget'],
      revenue: json['revenue'],
      status: json['status'],
      imdbId: json['imdb_id'],
      belongsToCollection: json['belongs_to_collection'] != null
          ? CollectionModel.fromJson(json['belongs_to_collection'])
          : null,
    );
  }

  MovieDetailEntity toEntity() {
    return MovieDetailEntity(
      id: id,
      title: title,
      originalTitle: originalTitle,
      overview: overview,
      genres: genres.map((e) => e.toEntity()).toList(),
      releaseDate: releaseDate,
      runtime: runtime,
      voteAverage: voteAverage,
      voteCount: voteCount,
      posterPath: posterPath,
      backdropPath: backdropPath,
      tagline: tagline,
      adult: adult,
      originalLanguage: originalLanguage,
      spokenLanguages: spokenLanguages,
      productionCountries: productionCountries,
      productionCompanies: productionCompanies.map((e) => e.toEntity()).toList(),
      homepage: homepage,
      budget: budget,
      revenue: revenue,
      status: status,
      imdbId: imdbId,
      belongsToCollection: belongsToCollection?.toEntity(),
    );
  }
}

class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }

  GenreEntity toEntity() {
    return GenreEntity(id: id, name: name);
  }
}

class ProductionCompanyModel {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  ProductionCompanyModel({
    required this.id,
    required this.name,
    this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'],
      name: json['name'],
      logoPath: json['logo_path'],
      originCountry: json['origin_country'],
    );
  }

  ProductionCompanyEntity toEntity() {
    return ProductionCompanyEntity(
      id: id,
      name: name,
      logoPath: logoPath,
      originCountry: originCountry,
    );
  }
}

class CollectionModel {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  CollectionModel({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
    );
  }

  CollectionEntity toEntity() {
    return CollectionEntity(
      id: id,
      name: name,
      posterPath: posterPath,
      backdropPath: backdropPath,
    );
  }
}
