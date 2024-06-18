part of 'edit_site_bloc.dart';

sealed class EditSiteState extends Equatable {
  const EditSiteState();

  @override
  List<Object> get props => [];
}

final class EditsiteInitial extends EditSiteState {}

final class EditSiteLoadingState extends EditSiteState {}

final class EditSiteFailedState extends EditSiteState {
  const EditSiteFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class EditSiteDoneState extends EditSiteState {
  const EditSiteDoneState({
    required this.site,
    this.modification = false,
  });

  final SiteEntity site;
  final bool modification;

  @override
  List<Object> get props => [
        site,
        modification,
      ];
}
