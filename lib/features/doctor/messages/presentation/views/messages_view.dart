import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/widgets/circular_image_asset.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/no_data_widget.dart';
import 'package:locum_care/features/doctor/messages/domain/models/message_card_model.dart';
import 'package:locum_care/features/doctor/messages/presentation/cubits/get_all_chat/get_all_chat_cubit.dart';
import 'package:locum_care/utils/assets/assets.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  late final GetAllChatCubit controller;
  int totalUnseenCount = 0;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  Future _initState() async {
    controller = context.read<GetAllChatCubit>();
    await controller.fetchAllChat();
    totalUnseenCount =
        controller.state.messageCards?.isNotEmpty == true
            ? controller.state.messageCards?.first.notSeenCountTotal ?? 0
            : 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllChatCubit, GetAllChatState>(
      builder: (context, state) {
        pr(state.messageCards?.length, 'state.messageCards?.length');
        return Scaffold(
          appBar: AppBar(
            title:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Inbox'),
                    const SizedBox(width: 10),
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:
                          state.responseType == ResponseEnum.loading
                              ? Container(
                                height: 18.h,
                                width: 18.h,
                                alignment: Alignment.center,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(),
                                child: const CircularProgressIndicator(strokeWidth: 2),
                              )
                              : Text(
                                '$totalUnseenCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ],
                ).animate().scale(),
            centerTitle: true,
          ),
          endDrawer: const DefaultDoctorDrawer(),
          body: RefreshIndicator(
            child:
                state.messageCards?.isEmpty == true && state.responseType != ResponseEnum.loading
                    ? const NoDataWidget()
                    : state.messageCards?.isEmpty == true &&
                        state.responseType == ResponseEnum.loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: state.messageCards?.length,
                      // itemCount: 5,
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final MessageCardModel? model = state.messageCards?[index];
                        if (model == null) return const SizedBox();
                        return ChatTile(
                          messageCardModel: model,
                        ).animate().scale(delay: (index * 100).ms);
                      },
                    ),
            onRefresh: () async {
              controller.fetchAllChat();
            },
          ),
        );
      },
    );
  }
}

class ChatTile extends StatelessWidget {
  final MessageCardModel messageCardModel;

  const ChatTile({super.key, required this.messageCardModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: SizedBox(
          width: 50.h,
          child: CircularCachedImage(
            imageUrl: messageCardModel.otherUserPhoto ?? '',
            imageAsset: AssetsData.malePlacholder,
            height: 50.h,
          ),
        ),
        title: Text(
          messageCardModel.otherUserName ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle:
            messageCardModel.notSeenCount != null && messageCardModel.notSeenCount! > 0
                ? Text(
                  'You have ${messageCardModel.notSeenCount} unseen messages',
                  style: const TextStyle(color: Colors.redAccent),
                )
                : const Text('No new messages', style: TextStyle(color: Colors.grey)),
        trailing:
            messageCardModel.notSeenCount != null && messageCardModel.notSeenCount! > 0
                ? Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${messageCardModel.notSeenCount}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
                : null,
      ),
    );
  }
}
