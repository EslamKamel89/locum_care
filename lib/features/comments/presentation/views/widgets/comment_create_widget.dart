import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/features/comments/domain/models/comment_model.dart';
import 'package:locum_care/features/comments/domain/repos/comment_repo.dart';
import 'package:locum_care/features/comments/presentation/cubits/add_comment/add_comment_cubit.dart';

class CommentCreateWidget extends StatefulWidget {
  const CommentCreateWidget({
    super.key,
    required this.commentableType,
    required this.commentableId,
    required this.handleAddComment,
  });
  final String commentableType;
  final int commentableId;
  final Function(CommentModel model) handleAddComment;

  @override
  State<CommentCreateWidget> createState() => _CommentCreateWidgetState();
}

class _CommentCreateWidgetState extends State<CommentCreateWidget> {
  int _selectedRating = 1;
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCommentCubit(serviceLocator()),
      child: BlocConsumer<AddCommentCubit, AddCommentState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Your Rating',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.secondaryHeaderColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedRating = index + 1;
                            });
                          },
                          icon: Icon(
                            Icons.star,
                            color: _selectedRating > index ? Colors.amber : Colors.grey.shade400,
                            size: 32,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Leave a Reply',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.secondaryHeaderColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        labelText: 'Write your reply here...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      maxLines: 3,
                      validator:
                          (value) => valdiator(input: value, label: 'Review', isRequired: true),
                    ),
                    const SizedBox(height: 16),
                    state.responseType == ResponseEnum.loading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await _sendRequest(state, context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Submit'),
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future _sendRequest(AddCommentState state, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<AddCommentCubit>();
      final params = pr(
        AddCommentParams(
          commentableType: widget.commentableType,
          commentableId: widget.commentableId,
          content: _contentController.text,
          rating: _selectedRating,
        ),
        'AddCommentParams',
      );

      await controller.addComment(params: params, onAddComment: widget.handleAddComment);
      // pr(newComment, 'newComment');
      // pr(state.commentModel, 'state.commentModel');
      // pr(state.responseType, 'state.responseType');
      // if (newComment == null || state.commentModel == null || state.responseType != ResponseEnum.success) return;
      // // widget
      // //     .handleAddComment(pr(state.commentModel!, ' CommentCreateWidget - passed comment model from create to view'));
      // widget.handleAddComment(pr(newComment, ' CommentCreateWidget - passed comment model from create to view'));

      _selectedRating = 1;
      _contentController.text = '';
    }
  }
}
