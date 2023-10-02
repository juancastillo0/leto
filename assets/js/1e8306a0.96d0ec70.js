"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[879],{3905:(e,t,a)=>{a.d(t,{Zo:()=>m,kt:()=>u});var l=a(7294);function n(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function r(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var l=Object.getOwnPropertySymbols(e);t&&(l=l.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,l)}return a}function o(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?r(Object(a),!0).forEach((function(t){n(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):r(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function i(e,t){if(null==e)return{};var a,l,n=function(e,t){if(null==e)return{};var a,l,n={},r=Object.keys(e);for(l=0;l<r.length;l++)a=r[l],t.indexOf(a)>=0||(n[a]=e[a]);return n}(e,t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(l=0;l<r.length;l++)a=r[l],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(n[a]=e[a])}return n}var p=l.createContext({}),s=function(e){var t=l.useContext(p),a=t;return e&&(a="function"==typeof e?e(t):o(o({},t),e)),a},m=function(e){var t=s(e.components);return l.createElement(p.Provider,{value:t},e.children)},c={inlineCode:"code",wrapper:function(e){var t=e.children;return l.createElement(l.Fragment,{},t)}},h=l.forwardRef((function(e,t){var a=e.components,n=e.mdxType,r=e.originalType,p=e.parentName,m=i(e,["components","mdxType","originalType","parentName"]),h=s(a),u=n,d=h["".concat(p,".").concat(u)]||h[u]||c[u]||r;return a?l.createElement(d,o(o({ref:t},m),{},{components:a})):l.createElement(d,o({ref:t},m))}));function u(e,t){var a=arguments,n=t&&t.mdxType;if("string"==typeof e||n){var r=a.length,o=new Array(r);o[0]=h;var i={};for(var p in t)hasOwnProperty.call(t,p)&&(i[p]=t[p]);i.originalType=e,i.mdxType="string"==typeof e?e:n,o[1]=i;for(var s=2;s<r;s++)o[s]=a[s];return l.createElement.apply(null,o)}return l.createElement.apply(null,a)}h.displayName="MDXCreateElement"},7954:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>p,contentTitle:()=>o,default:()=>c,frontMatter:()=>r,metadata:()=>i,toc:()=>s});var l=a(7462),n=(a(7294),a(3905));const r={sidebar_position:1},o="Leto Schema",i={unversionedId:"leto_schema/leto-schema",id:"leto_schema/leto-schema",title:"Leto Schema",description:"An implementation of GraphQL's type system in Dart. Supports any platform where Dart runs.",source:"@site/docs/leto_schema/leto-schema.md",sourceDirName:"leto_schema",slug:"/leto_schema/leto-schema",permalink:"/leto/docs/leto_schema/leto-schema",draft:!1,editUrl:"https://github.com/juancastillo0/leto/edit/main/leto_schema/README.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"tutorialSidebar",previous:{title:"leto_schema",permalink:"/leto/docs/category/leto_schema"},next:{title:"GraphQL Schema",permalink:"/leto/docs/leto_schema/graphql-schema"}},p={},s=[{value:"Usage",id:"usage",level:2},{value:"Table of Contents",id:"table-of-contents",level:2}],m={toc:s};function c(e){let{components:t,...a}=e;return(0,n.kt)("wrapper",(0,l.Z)({},m,a,{components:t,mdxType:"MDXLayout"}),(0,n.kt)("h1",{id:"leto-schema"},"Leto Schema"),(0,n.kt)("p",null,"An implementation of GraphQL's type system in Dart. Supports any platform where Dart runs.\nThe decisions made in the design of this library were done to make the experience\nas similar to the JavaScript reference implementation as possible, and to also\ncorrectly implement the official specification."),(0,n.kt)("p",null,"Contains functionality to build ",(0,n.kt)("em",{parentName:"p"},"all")," GraphQL types:"),(0,n.kt)("ul",null,(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"String")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"Int")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"Float")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"Boolean")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"GraphQLObjectType")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"GraphQLUnionType")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"GraphQLEnumType")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"GraphQLInputObjectType")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"GraphQLListType")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("inlineCode",{parentName:"li"},"GraphQLNonNullType"))),(0,n.kt)("p",null,"Of course, for a full description of GraphQL's type system, see the official specification:\n",(0,n.kt)("a",{parentName:"p",href:"https://spec.graphql.org/draft/#sec-Type-System"},"https://spec.graphql.org/draft/#sec-Type-System")),(0,n.kt)("p",null,"Mostly analogous to ",(0,n.kt)("inlineCode",{parentName:"p"},"graphql-js"),"; many names are verbatim:\n",(0,n.kt)("a",{parentName:"p",href:"https://graphql.org/graphql-js/type/"},"https://graphql.org/graphql-js/type/")),(0,n.kt)("h2",{id:"usage"},"Usage"),(0,n.kt)("p",null,"It's easy to define a schema with the ",(0,n.kt)("a",{parentName:"p",href:"/leto/docs/leto_schema/graphql-types#helpers-and-extensions"},"helper functions"),":"),(0,n.kt)("pre",null,(0,n.kt)("code",{parentName:"pre",className:"language-dart"},"final todoSchema = GraphQLSchema(\n  query: objectType(\n    'Todo',\n    fields: [\n      field('text', graphQLString.nonNull()),\n      field('created_at', graphQLDate),\n    ],\n  ),\n);\n")),(0,n.kt)("p",null,"All GraphQL types are generic, in order to leverage Dart's strong typing support."),(0,n.kt)("h2",{id:"table-of-contents"},"Table of Contents"),(0,n.kt)("ul",null,(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/leto-schema"},"Leto Schema"),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/leto-schema#usage"},"Usage")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/leto-schema#table-of-contents"},"Table of Contents")))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-schema"},"GraphQL Schema"),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-schema#resolvers"},"Resolvers")))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types"},"GraphQL Types"),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#scalar-types"},"Scalar types"),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#additional-scalar-types"},"Additional scalar types")))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#composed-types"},"Composed Types")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#helpers-and-extensions"},"Helpers and Extensions"),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#methods-on-graphqltype"},"Methods on ",(0,n.kt)("inlineCode",{parentName:"a"},"GraphQLType"))))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#serialization-and-serdectx"},"Serialization and ",(0,n.kt)("inlineCode",{parentName:"a"},"SerdeCtx")),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#serdectx"},(0,n.kt)("inlineCode",{parentName:"a"},"SerdeCtx"))))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#validation"},"Validation")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#non-nullable-types"},"Non-Nullable Types")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#list-types"},"List Types"),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphql-types#input-values-and-parameters"},"Input values and parameters")))))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/schema-and-document-validation-rules"},"Schema and Document Validation Rules"),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/schema-and-document-validation-rules#validatedocumentgraphqlschema-gqldocumentnode"},(0,n.kt)("inlineCode",{parentName:"a"},"validateDocument(GraphQLSchema, gql.DocumentNode)"))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/schema-and-document-validation-rules#validatesdlgqldocumentnode-graphqlschema"},(0,n.kt)("inlineCode",{parentName:"a"},"validateSDL(gql.DocumentNode, GraphQLSchema?)"))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/schema-and-document-validation-rules#custom-validations"},"Custom Validations")))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/graphqlexception-and-graphqlerror"},"GraphQLException and GraphQLError")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/ctx-and-scopedmap"},"Ctx and ScopedMap")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/lookahead"},"LookAhead")),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/utilities"},"Utilities"),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/utilities#buildschema"},(0,n.kt)("inlineCode",{parentName:"a"},"buildSchema"))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/utilities#printschema"},(0,n.kt)("inlineCode",{parentName:"a"},"printSchema"))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/utilities#extendschema"},(0,n.kt)("inlineCode",{parentName:"a"},"extendSchema"))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/utilities#introspectionquery"},(0,n.kt)("inlineCode",{parentName:"a"},"introspectionQuery"))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/utilities#mergeschemas"},(0,n.kt)("inlineCode",{parentName:"a"},"mergeSchemas"))),(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("a",{parentName:"li",href:"/leto/docs/leto_schema/utilities#schemafromjson"},(0,n.kt)("inlineCode",{parentName:"a"},"schemaFromJson")))))))}c.isMDXComponent=!0}}]);