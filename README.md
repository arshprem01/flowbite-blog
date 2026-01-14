# Flowbite Blog

A production-ready, modern Ruby on Rails blog application featuring a custom authentication system, admin dashboard, and a polished UI built with Tailwind CSS and Flowbite.

## Features

### Core Functionality
- **Custom Authentication**: Secure user accounts with sign-up, login, and password management (built from scratch, no Devise).
- **Admin Dashboard**: Dedicated namespace and interface for administrators to create and manage posts.
- **Engagement**: Users can read, like, and comment on posts.
- **Notifications**: Built-in notification system to alert users of interactions.
- **Responsive Design**: Fully mobile-optimized layout using Flowbite components.

### Technical Stack
- **Ruby**: 3.4.7
- **Rails**: ~> 8.1.1
- **Styling**: Tailwind CSS (via `tailwindcss-rails`) & Flowbite
- **Assets**: Propshaft
- **Frontend**: Hotwire (Turbo & Stimulus)
- **Database**: SQLite3 (Development) / PostgreSQL (Production recommended)
- **Deployment**: Docker & Kamal support included

## Quickstart

### Prerequisites
- Ruby 3.4.7
- Node.js & npm (for Tailwind/PostCSS)
- SQLite3

### Setup
1. **Clone the repository**
   ```bash
   git clone https://github.com/arshprem01/flowbite-blog.git
   cd flowbite-blog
   ```

2. **Install dependencies**
   ```bash
   bundle install
   npm install
   ```

3. **Setup Database**
   ```bash
   bin/rails db:create db:migrate db:seed
   ```

4. **Start the Development Server**
   ```bash
   ./bin/dev
   ```
   Visit `http://localhost:3000` in your browser.

## Key Components

### Admin Panel
Access the admin interface to manage content. Ensure you have a user with admin privileges (flag `admin: true` on the User model).
- Routes: `/admin/posts`

### Notifications
Users receive in-app notifications for relevant activities.
- Routes: `/notifications`

### PWA Support
The application is configured with basic PWA features (manifest, service worker) for installability on mobile devices.

## Docker & Deployment
The project includes a `Dockerfile` optimized for production.

**Build the image:**
```bash
docker build -t flowbite-blog:latest .
```

**Deploy with Kamal:**
Refer to the `config/deploy.yml` (if available) or standard Kamal documentation to deploy to your VPS.

## Contributing
1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/amazing-feature`).
3. Commit your changes.
4. Push to the branch.
5. Open a Pull Request.

## License
[MIT License](LICENSE)
