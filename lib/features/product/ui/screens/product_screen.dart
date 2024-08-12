import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/features/product/providers/product_provider.dart';
import 'package:test_store/features/product/ui/widgets/gridview.dart';
import 'package:test_store/navigation_bar/navigation_bar.dart';
import 'package:test_store/res/constants/color_constants.dart';

@RoutePage()
class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(productProvider.notifier).loadServices());
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);
    final isLoading = productState.isLoading;
    final services = productState.services;

    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: Column(
        children: [
          const SizedBox(height: 40.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 360,
                      height: 52,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Поиск',
                          hintStyle: const TextStyle(color: Colors.black),
                          suffixIcon:
                              const Icon(Icons.search, color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: kGreyColor3,
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isLoading
              ? const Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      height: 190,
                      child: Center(child: CircularProgressIndicator())),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ServiceGridView(
                      serviceItems: services,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
