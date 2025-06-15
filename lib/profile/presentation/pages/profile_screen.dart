import 'package:cinematika/profile/presentation/pages/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF161616),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.movie_filter, color: Color(0xFF2AB156), size: 30),
                      const SizedBox(width: 8),
                      const Text(
                        'Moviegoer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SettingsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child:  Image.asset(
                          "assets/images/user_face.png"
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Katayama Fumiki',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/vip.svg',
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Gold ticket',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildMenuItem('assets/icons/threed_rotation.svg', '3D Movie', context),
            _buildMenuItem('assets/icons/sports.svg', 'Sport', context),
            _buildMenuItem('assets/icons/music_note.svg', 'Concert', context),
            _buildMenuItem('assets/icons/description.svg', 'Documental', context),
            _buildMenuItem('assets/icons/four_k.svg', '4K Movie', context),
            _buildMenuItem('assets/icons/history.svg', 'History', context),
            _buildMenuItem('assets/icons/tv.svg', 'TV', context),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String iconPath, String title, BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        color: Colors.grey,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        print('Tapped on $title');
      },
    );
  }
}