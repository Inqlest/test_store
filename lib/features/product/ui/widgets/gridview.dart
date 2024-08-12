import 'package:flutter/material.dart';
import 'package:test_store/features/product/model/service_item.dart';
import 'package:test_store/features/product/ui/widgets/service_card.dart';

class ServiceGridView extends StatelessWidget {
  final List<ServiceItem> serviceItems;

  const ServiceGridView({
    super.key,
    required this.serviceItems,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: serviceItems.length,
      itemBuilder: (context, index) {
        final item = serviceItems[index];
        return ServiceCard(item: item);
      },
    );
  }
}
