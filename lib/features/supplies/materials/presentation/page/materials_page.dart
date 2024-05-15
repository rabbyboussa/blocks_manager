import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/supplies/materials/presentation/bloc/materials/materials_bloc.dart';
import 'package:blocks/features/supplies/materials/presentation/widgets/edit_material_dialog.dart';
import 'package:blocks/features/supplies/materials/presentation/widgets/materials_data_grid.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  @override
  void initState() {
    super.initState();

    context.read<ImagePickerBloc>().add(ResetImagePickerEvent());
    context.read<MaterialsBloc>().add(FetchMaterialsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialsBloc, MaterialsState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case MaterialsFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case MaterialsFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Matériaux'),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context
                                .read<MaterialsBloc>()
                                .add(FetchMaterialsEvent()),
                            child: const Text('Rafraîchir la page'),
                          ),
                          const SizedBox(width: 8),
                          Offstage(
                            offstage: context.read<AuthenticationBloc>().state.account!.roleId == 4 ,
                            child: FilledButton(
                              child: const Text('Ajouter un matériau'),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => const EditMaterialDialog(),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                children: [
                  const SizedBox(height: 16),
                  MaterialsDataGrid(materials: state.materials!)
                ],
              );
            }
          default:
            return const SizedBox();
        }
      },
    );
  }
}
