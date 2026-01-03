// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyric_lines_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LyricLineRepositoryNotifier)
final lyricLineRepositoryProvider = LyricLineRepositoryNotifierProvider._();

final class LyricLineRepositoryNotifierProvider
    extends
        $NotifierProvider<LyricLineRepositoryNotifier, LyricLineRepository> {
  LyricLineRepositoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lyricLineRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lyricLineRepositoryNotifierHash();

  @$internal
  @override
  LyricLineRepositoryNotifier create() => LyricLineRepositoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LyricLineRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LyricLineRepository>(value),
    );
  }
}

String _$lyricLineRepositoryNotifierHash() =>
    r'e3f7baa86a704125aa1b05f1660ef9ec628e6b0b';

abstract class _$LyricLineRepositoryNotifier
    extends $Notifier<LyricLineRepository> {
  LyricLineRepository build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LyricLineRepository, LyricLineRepository>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LyricLineRepository, LyricLineRepository>,
              LyricLineRepository,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(LyricLines)
final lyricLinesProvider = LyricLinesFamily._();

final class LyricLinesProvider
    extends $AsyncNotifierProvider<LyricLines, List<LyricsLine>> {
  LyricLinesProvider._({
    required LyricLinesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'lyricLinesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lyricLinesHash();

  @override
  String toString() {
    return r'lyricLinesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LyricLines create() => LyricLines();

  @override
  bool operator ==(Object other) {
    return other is LyricLinesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lyricLinesHash() => r'39f81f1868ffc80586ed58bbaf2fdd5944551570';

final class LyricLinesFamily extends $Family
    with
        $ClassFamilyOverride<
          LyricLines,
          AsyncValue<List<LyricsLine>>,
          List<LyricsLine>,
          FutureOr<List<LyricsLine>>,
          String
        > {
  LyricLinesFamily._()
    : super(
        retry: null,
        name: r'lyricLinesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LyricLinesProvider call(String songId) =>
      LyricLinesProvider._(argument: songId, from: this);

  @override
  String toString() => r'lyricLinesProvider';
}

abstract class _$LyricLines extends $AsyncNotifier<List<LyricsLine>> {
  late final _$args = ref.$arg as String;
  String get songId => _$args;

  FutureOr<List<LyricsLine>> build(String songId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<LyricsLine>>, List<LyricsLine>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<LyricsLine>>, List<LyricsLine>>,
              AsyncValue<List<LyricsLine>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
