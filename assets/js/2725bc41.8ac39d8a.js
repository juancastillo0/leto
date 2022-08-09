"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[8264],{3905:(e,t,a)=>{a.d(t,{Zo:()=>c,kt:()=>m});var n=a(7294);function r(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function o(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,n)}return a}function l(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?o(Object(a),!0).forEach((function(t){r(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):o(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function i(e,t){if(null==e)return{};var a,n,r=function(e,t){if(null==e)return{};var a,n,r={},o=Object.keys(e);for(n=0;n<o.length;n++)a=o[n],t.indexOf(a)>=0||(r[a]=e[a]);return r}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(n=0;n<o.length;n++)a=o[n],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(r[a]=e[a])}return r}var p=n.createContext({}),s=function(e){var t=n.useContext(p),a=t;return e&&(a="function"==typeof e?e(t):l(l({},t),e)),a},c=function(e){var t=s(e.components);return n.createElement(p.Provider,{value:t},e.children)},u={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},d=n.forwardRef((function(e,t){var a=e.components,r=e.mdxType,o=e.originalType,p=e.parentName,c=i(e,["components","mdxType","originalType","parentName"]),d=s(a),m=r,h=d["".concat(p,".").concat(m)]||d[m]||u[m]||o;return a?n.createElement(h,l(l({ref:t},c),{},{components:a})):n.createElement(h,l({ref:t},c))}));function m(e,t){var a=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var o=a.length,l=new Array(o);l[0]=d;var i={};for(var p in t)hasOwnProperty.call(t,p)&&(i[p]=t[p]);i.originalType=e,i.mdxType="string"==typeof e?e:r,l[1]=i;for(var s=2;s<o;s++)l[s]=a[s];return n.createElement.apply(null,l)}return n.createElement.apply(null,a)}d.displayName="MDXCreateElement"},1977:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>p,contentTitle:()=>l,default:()=>u,frontMatter:()=>o,metadata:()=>i,toc:()=>s});var n=a(7462),r=(a(7294),a(3905));const o={sidebar_position:1},l="Leto",i={unversionedId:"leto/leto",id:"leto/leto",title:"Leto",description:"Base package for implementing GraphQL servers executors. The main entrypoint is the GraphQL.parseAndExecute method which parses a GraphQL document and executes it with the configured GraphQLSchema from package:leto_schema.",source:"@site/docs/leto/leto.md",sourceDirName:"leto",slug:"/leto/",permalink:"/leto/docs/leto/",draft:!1,editUrl:"https://github.com/juancastillo0/leto/edit/main/leto/README.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"tutorialSidebar",previous:{title:"leto",permalink:"/leto/docs/category/leto"},next:{title:"GraphQL Executor",permalink:"/leto/docs/leto/graphql-executor"}},p={},s=[{value:"Ad-hoc Usage",id:"ad-hoc-usage",level:2},{value:"Table of Contents",id:"table-of-contents",level:2}],c={toc:s};function u(e){let{components:t,...a}=e;return(0,r.kt)("wrapper",(0,n.Z)({},c,a,{components:t,mdxType:"MDXLayout"}),(0,r.kt)("h1",{id:"leto"},"Leto"),(0,r.kt)("p",null,"Base package for implementing GraphQL servers executors. The main entrypoint is the ",(0,r.kt)("inlineCode",{parentName:"p"},"GraphQL.parseAndExecute")," method which parses a GraphQL document and executes it with the configured ",(0,r.kt)("inlineCode",{parentName:"p"},"GraphQLSchema")," from ",(0,r.kt)("inlineCode",{parentName:"p"},"package:leto_schema"),"."),(0,r.kt)("p",null,(0,r.kt)("inlineCode",{parentName:"p"},"package:leto")," does not require any specific framework, and thus can be used in any Dart project."),(0,r.kt)("h2",{id:"ad-hoc-usage"},"Ad-hoc Usage"),(0,r.kt)("p",null,"The actual querying functionality is handled by the\n",(0,r.kt)("inlineCode",{parentName:"p"},"GraphQL")," class, which takes a schema (from ",(0,r.kt)("inlineCode",{parentName:"p"},"package:leto_schema"),").\nIn most cases, you'll want to call ",(0,r.kt)("inlineCode",{parentName:"p"},"parseAndExecute"),"\non some string of GraphQL text. It returns a ",(0,r.kt)("inlineCode",{parentName:"p"},"GraphQLResult")," with either a\n",(0,r.kt)("inlineCode",{parentName:"p"},"Map<String, dynamic>")," or a ",(0,r.kt)("inlineCode",{parentName:"p"},"Stream<GraphQLResult>")," for subscriptions:"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"try {\n    final GraphQLResult result = await graphQL.parseAndExecute(responseText);\n    final data = result.data;\n    if (data is Stream<GraphQLResult>) {\n        // Handle a subscription somehow...\n    } else if (data is Map<String, Object?>) {\n        response.send({'data': data});\n    } else {\n        // Handle errors\n        final bool didExecute = result.didExecute;\n        final List<GraphQLError> errors = result.errors;\n    }\n} catch (e) {\n    // Not usually necessary, only when a specify extension throws.\n    response.send(e.toJson());\n}\n")),(0,r.kt)("p",null,"Consult the API reference for more:\n",(0,r.kt)("a",{parentName:"p",href:"https://pub.dev/documentation/leto/latest/leto/GraphQL/parseAndExecute.html"},"https://pub.dev/documentation/leto/latest/leto/GraphQL/parseAndExecute.html")),(0,r.kt)("p",null,"If you're looking for functionality like ",(0,r.kt)("inlineCode",{parentName:"p"},"graphQLHttp")," in ",(0,r.kt)("inlineCode",{parentName:"p"},"graphql-js"),", that is not included in this package, because\nit is typically specific to the framework/platform you are using. The ",(0,r.kt)("inlineCode",{parentName:"p"},"graphQLHttp")," implementation in ",(0,r.kt)("a",{parentName:"p",href:"https://github.com/juancastillo0/leto/tree/main/leto_shelf"},(0,r.kt)("inlineCode",{parentName:"a"},"package:leto_shelf"))," is a good example."),(0,r.kt)("h2",{id:"table-of-contents"},"Table of Contents"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/"},"Leto"),(0,r.kt)("ul",{parentName:"li"},(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/#ad-hoc-usage"},"Ad-hoc Usage")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/#table-of-contents"},"Table of Contents")))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/graphql-executor"},"GraphQL Executor"),(0,r.kt)("ul",{parentName:"li"},(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/graphql-executor#graphqlconfig"},(0,r.kt)("inlineCode",{parentName:"a"},"GraphQLConfig"))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/graphql-executor#graphqlparseandexecute"},(0,r.kt)("inlineCode",{parentName:"a"},"GraphQL.parseAndExecute")),(0,r.kt)("ul",{parentName:"li"},(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/graphql-executor#graphql-request-arguments"},"GraphQL Request Arguments")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/graphql-executor#scopedoverride-list"},(0,r.kt)("inlineCode",{parentName:"a"},"ScopedOverride")," List")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/graphql-executor#invalidoperationtype"},(0,r.kt)("inlineCode",{parentName:"a"},"InvalidOperationType"))))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/graphql-executor#introspection"},"Introspection")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/graphql-executor#extensions"},"Extensions")))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/dataloader"},"DataLoader")),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/subscriptions-and-websockets"},"Subscriptions and WebSockets"),(0,r.kt)("ul",{parentName:"li"},(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("a",{parentName:"li",href:"/leto/docs/leto/subscriptions-and-websockets#websocket-implementation"},"WebSocket implementation"))))))}u.isMDXComponent=!0}}]);