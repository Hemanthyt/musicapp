import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_pallate.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:client/features/home/view/widgets/song_image_card.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SongPage extends ConsumerWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Latest Today',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ref.watch(getAllSongsProvider).when(
              data: (songs) {
                return SizedBox(
                  height: 260,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(currentSongNotifierProvider.notifier)
                                .updateSong(song);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SongCard(
                                  song: song,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
              error: (error, st) {
                return Center(
                  child: Text(
                    error.toString(),
                  ),
                );
              },
              loading: () => const Loader())
        ],
      ),
    );
  }
}
