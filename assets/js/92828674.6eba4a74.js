"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[3921],{3905:(e,t,n)=>{n.d(t,{Zo:()=>d,kt:()=>m});var a=n(7294);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,a,r=function(e,t){if(null==e)return{};var n,a,r={},o=Object.keys(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var s=a.createContext({}),c=function(e){var t=a.useContext(s),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},d=function(e){var t=c(e.components);return a.createElement(s.Provider,{value:t},e.children)},u={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},p=a.forwardRef((function(e,t){var n=e.components,r=e.mdxType,o=e.originalType,s=e.parentName,d=l(e,["components","mdxType","originalType","parentName"]),p=c(n),m=r,h=p["".concat(s,".").concat(m)]||p[m]||u[m]||o;return n?a.createElement(h,i(i({ref:t},d),{},{components:n})):a.createElement(h,i({ref:t},d))}));function m(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var o=n.length,i=new Array(o);i[0]=p;var l={};for(var s in t)hasOwnProperty.call(t,s)&&(l[s]=t[s]);l.originalType=e,l.mdxType="string"==typeof e?e:r,i[1]=l;for(var c=2;c<o;c++)i[c]=n[c];return a.createElement.apply(null,i)}return a.createElement.apply(null,n)}p.displayName="MDXCreateElement"},752:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>s,contentTitle:()=>i,default:()=>u,frontMatter:()=>o,metadata:()=>l,toc:()=>c});var a=n(7462),r=(n(7294),n(3905));const o={sidebar_position:4},i="Schema and Document Validation Rules",l={unversionedId:"leto_schema/schema-and-document-validation-rules",id:"leto_schema/schema-and-document-validation-rules",title:"Schema and Document Validation Rules",description:"GraphQL schemas and documents can be validated for potential errors, misconfigurations, bad practices or perhaps",source:"@site/docs/leto_schema/schema-and-document-validation-rules.md",sourceDirName:"leto_schema",slug:"/leto_schema/schema-and-document-validation-rules",permalink:"/leto/docs/leto_schema/schema-and-document-validation-rules",draft:!1,editUrl:"https://github.com/juancastillo0/leto/edit/main/leto_schema/README.md",tags:[],version:"current",sidebarPosition:4,frontMatter:{sidebar_position:4},sidebar:"tutorialSidebar",previous:{title:"GraphQL Types",permalink:"/leto/docs/leto_schema/graphql-types"},next:{title:"GraphQLException and GraphQLError",permalink:"/leto/docs/leto_schema/graphqlexception-and-graphqlerror"}},s={},c=[{value:"<code>validateDocument(GraphQLSchema, gql.DocumentNode)</code>",id:"validatedocumentgraphqlschema-gqldocumentnode",level:2},{value:"<code>validateSDL(gql.DocumentNode, GraphQLSchema?)</code>",id:"validatesdlgqldocumentnode-graphqlschema",level:2},{value:"Custom Validations",id:"custom-validations",level:2}],d={toc:c};function u(e){let{components:t,...n}=e;return(0,r.kt)("wrapper",(0,a.Z)({},d,n,{components:t,mdxType:"MDXLayout"}),(0,r.kt)("h1",{id:"schema-and-document-validation-rules"},"Schema and Document Validation Rules"),(0,r.kt)("p",null,"GraphQL schemas and documents can be validated for potential errors, misconfigurations, bad practices or perhaps\nrestrictions, such as restricting the complexity (how nested and how many fields) of a query.\nWe perform all the document and schema validations in the ",(0,r.kt)("a",{parentName:"p",href:"https://spec.graphql.org/draft/#sec-Validation"},"specification"),". Most of the code was ported from ",(0,r.kt)("a",{parentName:"p",href:"https://github.com/graphql/graphql-js"},"graphql-js"),"."),(0,r.kt)("p",null,"You can find the implementation for all the rules in the ",(0,r.kt)("a",{parentName:"p",href:"https://github.com/juancastillo0/leto/tree/main/leto_schema/lib/src/validate/rules/"},(0,r.kt)("inlineCode",{parentName:"a"},"lib/src/validate/rules"))," directory."),(0,r.kt)("p",null,"We also provide a ",(0,r.kt)("a",{parentName:"p",href:"/leto/docs/main/validation#query-complexity"},"QueryComplexity")," validation rule."),(0,r.kt)("p",null,"You can use two functions to validate GraphQL documents, both return a ",(0,r.kt)("inlineCode",{parentName:"p"},"List<GraphQLError>"),":"),(0,r.kt)("h2",{id:"validatedocumentgraphqlschema-gqldocumentnode"},(0,r.kt)("inlineCode",{parentName:"h2"},"validateDocument(GraphQLSchema, gql.DocumentNode)")),(0,r.kt)("p",null,"You can specify multiple validation rules. The default is ",(0,r.kt)("a",{parentName:"p",href:"https://github.com/juancastillo0/leto/tree/main/leto_schema/lib/src/validate/validate.dart"},(0,r.kt)("inlineCode",{parentName:"a"},"specifiedRules")),"."),(0,r.kt)("h2",{id:"validatesdlgqldocumentnode-graphqlschema"},(0,r.kt)("inlineCode",{parentName:"h2"},"validateSDL(gql.DocumentNode, GraphQLSchema?)")),(0,r.kt)("p",null,"If a ",(0,r.kt)("inlineCode",{parentName:"p"},"GraphQLSchema")," is passed, it is assumed that the document SDL is an extension over the given schema."),(0,r.kt)("p",null,"You can specify multiple validation rules. The default is ",(0,r.kt)("inlineCode",{parentName:"p"},"specifiedSDLRules"),"(../leto_schema/lib/src/validate/validate.dart)."),(0,r.kt)("h2",{id:"custom-validations"},"Custom Validations"),(0,r.kt)("p",null,"You can provide custom validations, they are a function that receives a ",(0,r.kt)("inlineCode",{parentName:"p"},"ValidationCtx")," and returns a visitor that reports errors thought the context."),(0,r.kt)("p",null,"For example, the following validation rule checks that argument names are unique:"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"const _uniqueArgumentNamesSpec = ErrorSpec(\n  spec: 'https://spec.graphql.org/draft/#sec-Argument-Names',\n  code: 'uniqueArgumentNames',\n);\n\n/// Unique argument names\n///\n/// A GraphQL field or directive is only valid if all supplied arguments are\n/// uniquely named.\n///\n/// See https://spec.graphql.org/draft/#sec-Argument-Names\nVisitor uniqueArgumentNamesRule(\n  SDLValidationCtx context, // ASTValidationContext,\n) {\n  final visitor = TypedVisitor();\n\n  VisitBehavior? checkArgUniqueness(List<ArgumentNode> argumentNodes) {\n    final seenArgs = argumentNodes.groupListsBy((arg) => arg.name.value);\n\n    for (final entry in seenArgs.entries) {\n      if (entry.value.length > 1) {\n        context.reportError(\n          GraphQLError(\n            'There can be only one argument named \"${entry.key}\".',\n            locations: List.of(entry.value\n                .map((node) => node.name.span!.start)\n                .map((e) => GraphQLErrorLocation.fromSourceLocation(e))),\n            extensions: _uniqueArgumentNamesSpec.extensions(),\n          ),\n        );\n      }\n    }\n  }\n\n  visitor.add<FieldNode>((node) => checkArgUniqueness(node.arguments));\n  visitor.add<DirectiveNode>((node) => checkArgUniqueness(node.arguments));\n  return visitor;\n}\n")))}u.isMDXComponent=!0}}]);