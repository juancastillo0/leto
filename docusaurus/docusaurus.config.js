// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require("prism-react-renderer/themes/github");
const darkCodeTheme = require("prism-react-renderer/themes/dracula");

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "Leto GraphQL Dart Libraries",
  tagline: "Documentation for Leto GraphQL Dart server libraries",
  url: "https://github.com",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/leto-icon-transparent.png",

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: "juancastillo0", // Usually your GitHub org/user name.
  projectName: "leto", // Usually your repo name.

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          showLastUpdateTime: true,
          showLastUpdateAuthor: true,
          editUrl: ({ docPath }) =>
            `https://github.com/juancastillo0/leto/edit/main/${
              docPath.startsWith("main/") ? "" : docPath.split("/")[0] + "/"
            }README.md`,
        },
        blog: {
          showReadingTime: true,
          editUrl: () => "https://github.com/juancastillo0/leto",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      navbar: {
        title: "Leto GraphQL",
        logo: {
          alt: "Leto Logo",
          src: "img/leto-icon-transparent.png",
        },
        items: [
          {
            type: "doc",
            docId: "intro",
            position: "left",
            label: "Tutorial",
          },
          { to: "/blog", label: "Blog", position: "left" },
          { to: "/docs/main/examples", label: "Showcase", position: "left" },
          {
            href: "https://pub.dev/packages/leto",
            label: "Dart API",
            position: "right",
          },
          {
            href: "https://github.com/juancastillo0/leto",
            label: "GitHub",
            position: "right",
          },
        ],
      },
      footer: {
        style: "dark",
        links: [
          {
            title: "Docs",
            items: [
              {
                label: "Tutorial",
                to: "/docs/intro",
              },
            ],
          },
          {
            title: "Community",
            items: [
              {
                label: "Stack Overflow",
                href: "https://stackoverflow.com/questions/tagged/leto",
              },
              {
                label: "Discord",
                href: "https://discordapp.com/invite/docusaurus",
              },
              {
                label: "Twitter",
                href: "https://twitter.com/juancastillo0",
              },
            ],
          },
          {
            title: "More",
            items: [
              {
                label: "Blog",
                to: "/blog",
              },
              {
                label: "GitHub",
                href: "https://github.com/juancastillo0/leto",
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Juan Manuel Castillo. Built with Docusaurus.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
        additionalLanguages: ["dart"],
      },
    }),

  plugins:
    /** @type {import('@docusaurus/preset-classic').Plugins} */
    [
      [
        require.resolve("@cmfcmf/docusaurus-search-local"),
        {
          // Options here
        },
      ],
    ],
};

module.exports = config;
