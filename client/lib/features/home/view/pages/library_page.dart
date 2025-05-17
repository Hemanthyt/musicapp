import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_pallate.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/view/pages/signin_page.dart';
import 'package:client/features/home/view/pages/upload_song_page.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFavSongsProvider).when(
        data: (data) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Text(
                    'Liked Songs',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Pallete.whiteColor,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length + 1,
                    itemBuilder: (context, index) {
                      if (index == data.length) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const UploadSongPage(),
                                ),
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
                              'Upload New Song',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        );
                      }
                      final song = data[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            onTap: () {
                              ref
                                  .read(currentSongNotifierProvider.notifier)
                                  .updateSong(song);
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(song.thumbnail_url),
                              radius: 35,
                              backgroundColor: Pallete.backgroundColor,
                            ),
                            title: Text(
                              song.song_name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              song.artist,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ListTile(
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
              ],
            ),
          );
        },
        error: (error, st) {
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () => const Loader());
  }
}
