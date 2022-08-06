import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

type FeatureItem = {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<'svg'>>;
  description: JSX.Element;
};

const FeatureList: FeatureItem[] = [
  {
    title: 'Easy to Use',
    Svg: require('@site/static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <>
        Documentation, code generation, the Dart language, multiple utilities implemented 
        and the great GraphQL Language provide a seamless developer experience.
      </>
    ),
  },
  {
    title: 'Focus on What Matters',
    Svg: require('@site/static/img/undraw_docusaurus_tree.svg').default,
    description: (
      <>
        Leto lets you focus on your server logic. Annotate your Dart code and
        generate a clear GraphQL Schema API. Validate your inputs with the valida
        package and support  Web Sockets subscriptions.
      </>
    ),
  },
  {
    title: 'Powered by Dart',
    Svg: require('@site/static/img/undraw_docusaurus_react.svg').default,
    description: (
      <>
        Develop and release to production using the awesome Dart language.
        Hot reload, sound static typing, great community. Share the knowledge from
        your Flutter or Dart Web clients.
      </>
    ),
  },
  {
    title: 'Build Reliable Servers',
    Svg: require('@site/static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <>
        Great test coverage, and error handling, strong static analysis coupled
        with GraphQL's Type System. Using Dart's sound static typing, linter and compiler.
      </>
    ),
  },
  {
    title: 'Extensible',
    Svg: require('@site/static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <>
        Multiple modules for execution (leto), schema creation (leto_schema) and code generation (leto_generator).
        With support for extensions, directives, attachments and more.
      </>
    ),
  },
  {
    title: 'Community-Based',
    Svg: require('@site/static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <>
        Fully open source integrated with json_serializable, freezed, gql, valida,
        shelf and examples with database integration, Dart clients, authentication
        libraries.
      </>
    ),
  },
];

function Feature({title, Svg, description}: FeatureItem) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures(): JSX.Element {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
