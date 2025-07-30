import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/modules/web-admin/chat-bot/chat_bot_controller.dart';

class ChatBotPage extends StatelessWidget {
  ChatBotPage({super.key});
  final ChatBotController controller = Get.find();
  final ScrollController _scrollController = ScrollController();
  // Function to show the clear chat confirmation dialog
  Future<void> _showClearChatDialog(BuildContext context) async {
    final confirmed = await CustomDialog.showConfirmDialog(
      context: context,
      title: "Xoá lịch sử trò chuyện",
      message: "Bạn có chắc chắn muốn xóa toàn bộ lịch sử trò chuyện?",
      cancelText: "Huỷ",
      confirmText: "Xoá",
      confirmColor: AppColor.error, // Red color for delete action
    );

    if (confirmed) {
      // Clear the chat history
      controller.messages.clear();
      controller.clearChatHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Row(
          children: [
            CustomSidebar(currentTitle: 'Chat bot'),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
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
                    // Clear chat button with confirmation dialog
                    IconButton(
                      onPressed: () => _showClearChatDialog(
                        context,
                      ), // Show confirmation dialog on press
                      icon: const Icon(
                        Icons.delete_forever,
                        color: AppColor.error,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IntrinsicWidth(
                      child: Obx(
                        () => DropdownButtonFormField<GeminiType>(
                          value: controller.typeGemini.value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.grey6,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          items: GeminiType.values.map((e) {
                            return DropdownMenuItem<GeminiType>(
                              value: e,
                              child: Text(e.title, style: AppStyle.regular14),
                            );
                          }).toList(),
                          onChanged: (p0) {
                            controller.changeTypeGemini(p0!);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                body: Obx(() {
                  // Auto scroll when new messages are added
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
                      // Displaying the list of messages
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
                                  left: message.isSentByUser ? 51 : 0,
                                  right: message.isSentByUser ? 0 : 51,
                                ),
                                decoration: BoxDecoration(
                                  color: message.isSentByUser
                                      ? Colors.blue.withOpacity(0.8)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  message.content,
                                  style: AppStyle.regular14.copyWith(
                                    color: message.isSentByUser
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: [
                            Flexible(
                              child: CustomTextField(
                                controller: controller.promptController,
                                onSubmit: (value) {
                                  controller.sendMessage();
                                },
                                hintText: 'Type your message...',
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                controller.sendMessage();
                              },
                              icon: const Icon(Icons.send_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
