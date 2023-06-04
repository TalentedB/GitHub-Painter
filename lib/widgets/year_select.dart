import 'package:flutter/material.dart';

class YearSelect extends StatefulWidget {
  const YearSelect({Key? key, required this.onSubmit}) : super(key: key);

  final Function(String text) onSubmit;

  @override
  State<YearSelect> createState() => _YearSelectState();
}

class _YearSelectState extends State<YearSelect> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: DateTime.now().year.toString());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _controller.text;
    widget.onSubmit(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 30, minWidth: 100),
      width: MediaQuery.of(context).size.width / 20,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 106, 106, 106)),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        controller: _controller,
        onSubmitted: (_) => _handleSubmit(),
      ),
    );
  }
}
