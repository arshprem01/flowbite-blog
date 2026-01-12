# Flowbite Blog

Production-ready README for the Flowbite Blog — a modern Ruby on Rails blog starter using Rails 8, Tailwind CSS, Hotwire, and Docker.

## Table of contents
- [Overview](#overview)
- [Features](#features)
- [Technology stack](#technology-stack)
- [Requirements](#requirements)
- [Quickstart (development)](#quickstart-development)
- [Database setup](#database-setup)
- [Running the app](#running-the-app)
- [Running tests](#running-tests)
- [Linting & formatting](#linting--formatting)
- [Docker (production)](#docker-production)
- [Deployment](#deployment)
- [Environment variables](#environment-variables)
- [Contributing](#contributing)
- [Troubleshooting](#troubleshooting)
- [Useful commands](#useful-commands)
- [License & maintainers](#license--maintainers)

## Overview
Flowbite Blog is a Rails-based blogging platform scaffolded to be production-ready. It uses modern Rails features (Importmap, Turbo, Stimulus), Tailwind CSS, and a simple asset pipeline (Propshaft). The repository includes tooling for local development, Docker, and deployment automation.

This README explains how to get the project running locally, test it, build a Docker image, and deploy.

## Features
- **Rails 8 application** (Ruby 3.4.7)
- **Tailwind CSS** (tailwindcss-rails)
- **Hotwire**: Turbo + Stimulus for fast UI interactions
- **Propshaft** asset pipeline
- **SQLite3** for development (easy to swap to Postgres in production)
- **System & integration testing** with Capybara and Selenium
- **Dockerfile** for containerized builds
- **Kamal** support for deployment
- **Sitemap generation and friendly URLs** (friendly_id & sitemap_generator)
- **Responsive Mobile Design**: Optimized layout for all devices.
- **Related Posts**: Shows "Read Next" suggestions based on title similarity.

## Technology stack
- Ruby 3.4.7
- Rails ~> 8.1.1
- Tailwind CSS (tailwindcss-rails)
- Propshaft
- Turbo + Stimulus
- Puma web server
- SQLite3 (development), recommend PostgreSQL for production
- Docker (Dockerfile included)
- Kamal (optional) for deployment

### Files of interest:
- `Gemfile` / `Gemfile.lock` — Ruby dependencies
- `Dockerfile` — container build
- `Procfile.dev` — development Procfile
- `package.json` / `package-lock.json` — PostCSS/Tailwind npm tooling
- `.ruby-version` — Ruby version

## Requirements
- Ruby 3.4.7 (rbenv / rvm / chruby)
- Bundler (`gem install bundler`)
- Node.js (recommended LTS) and npm (for Tailwind/PostCSS tooling)
- Docker (for container builds)
- SQLite3 (development) or PostgreSQL (production)
- Chrome/Chromium (for system tests with Selenium)

## Quickstart — Development

### Clone repository
```bash
git clone https://github.com/arshprem01/flowbite-blog.git
cd flowbite-blog
```

### Install Ruby dependencies
```bash
gem install bundler
bundle install
```

### Install Node dependencies (for PostCSS/Tailwind)
```bash
npm install
```

### Setup database (development)
```bash
bin/rails db:create db:migrate db:seed
```

### Run development processes (Tailwind watcher + Rails)
```bash
./bin/dev
```
This typically uses the `Procfile.dev` to run the Rails server and asset watchers together.

**Open browser** [http://localhost:3000](http://localhost:3000)

### Notes:
If you prefer to run Rails server directly:
```bash
bin/rails server -b 0.0.0.0
```
Use the `.ruby-version` to ensure matching Ruby locally.

## Database setup
The app uses SQLite3 by default in development. For production, switch to PostgreSQL (recommended) by updating `config/database.yml` and setting `DATABASE_URL` or appropriate config.

### Common commands:
- **Create DB**: `bin/rails db:create`
- **Migrate**: `bin/rails db:migrate`
- **Seed**: `bin/rails db:seed`
- **Reset DB**: `bin/rails db:reset`

## Running tests
### Unit and model tests:
```bash
bundle exec rails test
```

### System/integration tests (require browser & drivers):
Ensure Chrome/Chromium and chromedriver are installed and available in PATH.
```bash
bundle exec rails test:system
```
Capybara + Selenium are included; CI should install headless Chrome or use a container with browsers preinstalled.

## Linting & static analysis
- RuboCop, rubocop-rails-omakase configured
- Security scanning: brakeman (dev dependency)
- Bundler audit available for dependency checks

### Run RuboCop:
```bash
bundle exec rubocop
```

### Run Brakeman:
```bash
bundle exec brakeman
```

### Run Bundler Audit:
```bash
bundle-audit check --update
```

## Docker (production build)
### Build image:
```bash
docker build -t flowbite-blog:latest .
```

### Run container (example):
```bash
docker run --rm -e RAILS_ENV=production -e SECRET_KEY_BASE=your_secret -p 3000:3000 flowbite-blog:latest
```

### Notes:
Make sure to configure `DATABASE_URL` for production and precompile assets before running the container, or use an entrypoint that performs precompilation and migrations.
The repository includes a Dockerfile — adapt environment variables and entrypoint per your deployment needs.

Example multi-step for production container:
```bash
docker build -t flowbite-blog:latest .
docker run --rm -e RAILS_ENV=production -e DATABASE_URL=postgres://user:pass@db:5432/mydb -e SECRET_KEY_BASE=... -p 3000:3000 flowbite-blog:latest
```

## Deployment
### Kamal (included as a gem) — recommended for containerized deployment and edge cases:
- See [kamal-deploy.org](https://kamal-deploy.org) for setup.
- Configure Kamal in the repository (`kamal config`, Docker registry, cluster credentials).
- Use `kamal deploy` to push to your infrastructure.

### Container platforms:
Build Docker image and push to registry, then use your platform (Kubernetes, ECS, Fly, Heroku Container Registry) to deploy.

### Traditional hosting:
Precompile assets:
```bash
RAILS_ENV=production bin/rails assets:precompile
```
Setup database (Postgres recommended) and run migrations.

## Environment variables (examples)
- `RAILS_ENV=development|production`
- `DATABASE_URL=postgres://user:pass@host:5432/dbname` (or use native config files)
- `SECRET_KEY_BASE=generated_secret`
- `RAILS_MASTER_KEY` (if encrypted credentials are used)
- `HOST` (app host for sitemap and URL generation)

Store secrets securely (Vault, cloud secrets manager, or encrypted credentials).

## Contributing
Contributions are welcome.

1. Fork the repo
2. Create a feature branch: `git checkout -b feat/my-change`
3. Commit changes with clear messages
4. Open a pull request with description and testing steps

Please add tests for new or changed functionality. Follow coding style enforced by RuboCop.

## Troubleshooting
- **"Missing JS/CSS assets in production"**: ensure assets are precompiled and `propshaft` asset configuration matches your server static file serving.
- **Tests failing due to missing browser**: install Chrome/Chromium and chromedriver or run tests in a CI container with browsers.
- **Database connection errors**: confirm `DATABASE_URL` and that DB server is reachable.

## Useful commands
- **Start dev server**: `./bin/dev`
- **Run migrations**: `bin/rails db:migrate`
- **Run console**: `bin/rails c`
- **Run tests**: `bin/rails test`
- **Run system tests**: `bin/rails test:system`
- **Lint**: `bundle exec rubocop`

## License & maintainers
- License: (choose a license - MIT, Apache-2.0, etc). Add LICENSE file to repo.
- Maintainer: @arshprem01
