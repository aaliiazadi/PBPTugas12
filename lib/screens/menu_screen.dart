import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/menu_data.dart';
import '../models/menu.dart';
import '../providers/cart_provider.dart';
import '../utils/formatters.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Map<String, List<MenuItem>> _groupedMenu() {
    final Map<String, List<MenuItem>> grouped = {};
    for (final item in menuItems) {
      grouped.putIfAbsent(item.category, () => []).add(item);
    }

    for (final entries in grouped.values) {
      entries.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupedMenu();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: grouped.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  entry.key,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...entry.value.map((menu) => _MenuCard(menu: menu)),
              const Divider(height: 32),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final MenuItem menu;
  const _MenuCard({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                menu.imageUrl,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 72,
                  height: 72,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.fastfood),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatCurrency(menu.price),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (menu.description.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        menu.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              onPressed: () {
                context.read<CartProvider>().addToCart(menu);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${menu.name} ditambahkan ke keranjang'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
