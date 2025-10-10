import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ossc_chat_bot/app/theme/app_colors.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback? onLeaveReview;
  final VoidCallback? onEditReview;
  final VoidCallback? onMoreOptions;

  const OrderCard({
    super.key,
    required this.order,
    this.onLeaveReview,
    this.onEditReview,
    this.onMoreOptions,
  });

  @override
  Widget build(BuildContext context) {
    final mainProduct = order['products'][0];
    final hasReview = order['hasReview'] ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.whiteOff,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Order header
          Row(
            children: [
              // Shopping bag icon with checkmark
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.shopping_bag,
                  color: AppColors.primary,
                  size: 16,
                ),
              ),

              SizedBox(width: 3.w),

              // Date
              Expanded(
                child: Text(
                  order['date'] ?? 'Today Jul 22, 2025',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    fontFamily: 'DMSans',
                  ),
                ),
              ),

              // More options button
              GestureDetector(
                onTap: onMoreOptions ?? () {},
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: AppColors.whiteOff,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: AppColors.grayDefault,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Product details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Container(
                width: 25.w,
                height: 25.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primary.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    mainProduct['image'] ??
                        'https://via.placeholder.com/200x200',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.grayLighter,
                        child: Icon(
                          Icons.image,
                          color: AppColors.grayDefault,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(width: 3.w),

              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      mainProduct['name'] ?? 'Apple 55-Inch QLED 4K Smart TV',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontFamily: 'DMSans',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 0.5.h),

                    // Other products count
                    Text(
                      ' + ${order['otherProductsCount'] ?? 2} other products',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grayDefault,
                        fontFamily: 'DMSans',
                      ),
                    ),

                    SizedBox(height: 1.h),

                    // Price
                    Text(
                      '${order['totalAmount']?.toStringAsFixed(2) ?? '18899.00'} Br',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontFamily: 'DMSans',
                      ),
                    ),

                    SizedBox(height: 1.h),

                    // Review button
                    GestureDetector(
                      onTap: hasReview ? onEditReview : onLeaveReview,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: hasReview
                              ? AppColors.whiteOff
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                          border: hasReview
                              ? Border.all(color: AppColors.primary, width: 1)
                              : null,
                        ),
                        child: Text(
                          hasReview ? 'Edit Review' : 'Leave a Review',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: hasReview
                                ? AppColors.primary
                                : AppColors.whiteOff,
                            fontFamily: 'DMSans',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
