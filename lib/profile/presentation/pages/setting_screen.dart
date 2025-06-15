import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoplayTVShows = false;
  bool _showDoubtfulQuality = false;
  bool _showMoviesWithAds = false;
  bool _parentalControl = true;
  bool _newsNotifications = false;
  bool _newMovieNotifications = false;
  bool _newSerialsNotifications = false;
  bool _newEpisodesNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF2AB156),
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.41,
          ),
        ),
      ),
      body: ListView(
        children: [
          // User Info Section
          Container(
            color: const Color(0xFF161616),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child:  Image.asset(
                      "assets/images/user_face.png"
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Katayama Fumiki',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.19,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  "assets/icons/edit.svg",
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFF121212)),
          Container(
            color: const Color(0xFF161616),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: [
                const Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.41,
                  ),
                ),
                const Spacer(),
                const Text(
                  'testemail@gmail.com',
                  style: TextStyle(
                    color: Color(0xFF8F8E94),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.41,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // PLAYER Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              'PLAYER',
              style: TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.08,
              ),
            ),
          ),
          _buildToggleItem(
            title: 'Autoplay for TV shows',
            value: _autoplayTVShows,
            onChanged: (value) {
              setState(() {
                _autoplayTVShows = value;
              });
            },
          ),
          const Divider(height: 1, color: Color(0xFF121212)),
          _buildToggleItem(
            title: 'Show films in doubtful quality',
            value: _showDoubtfulQuality,
            onChanged: (value) {
              setState(() {
                _showDoubtfulQuality = value;
              });
            },
          ),
          const Divider(height: 1, color: Color(0xFF121212)),
          _buildToggleItem(
            title: 'Show movies with ads',
            value: _showMoviesWithAds,
            onChanged: (value) {
              setState(() {
                _showMoviesWithAds = value;
              });
            },
          ),
          const Divider(height: 1, color: Color(0xFF121212)),
          _buildToggleItem(
            title: 'Parental control',
            value: _parentalControl,
            onChanged: (value) {
              setState(() {
                _parentalControl = value;
              });
            },
            trailingText: _parentalControl ? 'On' : 'Off',
          ),
          const SizedBox(height: 16),
          // MAILING Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              'MAILING',
              style: TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.08,
              ),
            ),
          ),
          _buildToggleItem(
            title: 'News',
            value: _newsNotifications,
            onChanged: (value) {
              setState(() {
                _newsNotifications = value;
              });
            },
          ),
          const Divider(height: 1, color: Color(0xFF121212)),
          _buildToggleItem(
            title: 'New movie',
            value: _newMovieNotifications,
            onChanged: (value) {
              setState(() {
                _newMovieNotifications = value;
              });
            },
          ),
          const Divider(height: 1, color: Color(0xFF121212)),
          _buildToggleItem(
            title: 'New serials',
            value: _newSerialsNotifications,
            onChanged: (value) {
              setState(() {
                _newSerialsNotifications = value;
              });
            },
          ),
          const Divider(height: 1, color: Color(0xFF121212)),
          _buildToggleItem(
            title: 'New episodes',
            value: _newEpisodesNotifications,
            onChanged: (value) {
              setState(() {
                _newEpisodesNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    String? trailingText,
  }) {
    return Container(
      color: const Color(0xFF161616),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.41,
              ),
            ),
          ),
          if (trailingText != null) ...[
            Text(
              trailingText,
              style: const TextStyle(
                color: Color(0xFF8F8E94),
                fontSize: 17,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.41,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF2AB156),
            inactiveTrackColor: const Color(0xFF8E8E93),
            thumbColor: const MaterialStatePropertyAll(Colors.white),
          ),
        ],
      ),
    );
  }
}