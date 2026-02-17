import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/models/chat_message_model.dart';
import '../theme/app_theme.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 0.75.sw),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: message.isUser ? AppTheme.primaryColor : AppTheme.cardColor.withAlpha(204),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                  bottomLeft: message.isUser ? Radius.circular(20.r) : Radius.zero,
                  bottomRight: message.isUser ? Radius.zero : Radius.circular(20.r),
                ),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.r, offset: const Offset(0, 5))],
              ),
              child: Text(
                message.text,
                style: TextStyle(color: Colors.white, fontSize: 15.sp, height: 1.4),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}",
              style: TextStyle(color: AppTheme.textBodyColor.withAlpha(128), fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }
}
