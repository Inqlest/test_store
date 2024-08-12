import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/features/product/model/service_item.dart';
import 'package:test_store/features/product/providers/product_state.dart';
import 'package:test_store/shared_pref/shared_prefs.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final SharedPreferencesService _sharedPreferencesService;

  ProductNotifier(this._sharedPreferencesService) : super(ProductState()) {
    _loadFavoriteStatuses();
  }

  Future<void> _loadFavoriteStatuses() async {
    final favoriteTitles =
        await _sharedPreferencesService.loadFavoriteStatuses();

    final updatedServices = state.services.map((service) {
      final isFavorite = favoriteTitles.contains(service.title);
      return service.copyWith(isFavorite: isFavorite);
    }).toList();

    state = state.copyWith(services: updatedServices);
  }

  Future<void> _saveFavoriteStatus(ServiceItem item) async {
    await _sharedPreferencesService.saveFavoriteStatus(
        item.title, item.isFavorite);
  }

  Future<void> loadServices() async {
    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(seconds: 1));

    final services = [
      ServiceItem(
        imageUrl:
            'https://remo24.ru/images/categories/remont-stiralnyh-mashin.jpg',
        title: 'Ремонт стиральных машин и посудомоек',
        provider: 'Андрей Востриков',
        price: 'от 700 ₽',
      ),
      ServiceItem(
        imageUrl:
            'https://hiper-power.com/upload/iblock/76c/vazojx7xc0z447c6tjg31cpprxsa2t8n/1%20(2).jpg',
        title: 'Занятия по программированию и робототехнике',
        provider: 'Робокодинг',
        price: 'от 1500 ₽',
      ),
      ServiceItem(
        imageUrl:
            'https://topclim.ru/upload/resize_cache/webp/iblock/0a2/0a2f27b335ef720441b52b24eab08b62.webp',
        title: 'Установка кондиционера',
        provider: 'SkyPrikol',
        price: 'от 5000 ₽',
      ),
      ServiceItem(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZdxQ4i_yaDtfn0EQFIKw2weP2QvR6rHAP1g&s',
        title: 'Аниматор',
        provider: 'Хихихаха',
        price: 'от 1500 ₽',
      ),
    ];

    final favoriteTitles =
        await _sharedPreferencesService.loadFavoriteStatuses();

    final updatedServices = services.map((service) {
      final isFavorite = favoriteTitles.contains(service.title);
      return service.copyWith(isFavorite: isFavorite);
    }).toList();

    state = state.copyWith(services: updatedServices, isLoading: false);
  }

  void toggleFavoriteStatus(ServiceItem item) {
    final updatedServices = state.services.map((service) {
      if (service == item) {
        final updatedItem = service.copyWith(isFavorite: !service.isFavorite);
        _saveFavoriteStatus(updatedItem);
        return updatedItem;
      }
      return service;
    }).toList();

    state = state.copyWith(services: updatedServices);
  }
}
