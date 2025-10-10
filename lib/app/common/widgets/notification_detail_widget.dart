import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ossc_chat_bot/app/theme/app_colors.dart';

class NotificationDetailWidget extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback? onClose;
  final VoidCallback? onMarkAsRead;

  const NotificationDetailWidget({
    super.key,
    required this.notification,
    this.onClose,
    this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.whiteOff,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with close button
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color:
                        notification['iconBgColor'] ??
                        AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                  child: Icon(
                    notification['icon'] ?? Icons.info,
                    color: notification['iconColor'] ?? AppColors.primary,
                    size: 6.w,
                  ),
                ),
                SizedBox(width: 3.w),
                // Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification['title'] ?? 'Notification',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          fontFamily: 'DMSans',
                        ),
                      ),
                      Text(
                        notification['date'] ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.grayDefault,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ],
                  ),
                ),
                // Close button
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AppColors.grayLighter,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Icon(
                      Icons.close,
                      color: AppColors.grayDefault,
                      size: 4.w,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full content
                Text(
                  notification['description'] ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: AppColors.black,
                    fontFamily: 'DMSans',
                  ),
                ),
                SizedBox(height: 3.h),

                // Notification details
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Type', notification['type'] ?? 'INFO'),
                      SizedBox(height: 1.h),
                      _buildDetailRow(
                        'Status',
                        notification['status'] ?? 'UNREAD',
                      ),
                      SizedBox(height: 1.h),
                      _buildDetailRow('Time', notification['timestamp'] ?? ''),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),

                // Action buttons
                Row(
                  children: [
                    // Mark as Read button (if not already read)
                    if (!(notification['isRead'] ?? false))
                      Expanded(
                        child: GestureDetector(
                          onTap: onMarkAsRead,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 3.h),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Mark as Read',
                                style: TextStyle(
                                  color: AppColors.whiteOff,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'DMSans',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!(notification['isRead'] ?? false))
                      SizedBox(width: 3.w),
                    // Close button
                    Expanded(
                      child: GestureDetector(
                        onTap: onClose,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          decoration: BoxDecoration(
                            color: AppColors.grayLighter,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Close',
                              style: TextStyle(
                                color: AppColors.grayDefault,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DMSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.grayDefault,
            fontFamily: 'DMSans',
          ),
        ),
        Expanded(
          child: Text(
            value.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: AppColors.black,
              fontFamily: 'DMSans',
            ),
          ),
        ),
      ],
    );
  }
}
