/// Return a GraphQL introspection query.
/// Can be used against a GraphQL server to obtain information about its schema.
String getIntrospectionQuery({
  // Whether to include descriptions in the introspection result.
  // Default: true
  bool descriptions = true,
  // Whether to include `specifiedByURL` in the introspection result.
  // Default: false
  bool specifiedByUrl = false,
  // Whether to include `isRepeatable` flag on directives.
  // Default: false
  bool directiveIsRepeatable = false,
  // Whether to include `description` field on schema.
  // Default: false
  bool schemaDescription = false,
  // Whether target GraphQL server support deprecation of input values.
  // Default: false
  bool inputValueDeprecation = false,
}) {
  final descriptionsStr = descriptions ? 'description' : '';
  final specifiedByUrlStr = specifiedByUrl ? 'specifiedByURL' : '';
  final directiveIsRepeatableStr = directiveIsRepeatable ? 'isRepeatable' : '';
  final schemaDescriptionStr = schemaDescription ? descriptionsStr : '';

  String inputDeprecation(String str) {
    return inputValueDeprecation ? str : '';
  }

  return '''
query IntrospectionQuery {
  __schema {
    $schemaDescriptionStr
    queryType { name }
    mutationType { name }
    subscriptionType { name }
    types {
      ...FullType
    }
    directives {
      name
      $descriptionsStr
      $directiveIsRepeatableStr
      locations
      args${inputDeprecation('(includeDeprecated: true)')} {
        ...InputValue
      }
    }
  }
}
fragment FullType on __Type {
  kind
  name
  $descriptionsStr
  $specifiedByUrlStr
  fields(includeDeprecated: true) {
    name
    $descriptionsStr
    args${inputDeprecation('(includeDeprecated: true)')} {
      ...InputValue
    }
    type {
      ...TypeRef
    }
    isDeprecated
    deprecationReason
  }
  inputFields${inputDeprecation('(includeDeprecated: true)')} {
    ...InputValue
  }
  interfaces {
    ...TypeRef
  }
  enumValues(includeDeprecated: true) {
    name
    $descriptionsStr
    isDeprecated
    deprecationReason
  }
  possibleTypes {
    ...TypeRef
  }
}
fragment InputValue on __InputValue {
  name
  $descriptionsStr
  type { ...TypeRef }
  defaultValue
  ${inputDeprecation('isDeprecated')}
  ${inputDeprecation('deprecationReason')}
}
fragment TypeRef on __Type {
  kind
  name
  ofType {
    kind
    name
    ofType {
      kind
      name
      ofType {
        kind
        name
        ofType {
          kind
          name
          ofType {
            kind
            name
            ofType {
              kind
              name
              ofType {
                kind
                name
              }
            }
          }
        }
      }
    }
  }
}''';
}
