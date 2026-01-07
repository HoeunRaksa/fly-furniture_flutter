import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fly/features/product_detail/widget/viewer.dart';
import '../../../config/app_config.dart';
import '../../../model/product.dart';
import 'detail_header.dart';

class DetailBody extends StatelessWidget {
  final Product product;
  const DetailBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.only(bottom: 10),
      cacheExtent: 1000,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50, bottom: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                CupertinoColors.systemGrey6.darkColor.withOpacity(0.5),
                CupertinoColors.systemGrey6.darkColor.withOpacity(0.3),
              ]
                  : [
                Colors.white.withOpacity(0.95),
                Colors.white.withOpacity(0.85),
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: Border.all(
              color: CupertinoColors.separator.resolveFrom(context).withOpacity(0.2),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemBlue.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: CupertinoColors.black.withOpacity(isDark ? 0.3 : 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: product.images.isNotEmpty
                ? CachedNetworkImage(
              imageUrl: AppConfig.getImageUrl(product.images[0].imageUrl),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CupertinoColors.systemGrey6.resolveFrom(context),
                      CupertinoColors.systemGrey5.resolveFrom(context),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 250,
                child: const Center(
                  child: CupertinoActivityIndicator(
                    radius: 16,
                    color: CupertinoColors.systemBlue,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CupertinoColors.systemGrey6.resolveFrom(context),
                      CupertinoColors.systemGrey5.resolveFrom(context),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  CupertinoIcons.photo,
                  size: 50,
                  color: CupertinoColors.systemGrey.resolveFrom(context),
                ),
              ),
              fit: BoxFit.contain,
              width: double.infinity,
            )
                : Image.asset(
              "${AppConfig.imageUrl}/banner.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          ),
        ),

        // Name & Price
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    height: 1.2,
                    color: CupertinoColors.label.resolveFrom(context),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CupertinoColors.systemOrange.withOpacity(0.15),
                      CupertinoColors.systemOrange.withOpacity(0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: CupertinoColors.systemOrange.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemOrange.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    color: CupertinoColors.systemOrange,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Viewer (views, likes, rating)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Viewer(
            view: 20000,
            like: 3000,
            rating: 4,
          ),
        ),

        // Description
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 28, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    CupertinoColors.label.resolveFrom(context),
                    CupertinoColors.label.resolveFrom(context).withOpacity(0.85),
                  ],
                ).createShader(bounds),
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                    height: 1.2,
                    color: CupertinoColors.label.resolveFrom(context),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CupertinoColors.systemFill.resolveFrom(context).withOpacity(0.3),
                      CupertinoColors.secondarySystemFill.resolveFrom(context).withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: CupertinoColors.separator.resolveFrom(context).withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                    letterSpacing: 0.1,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}