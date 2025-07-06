import { Logo } from "@once-ui-system/core";

const person = {
  firstName: "AlxXxlA",
  lastName: "",
  englishName: "Alexander McAndrew",
  chineseName: "石浩廷",
  logo: "AlxXxlA",
  get name() {
    return `${this.firstName} ${this.lastName}`;
  },
  role: "Graduated pending for a job",
  avatar: "/images/avatar.jpg",
  email: "alexandermcandrewog@gmail.com",
  location: "Asia/Shanghai", // Expecting the IANA time zone identifier, e.g., 'Europe/Vienna'
  languages: ["English", "Chinese"], // optional: Leave the array empty if you don't want to display languages
};

const newsletter = {
  display: true,
  title: <>Subscribe to {person.firstName}'s Newsletter</>,
  description: (
    <>
        What you see is what you get.
    </>
  ),
};

const social = [
  // Links are automatically displayed.
  // Import new icons in /once-ui/icons.ts
  {
    name: "GitHub",
    icon: "github",
    link: "https://github.com/alalalex-m",
  },
  {
    name: "LinkedIn",
    icon: "linkedin",
    link: "https://www.linkedin.com/in/haoting-shi-54103a268/",
  },
  {
    name: "Instagram",
    icon: "instagram",
    link: "https://www.instagram.com/alalalex.m/",
  },
  {
    name: "Douyin",
    icon: "douyin",
    link: "https://www.douyin.com/user/MS4wLjABAAAAAcGK5Ib_FfPqp5WZ3U9yBuHoX8lzHMV7_i5y0ZXhE3tzFFIfD9JQpQiHZE4ewSbR",
  },
  {
    name: "Email",
    icon: "email",
    link: `mailto:${person.email}`,
  },
];

const home = {
  path: "/",
  image: "/images/og/home.jpg",
  label: "Home",
  title: `${person.name}'s Portfolio`,
  description: `Portfolio website showcasing my work as a ${person.role}`,
  headline: <>Building bridges between design and code</>,
  featured: {
    display: true,
    title: <>Recent project: <strong className="ml-4">Once UI</strong></>,
    href: "/work/building-once-ui-a-customizable-design-system",
  },
  subline: (
    <>
      I'm AlxXxlA, a self motivated developer, I currently code anything that I want to build.
      I also work out alot as a daily routine. (Some day, I'll be a singer as well.)
    </>
  ),
};

const about = {
  path: "/about",
  label: "About",
  title: `About – ${person.name}`,
  description: `Meet ${person.name}, ${person.role} from ${person.location}`,
  tableOfContent: {
    display: true,
    subItems: false,
  },
  avatar: {
    display: true,
  },
  calendar: {
    display: true,
    link: "https://cal.com",
  },
  intro: {
    display: true,
    title: "Introduction",
    description: (
      <>
        AlxXxlA is a Shanghai-based developer with a passion for transforming complex challenges
        into simple, elegant design solutions. His work spans digital interfaces, interactive
        experiences, and the convergence of design and technology.
      </>
    ),
  },
  work: {
    display: true, // set to false to hide this section
    title: "Work Experience",
    experiences: [
      {
        company: "Liaoning Gongying Technology Co., Ltd.",
        timeframe: "2021 - 2022",
        role: "Network Engineer Intern",
        achievements: [
          <>
            Assist network security engineers by doing log analysis, security planning, monitoring, performance analysis, etc.
          </>,
          <>
            Responsible for the daily maintenance of the company's network system and FTP server, NAS to ensure the normal operation of the network.
          </>,
          <>
            Assisting the commercial department to participate in government procurement project bidding, familiar with the bidding process.
          </>
        ],
        images: [
          // optional: leave the array empty if you don't want to display images
          {
            src: "/images/projects/project-01/cover-01.jpg",
            alt: "Once UI Project",
            width: 16,
            height: 9,
          },
        ],
      },
      {
        company: "China Mobile Group Shaanxi Co., Ltd. Weiyang Branch",
        timeframe: "2024 - 2024",
        role: "Government & Enterprise Account Manager Intern",
        achievements: [
          <>
            Participated in the development of 5G/IoT solutions for 10+ governmental enterprises, including requirement research, solution design and tender preparation.
          </>,
          <>
            Independently collated customer data and wrote 3 industry analysis reports, assisted in developing marketing strategies.
          </>,
          <>
            Familiar with the business process of operators and government enterprises, and strengthen the cross-departmental communication and customer service ability.
          </>,
        ],
        // images: [],
      },
    ],
  },
  studies: {
    display: true, // set to false to hide this section
    title: "Studies",
    institutions: [
      {
        name: "Xiangtan University (B.Eng.)",
        description: <>Communication Engineering, But I'm more interested in the software side of things.</>,
      },
      // {
      //   name: "Xiangtan University",
      //   description: <>Studied online marketing and personal branding.</>,
      // },
    ],
  },
  technical: {
    display: true, // set to false to hide this section
    title: "Technical skills",
    skills: [
      {
        title: "Python",
        description: <>Proficient in Python, with experience in PyQt, NumPy, Pandas, API Development, TensorFlow, PyTorch, Flask, Scikit-learn.</>,
      },
      {
        title: "C/C++",
        description: <>Skilled in C/C++, including STL, Socket programming, and memory management.</>,
      },
      {
        title: "Swift/SwiftUI",
        description: <>Experienced in Swift/SwiftUI, AVFoundation, CoreData, SwiftData, and data handling.</>,
      },
      {
        title: "TCP/IP stack & Network",
        description: <>Familiar with TCP/IP stack, firewall configuration, VPN setup, Wireshark packet capture analysis.</>,
      },
      {
        title: "MacOS/Linux",
        description: <>Comfortable with MacOS/Linux environments, including Shell scripting and Homebrew usage.</>,
      },
      {
        title: "Office",
        description: <>Proficient in Word Automation and Excel functions.</>,
      },
    ],
  },
};

const blog = {
  path: "/blog",
  label: "Blog",
  title: "Writing about design and tech...",
  description: `Read what ${person.name} has been up to recently`,
  // Create new blog posts by adding a new .mdx file to app/blog/posts
  // All posts will be listed on the /blog route
};

const work = {
  path: "/work",
  label: "Work",
  title: `Projects – ${person.name}`,
  description: `Design and dev projects by ${person.name}`,
  // Create new project pages by adding a new .mdx file to app/blog/posts
  // All projects will be listed on the /home and /work routes
};

const gallery = {
  path: "/gallery",
  label: "Gallery",
  title: `Photo gallery – ${person.name}`,
  description: `A photo collection by ${person.name}`,
  // Images by https://lorant.one
  // These are placeholder images, replace with your own
  images: [
    {
      src: "/images/gallery/horizontal-1.jpg",
      alt: "image",
      orientation: "horizontal",
    },
    {
      src: "/images/gallery/horizontal-2.jpg",
      alt: "image",
      orientation: "horizontal",
    },
    {
      src: "/images/gallery/horizontal-3.jpg",
      alt: "image",
      orientation: "horizontal",
    },
    {
      src: "/images/gallery/horizontal-4.jpg",
      alt: "image",
      orientation: "horizontal",
    },
    {
      src: "/images/gallery/vertical-1.jpg",
      alt: "image",
      orientation: "vertical",
    },
    {
      src: "/images/gallery/vertical-2.jpg",
      alt: "image",
      orientation: "vertical",
    },
    {
      src: "/images/gallery/vertical-3.jpg",
      alt: "image",
      orientation: "vertical",
    },
    {
      src: "/images/gallery/vertical-4.jpg",
      alt: "image",
      orientation: "vertical",
    },
  ],
};

export { person, social, newsletter, home, about, blog, work, gallery };
