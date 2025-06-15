import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/themes/colors.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color(0xFF161616),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            'assets/icons/back_icon.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            'assets/icons/remove_icon.svg',
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                          ),
                          onPressed: () {

                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(width: 16,),
                         Text(
                          'Filters',
                          style: TextStyle(
                            color: Color(0xFF2AB156),
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text(
                  'Sort by',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  // Handle Sort by filter
                },
              ),
              const Divider(color: Color(0xFF000000), thickness: 1, height: 1),
              ListTile(
                title: const Text('Country', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  // Handle Country filter
                },
              ),
              const Divider(color: Color(0xFF000000), thickness: 1, height: 1),
              ListTile(
                title: const Text('Year of release', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {

                },
              ),
              const Divider(color: Color(0xFF000000), thickness: 1, height: 1),
              ListTile(
                title: const Text('Subtitles', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {

                },
              ),
              const Divider(color: Color(0xFF000000), thickness: 1, height: 1),
              ListTile(
                title: const Text('Kinopoisk rating', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {

                },
              ),
              const Divider(color: Color(0xFF000000), thickness: 1, height: 1),
              ListTile(
                title: const Text('IMDb rating', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {

                },
              ),
              const Divider(color: Color(0xFF000000), thickness: 1, height: 1),
              ListTile(
                title: const Text('Genre', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {

                },
              ),
              const Divider(color: Color(0xFF000000), thickness: 1, height: 1),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ascending sort',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Switch(
                          value: true,
                          onChanged: (value) {
                            // Handle switch toggle
                          },
                          activeColor: const Color(0xFF2AB156),
                        ),
                      ],
                    ),
                    const Text(
                      'Cell description which explains the consequences of the above action.',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0,left: 16,right: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}