import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

/// Runtime API configuration (dynamic / configurable base URL).
///
/// ## How it works (no new app build when Odoo URL changes)
/// 1. App starts with last cached URL, or [defaultApiBaseUrl]
/// 2. App fetches JSON from [remoteConfigUrl] (stable URL hosted by client)
/// 3. Reads `base_url` / `api_base_url` and caches it
/// 4. All APIs use that value via [ApiConstants.baseUrl]
///
/// ## Client responsibility
/// Update the JSON at [remoteConfigUrl] when the Odoo URL changes.
///
/// Expected JSON:
/// ```json
/// { "base_url": "https://rta-parking-staging-xxxxx.dev.odoo.com" }
/// ```
class AppConfig {
  AppConfig._();
  static final AppConfig instance = AppConfig._();

  /// Fallback when no cache / remote config is available.
  static const String defaultApiBaseUrl =
      'https://rta-parking-staging-38199597.dev.odoo.com/api/';

  /// Stable config URL hosted by the client (they update the JSON).
  static const String remoteConfigUrl =
      'https://raw.githubusercontent.com/hisham-bassam/app-config/refs/heads/main/config.json';

  static const String _storageKey = 'api_base_url';
  static const String _remoteUrlOverrideKey = 'remote_config_url_override';

  String _apiBaseUrl = defaultApiBaseUrl;

  String get apiBaseUrl => _apiBaseUrl;

  /// Effective remote config URL (const, or optional local override for QA).
  String get effectiveRemoteConfigUrl {
    final override = GetStorage().read(_remoteUrlOverrideKey);
    if (override is String && override.trim().isNotEmpty) {
      return override.trim();
    }
    return remoteConfigUrl.trim();
  }

  /// Call once at app startup (after GetStorage.init).
  Future<void> init() async {
    final box = GetStorage();
    final cached = box.read(_storageKey);
    if (cached is String && cached.trim().isNotEmpty) {
      _apiBaseUrl = _normalizeBaseUrl(cached);
      if (kDebugMode) {
        debugPrint('AppConfig: using cached API base URL → $_apiBaseUrl');
      }
    } else {
      _apiBaseUrl = defaultApiBaseUrl;
      if (kDebugMode) {
        debugPrint('AppConfig: using default API base URL → $_apiBaseUrl');
      }
    }

    await refreshFromRemote();
  }

  /// Fetches client-hosted config and updates base URL if present.
  Future<bool> refreshFromRemote() async {
    final configUrl = effectiveRemoteConfigUrl;
    if (configUrl.isEmpty) {
      if (kDebugMode) {
        debugPrint(
          'AppConfig: remoteConfigUrl is empty — using cached/default URL. '
          'Ask client for a stable config JSON URL, then set '
          'AppConfig.remoteConfigUrl and rebuild once.',
        );
      }
      return false;
    }

    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Accept': 'application/json'},
          // Absolute URL — do not use API Dio baseUrl
          baseUrl: '',
        ),
      );

      if (kDebugMode) {
        debugPrint('AppConfig: fetching remote config → $configUrl');
      }

      final response = await dio.get(configUrl);
      if (response.statusCode != 200 || response.data == null) {
        return false;
      }

      final data = _asJsonMap(response.data);
      if (data == null) {
        if (kDebugMode) {
          debugPrint('AppConfig: remote config is not a JSON object');
        }
        return false;
      }

      // Client format uses "base_url"; also accept api_base_url / apiBaseUrl
      final remoteUrl = data['base_url']?.toString() ??
          data['api_base_url']?.toString() ??
          data['apiBaseUrl']?.toString();

      if (remoteUrl == null || remoteUrl.trim().isEmpty) {
        if (kDebugMode) {
          debugPrint('AppConfig: remote config missing base_url');
        }
        return false;
      }

      await setApiBaseUrl(remoteUrl);
      if (kDebugMode) {
        debugPrint('AppConfig: applied remote API base URL → $_apiBaseUrl');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AppConfig: remote config fetch failed: $e');
      }
      return false;
    }
  }

  /// GitHub raw may return text/plain; Dio then gives a String.
  static Map<String, dynamic>? _asJsonMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) {
          return decoded.map((key, value) => MapEntry(key.toString(), value));
        }
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  /// Manually set / override API base URL (cached).
  Future<void> setApiBaseUrl(String url) async {
    final normalized = _normalizeBaseUrl(url);
    _apiBaseUrl = normalized;
    await GetStorage().write(_storageKey, normalized);
  }

  /// Optional: override where the config JSON is loaded from (QA).
  Future<void> setRemoteConfigUrlOverride(String? url) async {
    final box = GetStorage();
    if (url == null || url.trim().isEmpty) {
      await box.remove(_remoteUrlOverrideKey);
    } else {
      await box.write(_remoteUrlOverrideKey, url.trim());
    }
  }

  static String _normalizeBaseUrl(String url) {
    var value = url.trim();
    if (value.isEmpty) return defaultApiBaseUrl;
    if (!value.endsWith('/')) {
      value = '$value/';
    }
    // If only host (or host/) was provided, append api/
    final uri = Uri.tryParse(value);
    if (uri != null) {
      final path = uri.path;
      if (path.isEmpty || path == '/') {
        value = '${value}api/';
      } else if (!path.contains('/api')) {
        value = '${value}api/';
      }
    }
    return value;
  }
}
