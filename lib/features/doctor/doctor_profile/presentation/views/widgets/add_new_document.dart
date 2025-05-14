import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/update_or_create_document.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';
import 'package:locum_care/features/doctor/doctor_profile/presentation/cubits/create_doctor_documents/create_doctor_documents_cubit.dart';

class AddNewDocumentWidget extends StatelessWidget {
  const AddNewDocumentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateDoctorDocumentsCubit(serviceLocator()),
      child: BlocConsumer<CreateDoctorDocumentsCubit, CreateDoctorDocumentsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return TextButton(
            onPressed: () async {
              CreateDoctorDocumentParams? params = await updateOrCreateDocument(context);
              if (params == null) return;
              context.read<CreateDoctorDocumentsCubit>().createDoctorDocument(params: params);
            },
            child: Row(
              children: [
                const Icon(Icons.add, size: 20),
                const SizedBox(width: 5),
                const Text('Add new document', style: TextStyle(fontSize: 14)),
                state.responseType == ResponseEnum.loading
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
