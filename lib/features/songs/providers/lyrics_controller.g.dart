// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LyricsController)
final lyricsControllerProvider = LyricsControllerProvider._();

final class LyricsControllerProvider
    extends $NotifierProvider<LyricsController, void> {
  LyricsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lyricsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lyricsControllerHash();

  @$internal
  @override
  LyricsController create() => LyricsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$lyricsControllerHash() => r'3e9d781f7c40f7db89012291d3fdbbbd33ed99b3';

abstract class _$LyricsController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
