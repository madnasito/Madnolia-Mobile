import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_connection_button.dart';

import '../../models/user/simple_user_model.dart' show SimpleUser;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int counter = 0;
  late final TextEditingController searchController;
  Timer? _debounceTimer;
  StreamSubscription? _requestSub;
  StreamSubscription? _acceptSub;
  StreamSubscription? _cancelSub;
  final _backgroundService = FlutterBackgroundService();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _setupStreamListeners();
  }

  void _setupStreamListeners() {
    _requestSub = _backgroundService.on('new_request_connection').listen((_) {
      if (mounted) setState(() {});
    });
    _acceptSub = _backgroundService.on('connection_accepted').listen((_) {
      if (mounted) setState(() {});
    });
    _cancelSub = _backgroundService.on('canceled_connection').listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _requestSub?.cancel();
    _acceptSub?.cancel();
    _cancelSub?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    debugPrint(value);
    counter++;
    
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          counter--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleCustomInput(
                placeholder: 'Search user',
                controller: searchController,
                iconData: Icons.search,
                autofocus: true,
                onChanged: _onSearchChanged,
              ),
              const SizedBox(height: 20),
              (counter == 0 && searchController.text.isNotEmpty)
                  ? Flexible(
                      child: FutureBuilder<List<SimpleUser>>(
                        future: _searchUsers(searchController.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          
                          if (snapshot.hasError || !snapshot.hasData) {
                            return const Text('Error loading users');
                          }
                          
                          return ListView.builder(
                            padding: const EdgeInsets.all(0),
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final user = snapshot.data![index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: CachedNetworkImageProvider(user.thumb),
                                ),
                                subtitle: Text(
                                  user.username,
                                  style: const TextStyle(color: Colors.white54),
                                ),
                                title: Text(user.name),
                                trailing: MoleculeConnectionButton(simpleUser: user),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<SimpleUser>> _searchUsers(String query) async {
    try {
      final resp = await UserService().searchUser(query);
      if (resp is Map) return [];
      return (resp as List).map((e) => SimpleUser.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Search error: $e');
      return [];
    }
  }
}