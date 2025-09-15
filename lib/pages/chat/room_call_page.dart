import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/match/full_match.model.dart';
import 'package:madnolia/widgets/atoms/atom_user_call.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';

const cellRed = Color(0xffc73232);
const cellMustard = Color(0xffd7aa22);
const cellGrey = Color(0xffcfd4e0);
const cellBlue = Color(0xff1553be);
const background = Color(0xff242830);

class RoomCallPage extends StatefulWidget {
  
  
  const RoomCallPage({super.key});

  @override
  State<RoomCallPage> createState() => _RoomCallPageState();
}

class _RoomCallPageState extends State<RoomCallPage> {

  final backgroundService = FlutterBackgroundService();
  final String callRoom = "call_room";

  @override
  void initState() {
    backgroundService.invoke("join_call_room", {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    FullMatch fullMatch = GoRouterState.of(context).extra! as FullMatch;

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: LayoutGrid(
                columnSizes: const [auto, auto, auto, auto],
                rowSizes: const [auto, auto, auto, auto], // Dynamically generate row sizes
                rowGap: 5,
                columnGap: 5,
                children: [
                  // Uncomment and modify these lines if needed
                  // Container(color: cellMustard).withGridPlacement(
                  //   columnStart: 0,
                  //   columnSpan: fullMatch.joined.length <= 4 ? 4 : 2,
                  //   rowStart: 0,
                  //   rowSpan: (4 / fullMatch.joined.length).round(),
                  // ),
                  // Container(color: cellGrey).withGridPlacement(
                  //   columnStart: 0,
                  //   columnSpan: 4,
                  //   rowStart: 2,
                  //   rowSpan: (4 / fullMatch.joined.length).round(),
                  // ),
        
                  ...List.generate(fullMatch.joined.length, (index) {
                    return AtomUserCall(
                      imgSize: fullMatch.joined.length <= 3 ? 70 : 40,
                      chatUser: fullMatch.joined[index])
                      .withGridPlacement(
                        columnStart: index <= 3 ? 0 : 2, // Assuming you want to place items in columns
                        columnSpan: fullMatch.joined.length <= 3 ? 4 : 2, 
                        rowStart: index <= 3 ? index : index - 4, // Calculate the row based on the index
                        rowSpan: fullMatch.joined.length <= 3 ? 1 : 1, // Each item takes one row
                    );
                  }),
                ],
              ),
            ),
            const Text("SUB-MENU"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    backgroundService.invoke("leave_call_room", {"room": "call_room"});
    super.dispose();
  }
}