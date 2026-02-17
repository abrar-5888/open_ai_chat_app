import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../components/chat_bubble.dart';
import '../../../theme/app_theme.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DeepMind AI",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(color: AppTheme.accentColor, shape: BoxShape.circle),
                ),
                SizedBox(width: 4.w),
                Text(
                  "Online",
                  style: TextStyle(fontSize: 12.sp, color: AppTheme.accentColor),
                ),
              ],
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Iconsax.setting_2, color: Colors.white),
        //     onPressed: () {},
        //   ),
        //   SizedBox(width: 8.w),
        // ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.messages.length,
                padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                itemBuilder: (context, index) {
                  return ChatBubble(message: controller.messages[index]);
                },
              ),
            ),
          ),
          _buildLoadingIndicator(),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Obx(
      () => controller.isLoading.value
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitThreeBounce(color: AppTheme.primaryColor, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    "AI is thinking...",
                    style: TextStyle(color: AppTheme.textBodyColor.withAlpha(128), fontSize: 12.sp),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.cardColor.withAlpha(128),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppTheme.primaryColor.withAlpha(77)),
                ),
                child: TextField(
                  controller: controller.textController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    hintStyle: TextStyle(color: AppTheme.textBodyColor.withAlpha(128)),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => controller.sendMessage(),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: controller.sendMessage,
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.secondaryColor], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: const Icon(Iconsax.send_1, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
