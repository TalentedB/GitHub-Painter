import 'dart:math';
import 'package:github_painter/di.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/convert.dart';

class ShOutput extends StatefulWidget {
  const ShOutput({super.key, required this.output});

  final String output;

  @override
  State<ShOutput> createState() => _ShOutputState();
}

class _ShOutputState extends State<ShOutput> {
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 221, 220, 210).withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Text(
                  widget.output,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            // onPressed: () async => await Clipboard.setData(ClipboardData(text: widget.output)),
            onPressed: () async =>
                await sl.get<ConvertService>().saveShell(widget.output),
            icon: const Icon(
              CupertinoIcons.square_fill_on_square_fill,
            ),
          ),
        ],
      ),
    );
  }
}
