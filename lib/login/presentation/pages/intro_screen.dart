import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/routes.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/text_styles.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/login/images/clapperboard.svg',
      'title': 'Welсome to Moviegoer',
      'description': 'Become our family of moviegoers we will watch movies together and share our impressions.',
    },
    {
      'image': 'assets/login/images/onboarding2.svg',
      'title': '+1000 movies and serials',
      'description': 'We have a huge library of films of serials of educational programs, which is updated every minute.',
    },
    {
      'image': 'assets/login/images/onboarding3.svg',
      'title': 'Gold Ticket',
      'description': 'Gold ticket gives you the opportunity to view 4K and 3D content, as well as you get +500 television channels.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: _buildBodyContent(context),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 62),
          _buildCarousel(context),
          const SizedBox(height: 16),
          _buildPageIndicator(context),
          const SizedBox(height: 50),
          _buildWelcomeText(context),
          const SizedBox(height: 30),
          _buildAuthButtons(context),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 287,
        viewportFraction: 1.0,
        initialPage: _currentIndex,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      items: _slides.map((slide) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppColors.backgroundLight.withOpacity(0.3),
                AppColors.backgroundDark.withOpacity(0.0),
              ],
              radius: 0.6,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              slide['image']!,
              height: 287,
              width: 287,
              fit: BoxFit.contain,
            ),
          ),
        );
      }).toList(),
    );
  }


  Widget _buildPageIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_slides.length, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? AppColors.backgroundLight : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Column(
      children: [
        Text(
          _slides[_currentIndex]['title']!,
          style: headlineStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Container(
          width: 276,
          height: 120,
          alignment: Alignment.center,
          child: Text(
            _slides[_currentIndex]['description']!,
            style: bodyStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Container(
      width: 343,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary, width: 3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(0, 50),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: AppColors.primary, fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(0, 50),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: const Text(
                    'Registration',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              print('Login with Facebook pressed');
            },
            child: const Text(
              'Login with Facebook',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
