import 'package:client/core/theme/app_pallate.dart';
import 'package:client/features/auth/view/pages/signin_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ),
              (_) => false,
            );
          },
          leading: const CircleAvatar(
            radius: 35,
            backgroundColor: Pallete.borderColor,
            child: Icon(
              Icons.add,
              color: Pallete.secondary,
              size: 28,
            ),
          ),
          title: const Text(
            'LogOut',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
