"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[7559],{3905:(e,t,a)=>{a.d(t,{Zo:()=>p,kt:()=>u});var r=a(7294);function n(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function i(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,r)}return a}function o(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?i(Object(a),!0).forEach((function(t){n(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):i(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function s(e,t){if(null==e)return{};var a,r,n=function(e,t){if(null==e)return{};var a,r,n={},i=Object.keys(e);for(r=0;r<i.length;r++)a=i[r],t.indexOf(a)>=0||(n[a]=e[a]);return n}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(r=0;r<i.length;r++)a=i[r],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(n[a]=e[a])}return n}var c=r.createContext({}),l=function(e){var t=r.useContext(c),a=t;return e&&(a="function"==typeof e?e(t):o(o({},t),e)),a},p=function(e){var t=l(e.components);return r.createElement(c.Provider,{value:t},e.children)},h={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},d=r.forwardRef((function(e,t){var a=e.components,n=e.mdxType,i=e.originalType,c=e.parentName,p=s(e,["components","mdxType","originalType","parentName"]),d=l(a),u=n,m=d["".concat(c,".").concat(u)]||d[u]||h[u]||i;return a?r.createElement(m,o(o({ref:t},p),{},{components:a})):r.createElement(m,o({ref:t},p))}));function u(e,t){var a=arguments,n=t&&t.mdxType;if("string"==typeof e||n){var i=a.length,o=new Array(i);o[0]=d;var s={};for(var c in t)hasOwnProperty.call(t,c)&&(s[c]=t[c]);s.originalType=e,s.mdxType="string"==typeof e?e:n,o[1]=s;for(var l=2;l<i;l++)o[l]=a[l];return r.createElement.apply(null,o)}return r.createElement.apply(null,a)}d.displayName="MDXCreateElement"},9069:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>c,contentTitle:()=>o,default:()=>h,frontMatter:()=>i,metadata:()=>s,toc:()=>l});var r=a(7462),n=(a(7294),a(3905));const i={sidebar_position:2},o="GraphQL Schema",s={unversionedId:"leto_schema/graphql-schema",id:"leto_schema/graphql-schema",title:"GraphQL Schema",description:"Each GraphQLSchema has a required GraphQLObjectType as the root query type as well as optional GraphQLObjectTypes for the mutation and subscription roots. You can provide a list of directive (GraphQLDirectives) definitions that can be used within the schema or by documents and . The directives will be extended if any of the types or fields have a ToDirectiveValue attachment. You can provide an optional description String as documentation and a SerdeCtx used for deserialization of input types. The astNode (SchemaDefinitionNode) will be set when the schema is built using buildSchema.",source:"@site/docs/leto_schema/graphql-schema.md",sourceDirName:"leto_schema",slug:"/leto_schema/graphql-schema",permalink:"/leto/docs/leto_schema/graphql-schema",draft:!1,editUrl:"https://github.com/juancastillo0/leto/edit/main/leto_schema/README.md",tags:[],version:"current",sidebarPosition:2,frontMatter:{sidebar_position:2},sidebar:"tutorialSidebar",previous:{title:"Leto Schema",permalink:"/leto/docs/leto_schema/leto-schema"},next:{title:"GraphQL Types",permalink:"/leto/docs/leto_schema/graphql-types"}},c={},l=[{value:"Resolvers",id:"resolvers",level:2}],p={toc:l};function h(e){let{components:t,...a}=e;return(0,n.kt)("wrapper",(0,r.Z)({},p,a,{components:t,mdxType:"MDXLayout"}),(0,n.kt)("h1",{id:"graphql-schema"},"GraphQL Schema"),(0,n.kt)("p",null,"Each ",(0,n.kt)("inlineCode",{parentName:"p"},"GraphQLSchema")," has a required ",(0,n.kt)("inlineCode",{parentName:"p"},"GraphQLObjectType")," as the root query type as well as optional ",(0,n.kt)("inlineCode",{parentName:"p"},"GraphQLObjectType"),"s for the mutation and subscription roots. You can provide a list of directive (",(0,n.kt)("inlineCode",{parentName:"p"},"GraphQLDirectives"),") definitions that can be used within the schema or by documents and . The directives will be extended if any of the types or fields have a ",(0,n.kt)("a",{parentName:"p",href:"/leto/docs/main/attachments#todirectivevalue"},(0,n.kt)("inlineCode",{parentName:"a"},"ToDirectiveValue"))," attachment. You can provide an optional ",(0,n.kt)("inlineCode",{parentName:"p"},"description")," ",(0,n.kt)("inlineCode",{parentName:"p"},"String")," as documentation and a ",(0,n.kt)("a",{parentName:"p",href:"#serialization-and-serdectx"},(0,n.kt)("inlineCode",{parentName:"a"},"SerdeCtx"))," used for deserialization of input types. The ",(0,n.kt)("inlineCode",{parentName:"p"},"astNode")," (",(0,n.kt)("inlineCode",{parentName:"p"},"SchemaDefinitionNode"),") will be set when the schema is built using ",(0,n.kt)("a",{parentName:"p",href:"/leto/docs/leto_schema/utilities#buildschema"},(0,n.kt)("inlineCode",{parentName:"a"},"buildSchema")),"."),(0,n.kt)("p",null,"To validate the schema definition, following ",(0,n.kt)("a",{parentName:"p",href:"https://spec.graphql.org/draft/#sec-Type-System"},"the specification"),",\nyou can use the ",(0,n.kt)("inlineCode",{parentName:"p"},"validateSchema(GraphQLSchema)")," function which returns the ",(0,n.kt)("inlineCode",{parentName:"p"},"List<GraphQLError>")," found during validation."),(0,n.kt)("h2",{id:"resolvers"},"Resolvers"),(0,n.kt)("p",null,"Each field in an object type can provide a ",(0,n.kt)("inlineCode",{parentName:"p"},"resolve")," callback to return the value when a GraphQL operation is executed over the schema."),(0,n.kt)("pre",null,(0,n.kt)("code",{parentName:"pre",className:"language-dart"},"final nameField = field(\n  'name',\n  graphQLString,\n  resolve: (Object parentObject, Ctx ctx) => 'Example Name',\n  // or pass the subscribe parameter if it is a subscription.\n  // The return type should be a Stream\n)\n")),(0,n.kt)("p",null,"For a more thorough discussion about resolvers please see the resolvers section in the ",(0,n.kt)("a",{parentName:"p",href:"/leto/docs/main/resolvers"},"main Documentation"),"."))}h.isMDXComponent=!0}}]);