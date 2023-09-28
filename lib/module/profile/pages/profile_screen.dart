import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/auth/repo/auth_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/custom_appbar.dart';
import '../../../core/di/service_locator.dart';

class ProfileScreen extends StatelessWidget {
  final AuthRepository _authRepository = sl<AuthRepository>();
  final Uri _url = Uri.parse('https://en.gravatar.com');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(
        'Profile',
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 1,
            color: AppColors.primaryLight1,
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            height: 115,
            width: 115,
            child: Stack(
              children: [
                ClipOval(
                  child: Image.network(
                    _authRepository.user.avatarUrls.entries.last.value,
                    width: 115,
                    height: 115,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: -8,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        _launchUrl();
                      },
                      child: SvgPicture.asset(
                        "assets/images/svg/ic_camera.svg",
                        height: 38,
                        width: 38,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Text(
                _authRepository.user.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      hMargin: 0,
    );
  }
}
