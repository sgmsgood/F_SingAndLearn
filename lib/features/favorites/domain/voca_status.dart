enum VocaStatus {
  unknown,
  known,
}

extension VocaStatusX on VocaStatus {
  String get db {
    switch (this) {
      case VocaStatus.unknown:
        return 'unknown';
      case VocaStatus.known:
        return 'known';
    }
  }

  static VocaStatus fromDb(String? s) {
    switch (s) {
      case 'known':
        return VocaStatus.known;
      case 'unknown':
      default:
        return VocaStatus.unknown;
    }
  }

  VocaStatus toggle() => this == VocaStatus.unknown ? VocaStatus.known : VocaStatus.unknown;

  String get label => this == VocaStatus.unknown ? '모름' : '외움';
}