import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/database/database.dart' show UserData;
import 'package:madnolia/database/repository_manager.dart';
class AtomGroupChatInput extends StatefulWidget {

  final GlobalKey<FlutterMentionsState> inputKey;
  final List<String> usersList;
  final Function(String) onChanged;

  const AtomGroupChatInput({super.key, required this.inputKey, required this.usersList, required this.onChanged});

  @override
  State<AtomGroupChatInput> createState() => _AtomGroupChatInputState();
}

class _AtomGroupChatInputState extends State<AtomGroupChatInput> {

  late final Future<List<UserData>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchUsers();
  }

  Future<List<UserData>> _fetchUsers() {
    return RepositoryManager().user.getUsersByIds(widget.usersList);
  }

  @override
  Widget build(BuildContext context) {
    
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    
    return FutureBuilder(
      future: _usersFuture,
      builder: (context, asyncSnapshot) {

        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (asyncSnapshot.hasError) {
          return const Center(child: Text("Error loading users"));
        }        

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: FlutterMentions(
            mentions: [
              Mention(
                disableMarkup: true,
                trigger: '@',
                style: const TextStyle(
                  color: Colors.amber,
                ),
                data: asyncSnapshot.data!
                    .map((e) => {
                          "id": e.id,
                          "display": e.username,
                          "full_name": e.name,
                          "photo": e.thumb,
                        })
                    .toList(),
                matchAll: false,
                suggestionBuilder: (data) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children: <Widget>[
                        SizedBox(
                          width: screenWidth * 0.1,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            data['photo'],
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          children: <Widget>[
                            Text(data['full_name']),
                            Text('@${data['display']}'),
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            ],
            suggestionPosition: SuggestionPosition.Top,
            maxLines: 5,
            minLines: 1,
            suggestionListDecoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(20),
            ),
            key: widget.inputKey,
            style:  const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true, // Enable the filling of the background
              fillColor: const Color.fromARGB(12, 255, 255, 255), // Set the desired dark background color
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              hintText: t.CHAT.MESSAGE,
              hintStyle: const TextStyle(color: Colors.white70), // Optional: Change hint text color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
                gapPadding: 4
              ),
            ),
            onChanged: widget.onChanged,
          ),
        );
      }
    );
  }
}