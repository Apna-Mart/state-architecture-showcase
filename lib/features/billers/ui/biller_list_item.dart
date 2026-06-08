import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'biller_list_item_data.dart';

class BillerListItem extends StatelessWidget {
  const BillerListItem({super.key, required this.item});

  final BillerListItemData item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.business),
      title: Text(item.name),
      subtitle: Text(item.categoryName),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.go('/biller/${item.id}'),
    );
  }
}
