import 'package:madnolia/database/repository_manager.dart';
// import 'package:madnolia/models/chat_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

import '../custom_input_widget.dart';

class InputGroupMessage extends StatefulWidget {
  final Stream<String> stream;
  final GlobalKey<FlutterMentionsState> inputKey;
  final List<String> usersList;
  final String placeholder;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final TextEditingController? controller;

  const InputGroupMessage({
    super.key,
    required this.placeholder,
    required this.stream,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.controller,
    required this.usersList,
    required this.inputKey,
  });

  @override
  State<InputGroupMessage> createState() => _InputGroupMessageState();
}

class _InputGroupMessageState extends State<InputGroupMessage> {
  late Future<List<dynamic>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchUsers();
  }

  Future<List<dynamic>> _fetchUsers() {
    return RepositoryManager().user.getUsersByIds(widget.usersList);
  }

  @override
  void didUpdateWidget(InputGroupMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.usersList != oldWidget.usersList) {
      setState(() {
        _usersFuture = _fetchUsers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Size screenSize = MediaQuery.of(context).size;
        double screenWidth = screenSize.width;

        return Container(
          width: screenWidth * 0.8,
          padding: const EdgeInsets.only(right: 0),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: FutureBuilder(
            future: _usersFuture,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return FlutterMentions(
                key: widget.inputKey,
                suggestionPosition: SuggestionPosition.Top,
                maxLines: 5,
                minLines: 1,
                suggestionListDecoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20),
                ),
                mentions: [
                  Mention(
                    disableMarkup: true,
                    trigger: '@',
                    style: const TextStyle(
                      color: Colors.amber,
                    ),
                    data: asyncSnapshot.data!
                        .map((e) => {
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
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  errorText: snapshot.error as String?,
                  errorBorder: errorBorder,
                  enabledBorder: snapshot.hasData ? validBorder : null,
                  focusedErrorBorder: warningBorder,
                  focusedBorder: focusedBorder,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 3),
                  ),
                ),
                onChanged: widget.onChanged,
              );
            },
          ),
        );
      },
    );
  }
}
