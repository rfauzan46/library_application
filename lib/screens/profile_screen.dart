import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_application/constants/color_constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'Profile',
          style: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile_picture.png'), // Replace with actual profile image path
              ),
              const SizedBox(height: 20),
              Text(
                'Rizki Pratama',
                style: GoogleFonts.openSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: kBlackColor,
                ),
              ),
              const SizedBox(height: 40),
              ListTile(
                leading: const Icon(Icons.settings, color: kGreyColor),
                title: Text(
                  'Pengaturan',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kBlackColor,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: kGreyColor, size: 16),
                onTap: () {
                  // Navigate to settings page
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help_outline, color: kGreyColor),
                title: Text(
                  'FAQ',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kBlackColor,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: kGreyColor, size: 16),
                onTap: () {
                  // Navigate to FAQ page
                },
              ),
              const Divider(),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Logout functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                child: Text(
                  'Logout',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
