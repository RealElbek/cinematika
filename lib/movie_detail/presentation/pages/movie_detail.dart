import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../core/locator.dart';
import '../../../core/themes/colors.dart';
import '../../../login/presentation/widgets/custom_image_view.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/trailer_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../manager/movie_detail_bloc.dart';
import '../manager/movie_detail_event.dart';
import '../manager/movie_detail_state.dart';
import '../widgets/actor_item_widget.dart';
import '../widgets/comment_widget.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/info_section_widget.dart';
import '../widgets/rating_item_widget.dart';
import '../../../core/themes/text_style_helper.dart';
import '../../../core/themes/theme_helper.dart';
import '../../../core/utils/image_constant.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieDetailBloc>()..add(FetchMovieDetails(movieId)),
      child: Scaffold(
        backgroundColor: appTheme.colorFF1212,
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is MovieDetailLoaded) {
              final movie = state.movie;
              final trailers = state.trailers;
              final reviews = state.reviews;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCoverSection(context, movie, trailers),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMovieInfoSection(context, movie),
                          _buildRatingsSection(context, movie),
                          _buildDescriptionSection(context, movie),
                          _buildMovieTrailerSection(context, trailers),
                          _buildInfoSections(context, movie),
                          _buildCommentsSection(context, reviews),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(); // Default case
          },
        ),
      ),
    );
  }

  /// Cover image with play button and navigation icons
  Widget _buildCoverSection(BuildContext context, MovieDetailEntity? movie, List<TrailerEntity> trailers) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie?.backdropPath ?? ImageConstant.imgCover}',
          height: 332,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[850]!,
            highlightColor: Colors.grey[800]!,
            child: Container(color: Colors.black),
          ),
          errorWidget: (context, url, error) => CustomImageView(imagePath: ImageConstant.imgCover),
        ),
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  imagePath: ImageConstant.imgIconBack,
                  height: 24,
                  width: 24,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Row(
                  children: [
                    CustomIconButton(
                      imagePath: ImageConstant.imgIconShare,
                      height: 24,
                      width: 24,
                      margin: EdgeInsets.only(right: 16),
                      onTap: () {},
                    ),
                    CustomIconButton(
                      imagePath: ImageConstant.imgIconFavorite,
                      height: 24,
                      width: 24,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (trailers.isNotEmpty)
          Positioned(
            top: 166,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _showTrailerDialog(context, trailers.first.key);
              },
              child: Center(
                child: CustomImageView(
                  imagePath: ImageConstant.imgShape,
                  height: 48,
                  width: 48,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Movie poster and basic info
  Widget _buildMovieInfoSection(BuildContext context, MovieDetailEntity? movie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5), // Set your desired radius here
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie?.posterPath ?? ImageConstant.imgMask}',
            height: 207,
            width: 139,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[850]!,
              highlightColor: Colors.grey[800]!,
              child: Container(
                height: 207,
                width: 139,
                color: Colors.black,
              ),
            ),
            errorWidget: (context, url, error) =>
                CustomImageView(imagePath: ImageConstant.imgMask),
          ),
        ),

        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    movie?.releaseDate.split('-')[0] ?? '2023',
                    style: TextStyleHelper.instance.body15,
                  ),
                  SizedBox(width: 8),
                  CustomImageView(
                    imagePath: ImageConstant.imgFlag,
                    height: 16,
                    width: 22,
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: appTheme.colorFF2AB1,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      'MOVIE',
                      style: TextStyleHelper.instance.body12ExtraBold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: appTheme.colorFF498F,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      '4K',
                      style: TextStyleHelper.instance.body12ExtraBold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'PG-13',
                    style: TextStyleHelper.instance.body15.copyWith(
                      color: appTheme.color7FFFFF,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                movie?.genres.map((g) => g.name).join(', ') ?? 'Action, Adventure',
                style: TextStyleHelper.instance.body15.copyWith(
                  color: appTheme.color81FFFF,
                ),
              ),
              SizedBox(height: 16),
              Text(
                movie?.title ?? 'Sample Movie',
                style: TextStyleHelper.instance.title17SemiBold.copyWith(
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Ratings section with 4 rating items
  Widget _buildRatingsSection(BuildContext context, MovieDetailEntity? movie) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appTheme.colorFF1616,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RatingItemWidget(
            imagePath: ImageConstant.imgIconKinopoisk,
            title: 'Kinopoisk',
            value: movie?.voteAverage.toStringAsFixed(1) ?? '8.5',
          ),
          RatingItemWidget(
            imagePath: ImageConstant.imgIconKinopoisk28x28,
            title: 'iMDb',
            value: movie?.voteAverage.toStringAsFixed(1) ?? '7.9',
          ),
          RatingItemWidget(
            imagePath: ImageConstant.imgIconKinopoisk1,
            title: 'Rate',
            value: '4.2', // Placeholder, could be user rating if available
          ),
          RatingItemWidget(
            imagePath: ImageConstant.imgIconKinopoisk2,
            title: 'Views',
            value: '1.2M', // Placeholder
          ),
        ],
      ),
    );
  }

  /// Description section
  Widget _buildDescriptionSection(BuildContext context, MovieDetailEntity? movie) {
    return InfoSectionWidget(
      title: 'Description',
      content: Text(
        movie?.overview ?? 'This is a sample movie description.',
        style: TextStyleHelper.instance.body15Light.copyWith(height: 1.13),
      ),
    );
  }

  /// Movie trailer section
  Widget _buildMovieTrailerSection(BuildContext context, List<TrailerEntity> trailers) {
    return InfoSectionWidget(
      title: 'Movie trailer',
      content: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Change the radius as needed
            child: CachedNetworkImage(
              imageUrl: trailers.isNotEmpty
                  ? 'https://img.youtube.com/vi/${trailers.first.key}/hqdefault.jpg'
                  : ImageConstant.imgRectangle,
              height: 194,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[850]!,
                highlightColor: Colors.grey[800]!,
                child: Container(
                  height: 194,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
              errorWidget: (context, url, error) =>
                  CustomImageView(imagePath: ImageConstant.imgRectangle),
            ),
          ),

          if (trailers.isNotEmpty)
            GestureDetector(
              onTap: () {
                _showTrailerDialog(context, trailers.first.key);
              },
              child: CustomImageView(
                imagePath: ImageConstant.imgShape,
                height: 48,
                width: 48,
              ),
            ),
        ],
      ),
    );
  }

  /// Info sections (Genre, Quality, Duration, Director, Actors)
  Widget _buildInfoSections(BuildContext context, MovieDetailEntity? movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoSectionWidget(
          title: 'Genre',
          content: Text(
            movie?.genres.map((g) => g.name).join(', ') ?? 'Action, Adventure, Sci-Fi',
            style: TextStyleHelper.instance.body15Light,
          ),
        ),
        InfoSectionWidget(
          title: 'Quality',
          content: Text(
            'HD', // Placeholder, could be derived from API if available
            style: TextStyleHelper.instance.body15Light,
          ),
        ),
        InfoSectionWidget(
          title: 'Duration',
          content: Text(
            '${movie!.runtime ~/ 60}h ${movie!.runtime % 60}m' ?? '2h 30m',
            style: TextStyleHelper.instance.body15Light,
          ),
        ),
        InfoSectionWidget(
          title: 'Director',
          content: Row(
            children: [
              CustomImageView(
                imagePath: 'assets/images/img_oval.png',
                height: 23,
                width: 23,
                radius: BorderRadius.circular(11.5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Unknown', // Placeholder, could be derived if available
                  style: TextStyleHelper.instance.body15Light,
                ),
              ),
            ],
          ),
        ),
        InfoSectionWidget(
          title: 'Production companies',
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (movie?.productionCompanies != null && movie!.productionCompanies!.isNotEmpty)
                  ActorItemWidget(
                    imagePath: movie!.productionCompanies![0].logoPath != null
                        ? 'https://image.tmdb.org/t/p/w500${movie.productionCompanies![0].logoPath}'
                        : 'assets/images/img_oval.png',
                    name: movie!.productionCompanies![0].name ?? 'Company 1',

                  ),
                SizedBox(width: 16), // Reduced spacing for better flow
                if (movie?.productionCompanies != null && movie!.productionCompanies!.length > 1)
                  ActorItemWidget(
                    imagePath: movie!.productionCompanies![1].logoPath != null
                        ? 'https://image.tmdb.org/t/p/w500${movie.productionCompanies![1].logoPath}'
                        : 'assets/images/img_oval_4.png',
                    name: movie!.productionCompanies![1].name ?? 'Company 2',

                  ),
                if (movie?.productionCompanies != null && movie!.productionCompanies!.length > 2)
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: ActorItemWidget(
                      imagePath: movie!.productionCompanies![2].logoPath != null
                          ? 'https://image.tmdb.org/t/p/w500${movie.productionCompanies![2].logoPath}'
                          : 'assets/images/img_oval_3.png',
                      name: movie!.productionCompanies![2].name ?? 'Company 3',

                    ),
                  ),
                if (movie?.productionCompanies != null && movie!.productionCompanies!.length > 3)
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: ActorItemWidget(
                      imagePath: movie!.productionCompanies![3].logoPath != null
                          ? 'https://image.tmdb.org/t/p/w500${movie.productionCompanies![3].logoPath}'
                          : 'assets/images/img_oval_4.png',
                      name: movie!.productionCompanies![3].name ?? 'Company 4',

                    ),
                  ),
                // Add more if needed, using the same pattern
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Comments section
  Widget _buildCommentsSection(BuildContext context, List<ReviewEntity> reviews) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 32),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appTheme.colorFF1616,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Comments',
                style: TextStyleHelper.instance.headline24Bold,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View all',
                  style: TextStyleHelper.instance.body15.copyWith(
                    color: appTheme.colorFF2AB1,
                  ),
                ),
              ),
            ],
          ),
          if (reviews.isNotEmpty)
            Column(
              children: reviews.take(2).map((review) {
                return CommentWidget(
                  userImage: review.authorDetails.avatarPath.toString(),
                  userName: review.author,
                  date: review.createdAt.split('T')[0],
                  commentText: review.content,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
  void _showTrailerDialog(BuildContext context, String videoKey) {
    final youtubeController = YoutubePlayerController(
      initialVideoId: videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        hideControls: false,
      ),
    );

    showDialog(
      context: context,
      barrierColor: Colors.black54, // Darker overlay for modern feel
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent, // Transparent for custom background
        insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.black54],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title Bar
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.neonGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trailer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        youtubeController.dispose();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              // Video Player
              Container(
                height: 250, // Fixed height for a modern player feel
                child: YoutubePlayer(
                  controller: youtubeController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.redAccent,
                  onReady: () {
                    youtubeController.addListener(() {
                      if (youtubeController.value.isPlaying) {
                        // Optional: Add play state logic if needed
                      }
                    });
                  },
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(isExpanded: true),
                    RemainingDuration(),
                    FullScreenButton(),
                  ],
                  topActions: [
                    SizedBox(width: 8),
                    Expanded(child: Text('Playing...', style: TextStyle(color: Colors.white70))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.replay_10, color: Colors.white70),
                      onPressed: () => youtubeController.seekTo(youtubeController.value.position - Duration(seconds: 10)),
                    ),
                    IconButton(
                      icon: Icon(Icons.forward_10, color: Colors.white70),
                      onPressed: () => youtubeController.seekTo(youtubeController.value.position + Duration(seconds: 10)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}