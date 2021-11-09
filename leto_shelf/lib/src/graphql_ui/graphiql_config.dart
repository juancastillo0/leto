import 'package:freezed_annotation/freezed_annotation.dart';
part 'graphiql_config.g.dart';

@JsonSerializable(includeIfNull: false)
class GraphiqlConfig {
  /// Required. a function which accepts GraphQL-HTTP parameters and
  /// returns a Promise, Observable or AsyncIterable which resolves
  /// to the GraphQL parsed JSON response.
  /// final Function fetcher;
  /// a GraphQLSchema instance or null if one is not to be used.
  /// If undefined is provided, GraphiQL will send an introspection query
  /// using the fetcher to produce a schema.
  final Map<String, Object?>? schema;

  /// (GraphQL) initial displayed query, if undefined is provided,
  /// the stored query or defaultQuery will be used. You can also set this
  ///
  /// value at runtime to override the current operation editor state.
  final String? query;

  /// []An array of validation rules that will be used for validating the
  /// GraphQL operations. If undefined is provided, the default rules
  /// (exported as specifiedRules from graphql) will be used.
  /// final List<ValidationRule> validationRules;
  /// (JSON) initial displayed query variables, if undefined is provided,
  /// the stored variables will be used.
  final String? variables;

  /// initial displayed request headers. if not defined, it will default
  /// to the stored headers if shouldPersistHeaders is enabled.
  final String? headers;

  /// TODO:FragmentDefinitionNode[] provide fragments external to the operation
  /// for completion, validation, and for selective use when executing operations.
  final String? externalFragments;

  /// an optional name of which GraphQL operation should be executed.
  final String? operationName;

  /// (JSON) an optional JSON String to use as the initial displayed response.
  /// If not provided, no response will be initially shown. You might
  ///provide this if illustrating the result of the initial query.
  final String? response;

  /// Default: window.localStorage. an interface that matches window.localStorage
  /// signature that GraphiQL will use to persist state.
  /// final Storage storage;
  /// Default: graphiql help text. Provides default query if
  /// no user state is present.
  final String? defaultQuery;

  /// sets whether or not to show the variables pane on startup.
  /// overridden by user state (deprecated in favor of defaultSecondaryEditorOpen)
  @Deprecated('use defaultSecondaryEditorOpen')
  final bool? defaultVariableEditorOpen;

  /// sets whether or not to show the variables/headers pane on startup.
  /// If not defined, it will be based off whether or not variables and/or headers are present.
  final bool? defaultSecondaryEditorOpen;

  /// Default: defaultGetDefaultFieldNames. provides default
  /// field values for incomplete queries
  /// final Function getDefaultFieldNames;
  /// Default: graphiql. names a CodeMirror theme to be applied
  /// to the QueryEditor, ResultViewer, and Variables panes.
  /// See below for full usage.
  final String? editorTheme;

  /// when true will make the QueryEditor and Variables panes readOnly.
  final bool? readOnly;

  /// when true will ensure the DocExplorer is open by default when the user
  /// first renders the component. Overridden by user's toggle state
  final bool? docExplorerOpen;

  /// Default: false. enables the header editor when true.
  final bool? headerEditorEnabled;

  /// Default: false. o persist headers to storage when true
  final bool? shouldPersistHeaders;

  /// React.Component[]	pass additional toolbar
  /// react components inside a fragment
  /// final additionalContent toolbar;
  /// called when the Query editor changes. The argument to the
  /// function will be the query string.
  /// final Function onEditQuery;
  /// called when the Query variable editor changes. The argument to the
  /// function will be the variables string.
  /// final Function onEditVariables;
  /// called when the request headers editor changes. The argument to the
  /// function will be the headers string.
  /// final Function onEditHeaders;
  /// called when the operation name to be executed changes.
  /// final Function onEditOperationName;
  /// called when the docs will be toggled. The argument to the function will
  /// be a boolean whether the docs are now open or closed.
  /// final Function onToggleDocs;

  /// Default: 20. allows you to increase the number of queries
  /// in the history component
  final int? maxHistoryLength;

  const GraphiqlConfig({
    this.schema,
    this.query,
    this.variables,
    this.headers,
    this.externalFragments,
    this.operationName,
    this.response,
    this.defaultQuery,
    this.defaultVariableEditorOpen,
    this.defaultSecondaryEditorOpen,
    this.editorTheme,
    this.readOnly,
    this.docExplorerOpen,
    this.headerEditorEnabled,
    this.shouldPersistHeaders,
    this.maxHistoryLength,
  });

  factory GraphiqlConfig.fromJson(Map<String, Object?> json) =>
      _$GraphiqlConfigFromJson(json);
  Map<String, Object?> toJson() => _$GraphiqlConfigToJson(this);

  @override
  String toString() {
    return 'GraphiqlConfig${toJson()}';
  }
}

@JsonSerializable(includeIfNull: false)
class GraphiqlFetcher {
  /// url for HTTP(S) requests. required!
  final String url;

  /// url for websocket subscription requests
  final String? subscriptionUrl;

  /**
   * `wsClient` implementation that matches `ws-graphql` signature,
   * whether via `createClient()` itself or another client.
   */
  // final Client wsClient;

  /**
   * `legacyClient` implementation that matches `subscriptions-transport-ws`
   *  signature,
   *  whether via `new SubcriptionsClient()` itself or another 
   *  client with a similar signature.
   */
  // final SubscriptionClient legacyClient;

  /// Headers you can provide statically.
  ///
  /// If you enable the headers editor and the user provides
  /// A header you set statically here, it will be overriden by their value.
  final Map<String, String>? headers;

  /**
   * Websockets connection params used when you provide subscriptionUrl. 
   * graphql-ws `ClientOptions.connectionParams`
   */
  // final ClientOptions['connectionParams'] wsConnectionParams;

  /// You can disable the usage of the `fetch-multipart-graphql` library
  /// entirely, defaulting to a simple fetch POST implementation.
  final bool? enableIncrementalDelivery;

  const GraphiqlFetcher({
    required this.url,
    this.subscriptionUrl,
    this.headers,
    this.enableIncrementalDelivery,
  });
  /**
   * The fetch implementation, in case the user needs to override this for SSR
   * or other purposes. this does not override the `fetch-multipart-graphql`
   * default fetch behavior yet.
   */
  // final typeof fetch fetch;
  /// An optional custom fetcher specifically for your schema. For most cases
  /// the `url` and `headers` property should have you covered.
  // final Fetcher schemaFetcher;

  factory GraphiqlFetcher.fromJson(Map<String, Object?> json) =>
      _$GraphiqlFetcherFromJson(json);
  Map<String, Object?> toJson() => _$GraphiqlFetcherToJson(this);

  @override
  String toString() {
    return 'GraphiqlFetcher${toJson()}';
  }
}
