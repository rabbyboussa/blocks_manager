part of 'sites_bloc.dart';

sealed class SitesState extends Equatable {
  const SitesState({
    this.sites,
    this.message,
  });

  final List<SiteEntity>? sites;
  final String? message;

  @override
  List<Object?> get props => [
        sites,
        message,
      ];
}

final class SitesInitial extends SitesState {}

final class SitesFetchingLoadingState extends SitesState {}

final class SitesFetchingFailedState extends SitesState {
  const SitesFetchingFailedState({required String message})
      : super(message: message);
}

final class SitesFetchingDoneState extends SitesState {
  const SitesFetchingDoneState({required List<SiteEntity> sites})
      : super(sites: sites);
}
