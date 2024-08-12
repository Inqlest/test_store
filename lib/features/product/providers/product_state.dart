import 'package:test_store/features/product/model/service_item.dart';

class ProductState {
  final List<ServiceItem> services;
  final bool isLoading;

  ProductState({this.services = const [], this.isLoading = false});

  ProductState copyWith({List<ServiceItem>? services, bool? isLoading}) {
    return ProductState(
      services: services ?? this.services,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
