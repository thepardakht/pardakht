import 'package:flutter/cupertino.dart';

class ExpansionItem {
  final String? title;
  final String? subtitle;
  final Widget? child;

  ExpansionItem({
    this.title,
    this.subtitle,
    this.child,
  });
}

class ExpansionItems extends StatelessWidget {
  final List<ExpansionItem> items;
  const ExpansionItems({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final list = items.map((e) {
      if (e.child != null) {
        return e.child!;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e.title ?? ""),
          Text(e.subtitle ?? ""),
        ],
      );
    });
    return Padding(
      padding: const EdgeInsets.only(left: 70, right: 10, bottom: 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 8,
        children: list.toList(),
      ),
    );
  }
}
