part of 'sites_bloc.dart';

sealed class SitesEvent extends Equatable {
  const SitesEvent();

  @override
  List<Object> get props => [];
}

final class FetchSitesEvent extends SitesEvent {}

final class SiteAddedEvent extends SitesEvent {
  const SiteAddedEvent({required this.site});

  final SiteEntity site;

  @override
  List<SiteEntity> get props => [site];
}

final class SiteUpdatedEvent extends SitesEvent {
  const SiteUpdatedEvent({required this.site});

  final SiteEntity site;

  @override
  List<SiteEntity> get props => [site];
}
