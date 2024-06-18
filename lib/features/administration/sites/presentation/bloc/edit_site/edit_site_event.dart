part of 'edit_site_bloc.dart';

sealed class EditSiteEvent extends Equatable {
  const EditSiteEvent();

  @override
  List<Object> get props => [];
}

final class EditEvent extends EditSiteEvent {
  const EditEvent({
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
