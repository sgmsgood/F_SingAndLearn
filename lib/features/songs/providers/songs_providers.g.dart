// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SongRepositoryNotifier)
final songRepositoryProvider = SongRepositoryNotifierProvider._();

final class SongRepositoryNotifierProvider
    extends $NotifierProvider<SongRepositoryNotifier, SongRepository> {
  SongRepositoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'songRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$songRepositoryNotifierHash();

  @$internal
  @override
  SongRepositoryNotifier create() => SongRepositoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SongRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SongRepository>(value),
    );
  }
}

String _$songRepositoryNotifierHash() =>
    r'8c4068094fdbcfa70fe2371dfa9f19a621315db6';

abstract class _$SongRepositoryNotifier extends $Notifier<SongRepository> {
  SongRepository build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SongRepository, SongRepository>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SongRepository, SongRepository>,
              SongRepository,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FetchSongList)
final fetchSongListProvider = FetchSongListProvider._();

final class FetchSongListProvider
    extends $AsyncNotifierProvider<FetchSongList, List<Song>> {
  FetchSongListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchSongListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchSongListHash();

  @$internal
  @override
  FetchSongList create() => FetchSongList();
}

String _$fetchSongListHash() => r'777bb11922d95f70ebe843a83a722b9a8115a564';

abstract class _$FetchSongList extends $AsyncNotifier<List<Song>> {
  FutureOr<List<Song>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Song>>, List<Song>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Song>>, List<Song>>,
              AsyncValue<List<Song>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FetchFavoriteSongList)
final fetchFavoriteSongListProvider = FetchFavoriteSongListProvider._();

final class FetchFavoriteSongListProvider
    extends $AsyncNotifierProvider<FetchFavoriteSongList, List<Song>> {
  FetchFavoriteSongListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchFavoriteSongListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchFavoriteSongListHash();

  @$internal
  @override
  FetchFavoriteSongList create() => FetchFavoriteSongList();
}

String _$fetchFavoriteSongListHash() =>
    r'2ffaba67791cf9ff716c2e87ff2c3592090a8db0';

abstract class _$FetchFavoriteSongList extends $AsyncNotifier<List<Song>> {
  FutureOr<List<Song>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Song>>, List<Song>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Song>>, List<Song>>,
              AsyncValue<List<Song>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FavoriteToggler)
final favoriteTogglerProvider = FavoriteTogglerProvider._();

final class FavoriteTogglerProvider
    extends $AsyncNotifierProvider<FavoriteToggler, void> {
  FavoriteTogglerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteTogglerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteTogglerHash();

  @$internal
  @override
  FavoriteToggler create() => FavoriteToggler();
}

String _$favoriteTogglerHash() => r'24543ef246425526403c9bb1a8cd1da99875cbbb';

abstract class _$FavoriteToggler extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
