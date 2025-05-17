import 'package:client/core/logger/logger.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/src/either.dart';

class SearchPage extends ConsumerStatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<SongModel> _searchResults = [];
  bool _isLoading = false;

  void _searchSongs() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final results = await ref
          .watch(homeViewmodelProvider.notifier)
          .searchedData(query: _searchController.text);
      setState(() {
        _searchResults = results as List<SongModel>;
        _isLoading = false;
        LoggerHelper.error(_searchResults.toString());
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Songs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a song or artist',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchSongs,
                ),
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: _searchResults.isEmpty
                        ? Center(child: Text('No songs found'))
                        : ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              SongModel song = _searchResults[index];
                              return ListTile(
                                title: Text(song.song_name),
                                subtitle: Text(song.artist),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
