import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final double? aspectRatio;
  final double? imageHeight;
  final bool showVendor;
  final bool showRating;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
    this.aspectRatio = 0.7,
    this.imageHeight,
    this.showVendor = true,
    this.showRating = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            // Navigate to product detail page
            Get.toNamed(
              '/product-detail',
              arguments: {'productId': product['id']},
            );
          },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteOff,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.grayLighter.withOpacity(0.6),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image with discount badge and favorite button
            Stack(
              children: [
                Container(
                  height: imageHeight ?? 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    color: AppColors.grayLighter.withOpacity(0.35),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      product['image'] ??
                          'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400&h=300&fit=crop',
                      key: ValueKey<String>(
                        '${product['id']?.toString() ?? ''}|${product['image']?.toString() ?? ''}',
                      ),
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppColors.grayLighter.withOpacity(0.35),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400&h=300&fit=crop',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.grayLighter.withOpacity(0.35),
                              child: Icon(
                                Icons.image,
                                color: AppColors.grayDefault,
                                size: 40,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                // Discount badge
                if (product['discount'] != null)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${(product['discount'] is num ? (product['discount'] as num).round() : product['discount'])}% OFF',
                        style: TextStyle(
                          color: AppColors.whiteOff,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ),
                  ),
                // Favorite button
                Positioned(
                  right: 12,
                  bottom: 1,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap:
                        onFavoriteTap ??
                        () {
                          // Default favorite toggle behavior
                          // TODO: Implement favorite toggle functionality
                        },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.whiteOff,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.grayLighter,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        product['isFavorite'] == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product['isFavorite'] == true
                            ? AppColors.danger
                            : AppColors.grayDefault,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product details
            Container(
              height: 80, // Reduced height to fit within constraints
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Rating row - make it more compact
                  if (showRating)
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          final double rating = (product['rating'] is num
                              ? (product['rating'] as num).toDouble()
                              : 4.0);
                          return Padding(
                            padding: EdgeInsets.only(right: 1),
                            child: Icon(
                              index < rating.round()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 10,
                            ),
                          );
                        }),
                        SizedBox(width: 3),
                        Text(
                          '(${product['reviews'] ?? 877})',
                          style: TextStyle(
                            fontSize: 9,
                            color: AppColors.grayDefault,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ],
                    ),
                  if (showRating) SizedBox(height: 2),

                  // Vendor - make it more compact
                  if (showVendor)
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified,
                            color: AppColors.whiteOff,
                            size: 6,
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            product['vendor'] ?? 'Vendor Name',
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.grayDefault,
                              fontFamily: 'DMSans',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  if (showVendor) SizedBox(height: 2),

                  // Product name - make it more compact
                  Expanded(
                    child: Text(
                      product['name'] ?? 'Product Name',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontFamily: 'DMSans',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 2),

                  // Price - make it more compact
                  Row(
                    children: [
                      if (product['originalPrice'] != null) ...[
                        Text(
                          '\$${product['originalPrice'].toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.grayDefault,
                            decoration: TextDecoration.lineThrough,
                            fontFamily: 'DMSans',
                          ),
                        ),
                        SizedBox(width: 4),
                      ],
                      Text(
                        '\$${product['price']?.toStringAsFixed(0) ?? product['discountedPrice']?.toStringAsFixed(0) ?? '0'}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
