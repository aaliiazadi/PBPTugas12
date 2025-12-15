import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../utils/formatters.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        final totals = cart.totals;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Keranjang'),
            actions: [
              if (cart.items.isNotEmpty)
                IconButton(
                  tooltip: 'Kosongkan keranjang',
                  onPressed: cart.clear,
                  icon: const Icon(Icons.delete_outline),
                ),
            ],
          ),
          body: cart.items.isEmpty
              ? const Center(child: Text('Keranjang kosong'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.menu.imageUrl,
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        width: 64,
                                        height: 64,
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
                                          item.menu.name,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${formatCurrency(item.menu.price)} x ${item.quantity}',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          formatCurrency(item.lineTotal),
                                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () => cart.increment(item.menu.id),
                                        icon: const Icon(Icons.add_circle_outline),
                                      ),
                                      Text('${item.quantity}'),
                                      IconButton(
                                        onPressed: () => cart.decrement(item.menu.id),
                                        icon: const Icon(Icons.remove_circle_outline),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            offset: const Offset(0, -1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _TotalRow(label: 'Subtotal', value: formatCurrency(totals.subtotal)),
                          _TotalRow(
                            label: 'Service Charge 7.5%',
                            value: formatCurrency(totals.serviceCharge),
                          ),
                          _TotalRow(
                            label: 'PBI 10% (setelah service charge)',
                            value: formatCurrency(totals.pbi),
                          ),
                          const Divider(height: 20),
                          _TotalRow(
                            label: 'Total Bayar',
                            value: formatCurrency(totals.total),
                            isEmphasized: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isEmphasized;

  const _TotalRow({
    required this.label,
    required this.value,
    this.isEmphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = isEmphasized
        ? Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(value, style: textStyle),
        ],
      ),
    );
  }
}
