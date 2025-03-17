import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/enums/connection-status.enum.dart';
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
  late int counter;
  late final TextEditingController searchController;

  @override
  void initState() {
    counter = 0;
    searchController = TextEditingController();
    super.initState();
    
  }


  @override
  void dispose() {
    counter = 0;
    super.dispose();
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
                      onChanged: (value){
                        debugPrint(searchController.text);
                        counter++;
                        Timer(
                          const Duration(seconds: 1),
                          () {
                            counter--;
                            setState(() {});
                          },
                        );
                      }),
                    const SizedBox(height: 20),
                    (counter == 0 && searchController.text.isNotEmpty)
                    ? Flexible(
                      child: FutureBuilder(
                        future: _searchUsers(searchController.text),
                        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                          if(snapshot.hasData){
                            final backgroundService = FlutterBackgroundService();

                            backgroundService.on("new_request_connection").listen((event)  {
                                setState(() {
                                  
                                });
                              });
                            return ListView.builder(
                              padding: const EdgeInsets.all(0),
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) { 
                                return ListTile(
                                  leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: CachedNetworkImageProvider(snapshot.data![index].thumb),),
                                  subtitle: Text(snapshot.data![index].username, style: const TextStyle(color: Colors.white54),),
                                  title: Text(snapshot.data![index].name),
                                  trailing: MoleculeConnectionButton(simpleUser: snapshot.data?[index]),
                                );
                               }
                              );
                          }else{
                            return const CircularProgressIndicator();
                          }
                         }
                      ),
                    )
                    : const SizedBox()
                  ],
                ),
            ),
        
        ),
      );
  }

  Future<List> _searchUsers(String query) async {
    final resp = await UserService().searchUser(query);
    if (resp is Map) return [];

    try {
      List users = resp.map((e) => SimpleUser.fromJson(e)).toList();
      return users;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }

  }
}