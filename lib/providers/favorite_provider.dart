import 'package:flutter/foundation.dart';
import 'package:fly/features/service/favorite_service.dart';
import '../providers/product_provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteService favoriteService;

  FavoriteProvider({FavoriteService? favoriteService})
      : favoriteService = favoriteService ?? FavoriteService();

  Future<void> toggleFavorite({
    required ProductProvider productProvider,
    required String token,
    required String productId,
  }) async {
    final index =
    productProvider.products.indexWhere((p) => p.id == productId);
    if (index == -1) return;

    final old = productProvider.products[index];
    final newValue = !old.isFavorite;

    // ✅ update UI immediately (same list used by UI)
    productProvider.products[index] = old.copyWith(isFavorite: newValue);
    productProvider.notifyListeners();

    try {
      if (newValue) {
        try {
          await favoriteService.addFavorite(token: token, productID: productId);
        } catch (e) {
          if (!e.toString().contains('already in favorites')) {
            rethrow;
          }
        }
      } else {
        await favoriteService.removeFavorite(token: token, productID: productId);
      }
    } catch (e) {
      // rollback
      productProvider.products[index] = old;
      productProvider.notifyListeners();
      rethrow;
    }
  }
}
