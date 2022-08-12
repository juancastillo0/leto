"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[4853],{3905:(e,t,n)=>{n.d(t,{Zo:()=>s,kt:()=>m});var r=n(7294);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var c=r.createContext({}),p=function(e){var t=r.useContext(c),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},s=function(e){var t=p(e.components);return r.createElement(c.Provider,{value:t},e.children)},d={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},u=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,o=e.originalType,c=e.parentName,s=l(e,["components","mdxType","originalType","parentName"]),u=p(n),m=a,f=u["".concat(c,".").concat(m)]||u[m]||d[m]||o;return n?r.createElement(f,i(i({ref:t},s),{},{components:n})):r.createElement(f,i({ref:t},s))}));function m(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=n.length,i=new Array(o);i[0]=u;var l={};for(var c in t)hasOwnProperty.call(t,c)&&(l[c]=t[c]);l.originalType=e,l.mdxType="string"==typeof e?e:a,i[1]=l;for(var p=2;p<o;p++)i[p]=n[p];return r.createElement.apply(null,i)}return r.createElement.apply(null,n)}u.displayName="MDXCreateElement"},9589:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>i,default:()=>d,frontMatter:()=>o,metadata:()=>l,toc:()=>p});var r=n(7462),a=(n(7294),n(3905));const o={sidebar_position:1},i="Leto Generator",l={unversionedId:"leto_generator/leto-generator",id:"leto_generator/leto-generator",title:"Leto Generator",description:"Generates package:leto_schema's GraphQLSchemas from annotated Dart classes and functions. This is a code-first generator which will generate different GraphQL elements based on annotations in Dart code.",source:"@site/docs/leto_generator/leto-generator.md",sourceDirName:"leto_generator",slug:"/leto_generator/leto-generator",permalink:"/leto/docs/leto_generator/leto-generator",draft:!1,editUrl:"https://github.com/juancastillo0/leto/edit/main/leto_generator/README.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"tutorialSidebar",previous:{title:"leto_generator",permalink:"/leto/docs/category/leto_generator"},next:{title:"Table of contents",permalink:"/leto/docs/leto_generator/table-of-contents"}},c={},p=[{value:"Usage",id:"usage",level:2}],s={toc:p};function d(e){let{components:t,...n}=e;return(0,a.kt)("wrapper",(0,r.Z)({},s,n,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h1",{id:"leto-generator"},"Leto Generator"),(0,a.kt)("p",null,"Generates ",(0,a.kt)("inlineCode",{parentName:"p"},"package:leto_schema"),"'s ",(0,a.kt)("inlineCode",{parentName:"p"},"GraphQLSchema"),"s from annotated Dart classes and functions. This is a code-first generator which will generate different GraphQL elements based on annotations in Dart code."),(0,a.kt)("h2",{id:"usage"},"Usage"),(0,a.kt)("p",null,"Usage is very simple. You just need ",(0,a.kt)("inlineCode",{parentName:"p"},"@GraphQLObject()")," annotation\non any class you want to generate an object type for. And the ",(0,a.kt)("inlineCode",{parentName:"p"},"@Query()"),", ",(0,a.kt)("inlineCode",{parentName:"p"},"@Mutation()")," or ",(0,a.kt)("inlineCode",{parentName:"p"},"Subscription()"),"\nannotations for resolver functions."),(0,a.kt)("p",null,"Individual fields can have a ",(0,a.kt)("inlineCode",{parentName:"p"},"@GraphQLDocumentation()")," or ",(0,a.kt)("inlineCode",{parentName:"p"},"@GraphQLField()")," annotation, to provide information\nlike descriptions, deprecation reasons, etc."),(0,a.kt)("p",null,"There are many more annotations that you can explore in the ",(0,a.kt)("a",{parentName:"p",href:"/leto/docs/leto_generator/annotations-decorators"},"annotations section"),"."),(0,a.kt)("p",null,"Add the following dependencies to your ",(0,a.kt)("inlineCode",{parentName:"p"},"pubspec.yaml"),":"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-yaml"},"dependencies:\n  leto_schema:\ndependencies:\n  leto_generator:\n  build_runner:\n")),(0,a.kt)("p",null,"Annotate your classes, fields and functions:"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:leto_schema/leto_schema.dart';\n\npart 'file_name.g.dart';\n\n@GraphQLObject()\nclass ObjectName {\n  final String fieldName;\n\n  const ObjectName({required this.fieldName});\n}\n\n@Query()\nObjectName getObject(ReqCtx ctx, String name) {\n  return ObjectName(fieldName: name);\n}\n")),(0,a.kt)("p",null,"Run the code generator:"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-bash"},"dart run build_runner watch --delete-conflicting-outputs\n")),(0,a.kt)("p",null,"A ",(0,a.kt)("inlineCode",{parentName:"p"},"file_name.g.dart")," should be generated with the ",(0,a.kt)("inlineCode",{parentName:"p"},"ObjectName"),"'s ",(0,a.kt)("inlineCode",{parentName:"p"},"GraphQLObjectType")," and a field for\nthe ",(0,a.kt)("inlineCode",{parentName:"p"},"getObject")," query along with a ",(0,a.kt)("inlineCode",{parentName:"p"},"lib/graphql_api.schema.dart")," file with the ",(0,a.kt)("inlineCode",{parentName:"p"},"GraphQLSchema")," for your project.\nThis schema will have the ",(0,a.kt)("inlineCode",{parentName:"p"},"getObject")," resolver in the root ",(0,a.kt)("inlineCode",{parentName:"p"},"Query")," type."))}d.isMDXComponent=!0}}]);