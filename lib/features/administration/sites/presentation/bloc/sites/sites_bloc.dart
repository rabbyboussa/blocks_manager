import 'package:bloc/bloc.dart';
import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';
import 'package:blocks/features/administration/sites/domain/usecases/fetch_sites_usecase.dart';
import 'package:equatable/equatable.dart';

part 'sites_event.dart';
part 'sites_state.dart';

class SitesBloc extends Bloc<SitesEvent, SitesState> {
  SitesBloc({required FetchSitesUsecase fetchSitesUsecase})
      : _fetchSitesUsecase = fetchSitesUsecase,
        super(SitesInitial()) {
    on<FetchSitesEvent>(onFetching);
    on<SiteAddedEvent>(onSiteAdded);
    on<SiteUpdatedEvent>(onSiteUpdated);
  }

  final FetchSitesUsecase _fetchSitesUsecase;

  Future<void> onSiteAdded(
      SiteAddedEvent event, Emitter<SitesState> emit) async {
    List<SiteEntity> sites = List<SiteEntity>.from(state.sites!);
    SiteEntity site = event.site.copyWith();
    sites.add(site);
    emit(SitesFetchingDoneState(sites: sites));
  }

  Future<void> onSiteUpdated(
      SiteUpdatedEvent event, Emitter<SitesState> emit) async {
    List<SiteEntity> sites = List<SiteEntity>.from(state.sites!);
    final SiteEntity site = event.site.copyWith();
    final int index = sites.indexWhere((element) => element.id == site.id);
    sites[index] = site;
    emit(SitesFetchingDoneState(sites: sites));
  }

  Future<void> onFetching(
      FetchSitesEvent event, Emitter<SitesState> emit) async {
    emit(SitesFetchingLoadingState());

    final result = await _fetchSitesUsecase();

    result.fold(
      (failure) {
        emit(SitesFetchingFailedState(message: failure.message));
      },
      (sites) {
        emit(
          SitesFetchingDoneState(sites: sites),
        );
      },
    );
  }
}
