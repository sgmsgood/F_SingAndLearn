// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_selection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LyricsSelection)
final lyricsSelectionProvider = LyricsSelectionProvider._();

final class LyricsSelectionProvider
    extends $NotifierProvider<LyricsSelection, Set<String>> {
  LyricsSelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lyricsSelectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lyricsSelectionHash();

  @$internal
  @override
  LyricsSelection create() => LyricsSelection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$lyricsSelectionHash() => r'9b4f854d6d6ff1f934dc945294e855436ec84326';

abstract class _$LyricsSelection extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedToken)
final selectedTokenProvider = SelectedTokenProvider._();

final class SelectedTokenProvider
    extends $NotifierProvider<SelectedToken, String?> {
  SelectedTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTokenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTokenHash();

  @$internal
  @override
  SelectedToken create() => SelectedToken();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedTokenHash() => r'4afb71054069c022ca05c6cea427115434dea811';

abstract class _$SelectedToken extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
