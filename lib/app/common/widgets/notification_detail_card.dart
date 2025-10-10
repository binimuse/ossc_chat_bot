import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ossc_chat_bot/app/theme/app_colors.dart';

class NotificationDetailCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback? onViewDetail;
  final VoidCallback? onDismiss;
  final VoidCallback? onToggleExpansion;

  const NotificationDetailCard({
    super.key,
    required this.notification,
    this.onViewDetail,
    this.onDismiss,
    this.onToggleExpansion,
  });

  @override
  Widget build(BuildContext context) {
    final isRead = notification['isRead'] ?? false;
    final hasAction = notification['hasAction'] ?? false;
    final isExpanded = notification['isExpanded'] ?? false;
    final shouldShowExpand = notification['shouldShowExpand'] ?? false;
    final isContentTruncated = notification['isContentTruncated'] ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
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
          // Main notification content
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color:
                        notification['iconBgColor'] ??
                        AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Icon(
                    notification['icon'] ?? Icons.info,
                    color: notification['iconColor'] ?? AppColors.primary,
                    size: 5.w,
                  ),
                ),

                SizedBox(width: 3.w),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'] ?? 'Notification Title',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DMSans',
                              ),
                            ),
                          ),

                          // Unread indicator
                          if (!isRead)
                            Container(
                              width: 2.w,
                              height: 2.w,
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                borderRadius: BorderRadius.circular(1.w),
                              ),
                            ),

                          SizedBox(width: 2.w),

                          // Expand/collapse button (only show if content can be expanded)
                          if (shouldShowExpand)
                            GestureDetector(
                              onTap: () => onToggleExpansion?.call(),
                              child: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: AppColors.primary,
                                size: 6.w,
                              ),
                            ),
                        ],
                      ),

                      // Description (always show, but limit to 4 lines if not expanded)
                      SizedBox(height: 2.h),
                      Text(
                        notification['description'] ??
                            'Notification description goes here...',
                        style: TextStyle(
                          color: AppColors.grayDefault,
                          fontSize: 14,
                          fontFamily: 'DMSans',
                          height: 1.4,
                        ),
                        maxLines: isExpanded ? null : 4,
                        overflow: isExpanded ? null : TextOverflow.ellipsis,
                      ),

                      // Timestamp
                      SizedBox(height: 2.h),
                      Text(
                        notification['timestamp'] ?? '02:12 AM',
                        style: TextStyle(
                          color: AppColors.grayDefault,
                          fontSize: 12,
                          fontFamily: 'DMSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Action button (show if has action or if content is truncated)
          if (hasAction || isContentTruncated)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                                     // View Detail button (for unread notifications)
                   if (!isRead)
                     Expanded(
                       child: GestureDetector(
                         onTap: () => onViewDetail?.call(),
                         child: Container(
                           padding: EdgeInsets.symmetric(
                             horizontal: 12,
                             vertical: 8,
                           ),
                           decoration: BoxDecoration(
                             color: AppColors.primary.withOpacity(0.1),
                             borderRadius: BorderRadius.circular(8),
                             border: Border.all(
                               color: AppColors.primary.withOpacity(0.3),
                             ),
                           ),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Icon(
                                 Icons.open_in_new,
                                 color: AppColors.primary,
                                 size: 16,
                               ),
                               SizedBox(width: 6),
                               Text(
                                 'View Detail',
                                 style: TextStyle(
                                   color: AppColors.primary,
                                   fontSize: 14,
                                   fontWeight: FontWeight.w600,
                                   fontFamily: 'DMSans',
                                 ),
                               ),
                               SizedBox(width: 4),
                               Container(
                                 padding: EdgeInsets.symmetric(
                                   horizontal: 6,
                                   vertical: 2,
                                 ),
                                 decoration: BoxDecoration(
                                   color: AppColors.success,
                                   borderRadius: BorderRadius.circular(4),
                                 ),
                                 child: Text(
                                   'Mark as Read',
                                   style: TextStyle(
                                     color: AppColors.whiteOff,
                                     fontSize: 10,
                                     fontWeight: FontWeight.w500,
                                     fontFamily: 'DMSans',
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),

                   // View More button (for expanded content)
                   if (shouldShowExpand && isRead)
                     Expanded(
                       child: GestureDetector(
                         onTap: () => onToggleExpansion?.call(),
                         child: Container(
                           padding: EdgeInsets.symmetric(
                             horizontal: 12,
                             vertical: 8,
                           ),
                           decoration: BoxDecoration(
                             color: AppColors.grayLighter,
                             borderRadius: BorderRadius.circular(8),
                           ),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Icon(
                                 isExpanded
                                     ? Icons.keyboard_arrow_up
                                     : Icons.keyboard_arrow_down,
                                 color: AppColors.grayDefault,
                                 size: 16,
                               ),
                               SizedBox(width: 6),
                               Text(
                                 isExpanded ? 'View Less' : 'View More',
                                 style: TextStyle(
                                   color: AppColors.grayDefault,
                                   fontSize: 14,
                                   fontWeight: FontWeight.w600,
                                   fontFamily: 'DMSans',
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
