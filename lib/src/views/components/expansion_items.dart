import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final list = items.map((e) {
      if (e.child != null) {
        return e.child!;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.title ?? "",
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey),
          ),
          Text(
            e.subtitle ?? "",
            style: theme.textTheme.titleMedium,
          ),
        ],
      );
    });
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 10, bottom: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        spacing: 20,
        runSpacing: 15,
        children: list.toList(),
      ),
    );
  }
}
