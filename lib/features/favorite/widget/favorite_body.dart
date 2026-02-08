import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:fly/core/widgets/small_card.dart';
import '../../../config/app_config.dart';
import '../../../model/product.dart';

class FavoriteBody extends StatelessWidget {
  final List<Product> favorites;
  const FavoriteBody({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (_, index) {
        final p = favorites[index];
        final imageProvider = p.images.isNotEmpty
            ? CachedNetworkImageProvider(
          AppConfig.getImageUrl(p.images[0].imageUrl),
        )
            : const AssetImage('assets/images/placeholder.png') as ImageProvider;
        return SizedBox(
          child: SmallCard(product: p, image: imageProvider,),
        );
      },
    );
  }
}
