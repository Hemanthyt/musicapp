import 'dart:ui';

import 'package:client/core/theme/app_pallate.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {
  final SongModel song;
  const SongCard({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 180,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: NetworkImage(song.thumbnail_url),
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(
          //   Colors.black.withOpacity(0.5),
          //   BlendMode.overlay,
          // ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            width: double.infinity,
            height: 55,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    song.song_name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    song.artist,
                    style: const TextStyle(
                      color: Pallete.subtitleText,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
