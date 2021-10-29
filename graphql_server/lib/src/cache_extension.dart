import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart' show sha1;
import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';

CacheInfo? getCacheInfo(ReqCtx ctx) {
  return CacheExtension.getRootInfo(ctx)?.getNested(ctx.path);
}

class CacheInfo {
  final String? rootId;
  final DateTime? updatedAt;
  final String? hash;
  final int? maxAgeSeconds;
  final Map<String, CacheInfo> nested;
  final List<String> path;

  const CacheInfo({
    required this.path,
    this.rootId,
    this.maxAgeSeconds,
    this.updatedAt,
    this.hash,
    Map<String, CacheInfo>? nested,
  }) : nested = nested ?? const {};

  CacheInfo? getNested(List<Object> path) {
    CacheInfo? info = this;
    for (final pathItem in path) {
      if (info == null) {
        return null;
      }
      info = info.nested[pathItem.toString()];
    }
    return info;
  }

  MapEntry<Object?, CacheInfo> validate(
    Object _data,
    List<CacheEntry>? valuesToCache,
  ) {
    final isListOrMap = _data is List || _data is Map<String, Object?>;
    final payload = jsonEncode(isListOrMap ? _data : {'value': _data});
    final computedHash = sha1.convert(utf8.encode(payload)).toString();

    final Map<String, CacheInfo> computedNested = {};
    final info = CacheInfo(
      hash: computedHash,
      nested: computedNested,
      path: path,
    );

    if (valuesToCache != null) {
      valuesToCache.add(CacheEntry(
        data: _data,
        info: info,
        cachedAt: DateTime.now(),
      ));
    }

    if (computedHash == hash) {
      return MapEntry(null, info);
    }

    if (!isListOrMap) {
      return MapEntry(_data, info);
    }

    final data = _data is Map<String, Object?>
        ? {..._data}
        : Map.fromEntries(
            (_data as List).mapIndexed(
              (key, Object? value) => MapEntry(key.toString(), value),
            ),
          );

    // Set<String>? listMapsKeys = _data is List ? {} : null;
    for (final nestedE in nested.entries) {
      // final Object? innerData = data is Map
      //     ? data[nestedE.key]
      //     : (data as List)[int.parse(nestedE.key)];

      final innerData = data[nestedE.key];

      if (innerData != null) {
        final computedInner = nestedE.value.validate(innerData, valuesToCache);
        final itemValue = computedInner.key;
        data[nestedE.key] = itemValue;
        computedNested[nestedE.key] = computedInner.value;

        // if (listMapsKeys != null) {
        //   if (itemValue is Map<String, Object?>?) {
        //     if (itemValue != null) {
        //       listMapsKeys.addAll(itemValue.keys);
        //     }
        //   } else {
        //     listMapsKeys = null;
        //   }
        // }
      }
    }

    if (_data is List) {
      // if (listMapsKeys != null) {
      //   final mapOfCols =
      //       Map<String, List<Object?>>.fromEntries(listMapsKeys.map(
      //     (e) => MapEntry(e, []),
      //   ));
      //   final List<int> nullIndexes = [];
      //   int i = 0;
      //   for (final obj in data.values.cast<Map<String, Object?>?>()) {
      //     if (obj == null) {
      //       nullIndexes.add(i);
      //     } else {
      //       for (final e in mapOfCols.entries) {
      //         e.value.add(obj[e.key]);
      //       }
      //     }
      //     i += 1;
      //   }
      // }
      final listData = List.generate(
        data.length,
        (index) => data[index.toString()],
      );
      return MapEntry(listData, info);
    } else {
      return MapEntry(data, info);
    }
  }

  factory CacheInfo.fromJson(Iterable<String> path, Map<String, Object?> json) {
    final nested = json['nested'] as Map<String, Object?>?;

    return CacheInfo(
      rootId: json['rootId'] as String?,
      path: path.toList(),
      hash: json['hash'] as String?,
      updatedAt: _parseDateTime(json['updatedAt']),
      maxAgeSeconds: json['maxAgeSeconds'] as int?,
      nested: nested?.map(
        (key, value) => MapEntry(
          key,
          value == null
              ? CacheInfo(
                  path: path.followedBy([key]).toList(),
                )
              : CacheInfo.fromJson(
                  path.followedBy([key]),
                  value as Map<String, Object?>,
                ),
        ),
      ),
    );
  }

  Map<String, Object?> toJson() {
    return {
      if (rootId != null) 'rootId': rootId,
      if (hash != null) 'hash': hash,
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (maxAgeSeconds != null) 'maxAgeSeconds': maxAgeSeconds,
      if (nested.isNotEmpty) 'nested': nested,
    };
  }
}

DateTime? _parseDateTime(Object? value) {
  return value is DateTime
      ? value
      : value is String
          ? DateTime.parse(value)
          : value is int
              ? DateTime.fromMillisecondsSinceEpoch(value)
              : null;
}

// class CacheState {
//   final CacheInfo incoming;

//   CacheState(this.incoming);
// }

class CacheEntry {
  final Object data;
  final CacheInfo info;
  final DateTime cachedAt;

  const CacheEntry({
    required this.data,
    required this.info,
    required this.cachedAt,
  });
}

class CacheExtension extends GraphQLExtension {
  static final ref = ScopeRef<CacheInfo>('CacheExtension');

  final Cache<String, CacheEntry>? cache;

  CacheExtension({this.cache});

  @override
  String get mapKey => 'cacheResponse';

  static CacheInfo? getRootInfo(GlobalsHolder holder) {
    if (holder.globals.containsScoped(CacheExtension.ref)) {
      return CacheExtension.ref.get(holder);
    }
  }

  @override
  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) async {
    if (extensions != null && extensions[mapKey] is Map<String, Object?>) {
      final state = CacheInfo.fromJson(
        [],
        extensions[mapKey]! as Map<String, Object?>,
      );
      ref.setScoped(globals, state);
      final result = await next();

      if (!result.isSubscription && result.data != null) {
        final data = result.data!;
        final valuesToCache = cache != null ? <CacheEntry>[] : null;
        final computedData = state.validate(data, valuesToCache);

        if (cache != null) {
          final _rootId = state.rootId ?? '';
          for (final v in valuesToCache!) {
            cache!.set('$_rootId${v.info.path.join('.')}', v);
          }
        }

        return result.copyWith(
          data: Val(computedData.key ?? <String, Object?>{}),
          extensions: Val({
            if (result.extensions != null) ...result.extensions!,
            mapKey: computedData.value.toJson(),
          }),
        );
      }

      return result;
    }
    return next();
  }

  @override
  FutureOr<Object?> executeField(
    FutureOr<Object?> Function() next,
    ResolveObjectCtx ctx,
    GraphQLObjectField field,
    String fieldAlias,
  ) {
    if (cache != null) {
      final rootInfo = getRootInfo(ctx.globals);
      final path = ctx.path.followedBy([fieldAlias]).toList();
      final info = rootInfo?.getNested(path);
      final maxAgeSeconds = info?.maxAgeSeconds;
      if (maxAgeSeconds != null) {
        final _rootId = rootInfo!.rootId ?? '';
        final cacheKey = '$_rootId${path.join('.')}';
        final entry = cache!.get(cacheKey);
        if (entry != null) {
          final staleSecs = DateTime.now().difference(entry.cachedAt).inSeconds;
          if (staleSecs < maxAgeSeconds) {
            return entry.data;
          }
          // else {
          //   cache!.delete(cacheKey);
          // }
        }
      }
    }
    return next();
  }
}
