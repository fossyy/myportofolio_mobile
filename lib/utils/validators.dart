class Validators {
  static String? required(String? value, String label, {int? maxLength}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '$label tidak boleh kosong!';
    }
    if (maxLength != null) {
      return Validators.maxLength(text, label, maxLength);
    }
    return null;
  }

  static String? maxLength(String? value, String label, int max) {
    if ((value?.trim().length ?? 0) > max) {
      return '$label maksimal $max karakter!';
    }
    return null;
  }

  static String? optionalUrl(String? value, String label, {int max = 200}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return null;
    }
    if (text.length > max) {
      return '$label maksimal $max karakter!';
    }
    final uri = Uri.tryParse(text);
    final isWebScheme = uri?.scheme == 'http' || uri?.scheme == 'https';
    final host = uri?.host ?? '';
    final hasValidHost = host == 'localhost' || host.contains('.');
    if (uri == null || !isWebScheme || !hasValidHost) {
      return '$label harus berupa URL http:// atau https:// yang valid!';
    }
    return null;
  }

  static String? year(String? value, String label) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '$label tidak boleh kosong!';
    }
    final year = int.tryParse(text);
    if (year == null || year < 1000 || year > 9999) {
      return '$label harus berupa tahun antara 1000 dan 9999!';
    }
    return null;
  }
}
