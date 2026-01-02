# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_by(email_address: "admin@test.com", role: :admin)

if !user
  user = User.create(email_address: "admin@test.com", password: "admin123", role: :admin)
end

post = Post.find_by(title: "Ruby on Rails + Hotwire: Building Fast, Modern Web Apps Without Heavy JavaScript")

if !post
  post = user.posts.create!(
    title: "Ruby on Rails + Hotwire: Building Fast, Modern Web Apps Without Heavy JavaScript",
    body: "Ruby on Rails has always been known for its focus on developer productivity, clean conventions, and rapid application development. From startups to large-scale applications, Rails has consistently provided a balanced approach to building maintainable web software. With the introduction of Hotwire, Rails takes a major step forward in delivering modern, highly interactive user experiences without relying on heavy frontend JavaScript frameworks.

Hotwire, which stands for HTML Over The Wire, is a new way of thinking about frontend development. Instead of pushing complex application logic to the browser, Hotwire keeps most of the logic on the server and sends ready-to-render HTML to the client. This approach aligns perfectly with the Rails philosophy and significantly simplifies application architecture.

Hotwire is made up of two main components: Turbo and Stimulus. Turbo improves performance by eliminating full-page reloads. It enables fast navigation, smooth form submissions, and real-time updates by replacing only the parts of the page that change. Features like Turbo Drive, Turbo Frames, and Turbo Streams allow developers to build dynamic interfaces using standard server-rendered HTML.

Stimulus complements Turbo by providing a lightweight JavaScript layer for adding small, focused interactions. It is designed to enhance HTML rather than replace it. With Stimulus, developers can easily add behaviors such as dropdowns, modal dialogs, and form validations without introducing complex client-side state or large JavaScript bundles.

One of the biggest advantages of using Rails with Hotwire is the reduction in frontend complexity. Developers can build rich, interactive applications while writing far less JavaScript. This leads to cleaner codebases, faster development cycles, and easier long-term maintenance. Teams can focus on business logic instead of managing multiple frontend frameworks and build tools.

Performance is another strong benefit. Because most rendering happens on the server and only small HTML fragments are sent to the client, applications feel fast and responsive even on slower networks. This server-first approach also improves accessibility and search engine optimization by default.

Rails and Hotwire together offer a powerful, modern web development stack that prioritizes simplicity, performance, and developer happiness. In an ecosystem often dominated by heavy JavaScript frameworks, this combination provides a refreshing alternative that proves you can build modern web applications while keeping your code elegant, maintainable, and enjoyable to work with."
  )
  post.banner_image.attach(io: File.open(Rails.root.join('public/train.jpg')), filename: 'train.jpg')
end

post2 = Post.find_by(title: "Why Ruby on Rails Is Often Better Than ReactJS for Building Real-World Applications")

if !post2
  post2 = user.posts.create!(
    title: "Why Ruby on Rails Is Often Better Than ReactJS for Building Real-World Applications",
    body: "Ruby on Rails is often a better choice than ReactJS when the goal is to build complete, production-ready web applications efficiently and sustainably. The key reason is that Ruby on Rails is a full-stack framework, while ReactJS is only a frontend library. Rails provides everything needed to build an application in one cohesive system—database integration, routing, backend logic, authentication, security, background jobs, and testing—right out of the box. With ReactJS, developers must assemble multiple tools and frameworks to achieve the same result, increasing complexity, setup time, and long-term maintenance effort.

Rails emphasizes convention over configuration, which dramatically speeds up development. Developers spend less time deciding how to structure an application and more time solving real problems. This makes Rails especially powerful for startups, small teams, and rapid prototyping, where time-to-market matters. In contrast, ReactJS projects often require significant architectural planning, state management decisions, and tooling choices before meaningful progress can be made.

Most business applications are data-driven rather than animation-heavy. Dashboards, admin panels, SaaS products, and internal tools benefit from Rails strong backend-first approach and tight database integration. Rails keeps application state primarily on the server, which simplifies logic, reduces frontend bugs, and makes applications easier to reason about. ReactJS shifts much of this complexity to the client, requiring careful state synchronization and additional libraries."
  )
  # Corrected to use .webp
  post2.banner_image.attach(io: File.open(Rails.root.join('public/rurj.webp')), filename: 'rurj.webp')
end

# Ensure attachment is present even if post already existed (fixes previous mismatch)
if !post2.banner_image.attached? || post2.banner_image.filename.to_s != 'rurj.webp'
  post2.banner_image.attach(io: File.open(Rails.root.join('public/rurj.webp')), filename: 'rurj.webp')
end

post3 = Post.find_by(title: "Building a Hotwire Native Mobile App Using Ruby on Rails")

if !post3
  post3 = user.posts.create!(
    title: "Building a Hotwire Native Mobile App Using Ruby on Rails",
    body: "Modern users expect mobile apps that are fast, responsive, and easy to maintain. Traditionally, this meant building separate backend APIs and native mobile apps, which increased complexity and development time. With Hotwire Native, developers can now build real mobile applications using Ruby on Rails while sharing most of the code between web and mobile.

Hotwire Native brings the simplicity and productivity of Rails to iOS and Android, allowing teams to ship native apps faster without sacrificing performance or user experience."
  )
  post3.banner_image.attach(io: File.open(Rails.root.join('public/CoverImage.webp')), filename: 'CoverImage.webp')
end

# Backfill slugs for all posts to ensure FriendlyId works
Post.find_each(&:save)
