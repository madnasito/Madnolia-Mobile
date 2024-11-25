import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/cubits/cubits.dart';

class MinutesPicker extends StatefulWidget {
  final List<int> items;
  
  const MinutesPicker({super.key, required this.items});

  @override
  State<MinutesPicker> createState() => _MinutesPicker();
}

class _MinutesPicker extends State<MinutesPicker> {
  int selectedItem = 5;
  
 void showDialog(Widget child) {
  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final matchMinutesCubit= context.watch<MatchMinutesCubit>();
    return TextField(
        onTap: () => showDialog(
                CupertinoPicker(
                  scrollController: FixedExtentScrollController(initialItem: selectedItem),
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index){
                    setState(() {
                      selectedItem = index;
                      matchMinutesCubit.updateMinutes(widget.items[index]);
                    });
                  },
                  children: List<Widget>.generate(widget.items.length, (int index){
                    return Center(child: Text("${widget.items[index]} min", style: const TextStyle(fontSize: 15),));
                  })
                )
              ),
        keyboardType: TextInputType.none,
        obscureText: true,
        controller: TextEditingController(text: ""),
        
        decoration: InputDecoration(
          prefixIcon: const Icon(CupertinoIcons.clock),
          disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Colors.blue)),
          hintText: "${translate('CREATE_MATCH.DURATION')}: ${widget.items[selectedItem]} minutes",
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Colors.blue))
        ),
    );
  }
}

  