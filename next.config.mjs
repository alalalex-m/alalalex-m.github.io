import mdx from "@next/mdx";

const withMDX = mdx({
  extension: /\.mdx?$/,
  options: {},
});

/** @type {import('next').NextConfig} */
const nextConfig = {
  pageExtensions: ["ts", "tsx", "md", "mdx"],
  transpilePackages: ["next-mdx-remote"],
  sassOptions: {
    compiler: "modern",
    silenceDeprecations: ["legacy-js-api"],
  },
  // GitHub Pages 配置
  output: 'export',
  trailingSlash: true,
  images: {
    unoptimized: true,
  },
  // 如果仓库名称不是 username.github.io，需要设置 basePath
  // basePath: process.env.NODE_ENV === 'production' ? '/repository-name' : '',
};

export default withMDX(nextConfig);
