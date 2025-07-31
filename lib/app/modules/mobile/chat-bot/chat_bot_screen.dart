import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/app/modules/admin/chat-bot/chat_bot_controller.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatBotController controller = Get.find();
    final ScrollController _scrollController = ScrollController();

    // Function to show clear chat confirmation dialog
    Future<void> _showClearChatDialog(BuildContext context) async {
      final confirmed = await CustomDialog.showConfirmDialog(
        context: context,
        title: "Xoá lịch sử trò chuyện",
        message: "Bạn có chắc chắn muốn xóa toàn bộ lịch sử trò chuyện?",
        cancelText: "Huỷ",
        confirmText: "Xoá",
        confirmColor: AppColor.error,
      );

      if (confirmed) {
        await controller.clearChatHistory();
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat với Bot', style: AppStyle.appBarTitle),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFDFE4F1), Color(0xFFB0C7D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => _showClearChatDialog(context),
              icon: const Icon(Icons.delete_forever, color: AppColor.error),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Obx(() {
          if (controller.messages.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
              );
            });
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              // Message list
              ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 70),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return ListTile(
                    title: Align(
                      alignment: message.isSentByUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(
                          left: message.isSentByUser ? 51 : 16,
                          right: message.isSentByUser ? 16 : 51,
                        ),
                        decoration: BoxDecoration(
                          color: message.isSentByUser
                              ? AppColor.primary
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message.content,
                          style: AppStyle.regular14.copyWith(
                            color: message.isSentByUser
                                ? Colors.white
                                : AppColor.primary.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Input field and send button
              Positioned(
                bottom: 10,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        filled: true,
                        controller: controller.promptController,
                        onSubmit: (value) => controller.sendMessage(),
                        hintText: 'Nhập tin nhắn...',
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: controller.sendMessage,
                      icon: const Icon(
                        Icons.send_rounded,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
