name: Static Site Deploy

on:
  push:
    branches:
      - master

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Setup Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: '2.7'

    - name: Install dependencies
      run: |
        gem install bundler
        bundle install

    - name: Build site
      run: bundle exec jekyll build --source ./docs --destination ./docs/_site

    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./docs/_site