import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/administration/sites/presentation/bloc/sites/sites_bloc.dart';
import 'package:blocks/features/administration/sites/presentation/widgets/site_dialog.dart';
import 'package:blocks/features/administration/sites/presentation/widgets/sites_data_grid.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SitesPage extends StatefulWidget {
  const SitesPage({super.key});

  @override
  State<SitesPage> createState() => _SitesPageState();
}

class _SitesPageState extends State<SitesPage> {
  @override
  void initState() {
    super.initState();

    context.read<SitesBloc>().add(FetchSitesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SitesBloc, SitesState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case SitesFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case SitesFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sites de productions'),
                          SizedBox(height: 12),
                          Text(
                            'Cette page vous permet de gérer l\'ensemble de vos sites de production.\nVous pouvez ajouter un site en cliquant sur le bouton vert à droite.',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context
                                .read<SitesBloc>()
                                .add(FetchSitesEvent()),
                            child: const Text('Rafraîchir la page'),
                          ),
                          const SizedBox(width: 8),
                          FilledButton(
                            child: const Text('Ajouter un site'),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => const SiteDialog(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                children: [
                  const SizedBox(height: 16),
                  SitesDataGrid(
                    sites: state.sites!,
                  )
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
