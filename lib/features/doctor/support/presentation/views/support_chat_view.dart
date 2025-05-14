import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/core/widgets/no_data_widget.dart';
import 'package:locum_care/features/doctor/support/presentation/cubits/get_all_messages/get_all_messages_cubit.dart';
import 'package:locum_care/features/doctor/support/presentation/cubits/send_support_message/send_support_message_cubit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SupportChatView extends StatefulWidget {
  const SupportChatView({super.key});

  @override
  State<SupportChatView> createState() => _SupportChatViewState();
}

class _SupportChatViewState extends State<SupportChatView> {
  late final GetAllMessagesCubit controller;
  final _messageController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  void initState() {
    _initState();
    super.initState();
  }

  Future _initState() async {
    controller = context.read<GetAllMessagesCubit>();
    await controller.fetchAllSupport();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllMessagesCubit, GetAllMessagesState>(
      builder: (context, state) {
        return MainScaffold(
          appBarTitle: "Support Chat",
          drawer: const DefaultDoctorDrawer(),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   child: Icon(MdiIcons.refresh  ),
          // ),
          child: Column(
            children: [
              Expanded(
                child:
                    state.supportModels?.isEmpty == true &&
                            state.responseType != ResponseEnum.loading
                        ? const NoDataWidget()
                        : state.supportModels?.isEmpty == true &&
                            state.responseType == ResponseEnum.loading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          itemCount: state.supportModels!.length,
                          reverse: true,
                          padding: const EdgeInsets.all(16.0),
                          itemBuilder: (context, index) {
                            final message =
                                state.supportModels![state.supportModels!.length - 1 - index];
                            // final message = state.supportModels![index];
                            final isUser = message.sender == "user";

                            return Align(
                              alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                              child: Animate(
                                effects: [
                                  SlideEffect(duration: 300.ms, begin: const Offset(1, 0)),
                                  FadeEffect(duration: 300.ms),
                                ],
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isUser ? context.primaryColor : Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(12.0),
                                      topRight: const Radius.circular(12.0),
                                      bottomLeft:
                                          isUser ? const Radius.circular(12.0) : Radius.zero,
                                      bottomRight:
                                          isUser ? Radius.zero : const Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message.content ?? '',
                                        style: TextStyle(
                                          color: isUser ? Colors.white : Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        message.createdAt ?? '',
                                        style: TextStyle(
                                          color: isUser ? Colors.white70 : Colors.black54,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
              _buildMessageInput(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return BlocProvider(
      create: (context) => SendSupportMessageCubit(serviceLocator()),
      child: BlocConsumer<SendSupportMessageCubit, SendSupportMessageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Form(
            key: _key,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: const BoxDecoration(),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                      validator:
                          (value) =>
                              valdiator(input: value, label: 'Message Content', isRequired: true),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        await context.read<SendSupportMessageCubit>().sendSupportMessage(
                          _messageController.text,
                        );
                        context.read<GetAllMessagesCubit>().addMessage(_messageController.text);
                        _messageController.text = '';
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    icon: Icon(Icons.send, color: context.secondaryHeaderColor),
                  ),
                  controller.state.responseType == ResponseEnum.loading
                      ? Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      )
                      : InkWell(
                        onTap: () {
                          controller.fetchAllSupport();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Icon(MdiIcons.refresh, color: Colors.white),
                        ),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
