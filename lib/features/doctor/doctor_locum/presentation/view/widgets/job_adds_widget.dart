import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/widgets/no_data_widget.dart';
import 'package:locum_care/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/cubits/show_all_add/show_all_adds_cubit.dart';
import 'package:locum_care/features/doctor/doctor_locum/presentation/view/widgets/job_add_widget.dart';

class JobAddsWidget extends StatefulWidget {
  const JobAddsWidget({super.key});

  @override
  State<JobAddsWidget> createState() => _JobAddsWidgetState();
}

class _JobAddsWidgetState extends State<JobAddsWidget> {
  late final ShowAllAddsCubit controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    controller = context.read<ShowAllAddsCubit>();
    controller.showAllJobAdds();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double scrollPosition = _scrollController.position.pixels;
    if (scrollPosition > maxExtent * 0.9) {
      controller.showAllJobAdds();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowAllAddsCubit, ShowAllAddsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.jobAddsResponse?.data?.isEmpty == true &&
            state.responseType == ResponseEnum.success) {
          return const NoDataWidget();
        }
        return ListView.builder(
          controller: _scrollController,
          itemCount: (state.jobAddsResponse?.data?.length ?? 0) + 1,
          itemBuilder: (context, index) {
            if (index < (state.jobAddsResponse?.data?.length ?? 0)) {
              final JobAddModel? model = state.jobAddsResponse?.data?[index];
              if (model == null) return const SizedBox();
              return JobAddWidget(jobAddModel: model);
            }

            return state.responseType == ResponseEnum.loading
                ? const JobAdLoadingWidget()
                : const SizedBox();
          },
        );
      },
    );
  }
}
