import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/app-bar/admin_app_bar.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/app/modules/admin/chat-bot/chat_bot_controller.dart';

class ChatBotPage extends StatelessWidget {
  ChatBotPage({super.key});
  final ChatBotController controller = Get.find();
  final ScrollController _scrollController = ScrollController();

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
        backgroundColor: AppColor.backgroundColor,
        appBar: AdminAppBar(title: 'Chat bot'),
        drawer: CustomSidebar(currentTitle: 'Chat bot'),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 10.0,
                          children: [
                            Obx(
                              () => Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<GeminiType>(
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
                                      child: Text(
                                        e.title,
                                        style: AppStyle.regular14,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (p0) {
                                    controller.changeTypeGemini(p0!);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.error,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: () => _showClearChatDialog(context),
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: const CustomText(
                                  'Xoá chat',
                                  style: AppStyle.buttonPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        Obx(
                          () => controller.messages.isEmpty
                              ? const Center(
                                  child: CustomText('Chưa có tin nhắn nào'),
                                )
                              : Column(
                                  children: controller.messages
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                        final message = entry.value;
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                              _scrollController.jumpTo(
                                                _scrollController
                                                    .position
                                                    .maxScrollExtent,
                                              );
                                            });
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 12,
                                          ),
                                          child: Align(
                                            alignment: message.isSentByUser
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: Container(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.75,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: message.isSentByUser
                                                    ? AppColor.primary
                                                    : AppColor.grey2,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColor.shadow,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: CustomText(
                                                message.content,
                                                style: AppStyle.regular14
                                                    .copyWith(
                                                      color:
                                                          message.isSentByUser
                                                          ? Colors.white
                                                          : AppColor.primary
                                                                .withOpacity(
                                                                  0.8,
                                                                ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                      .toList(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                color: AppColor.backgroundColor,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        filled: true,
                        controller: controller.promptController,
                        onSubmit: (value) {
                          controller.sendMessage();
                        },
                        hintText: 'Nhập tin nhắn...',
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        controller.sendMessage();
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: AppColor.primary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
