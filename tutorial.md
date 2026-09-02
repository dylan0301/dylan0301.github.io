# Editing This Website

This website is built with Jekyll. Most changes only require editing Markdown or YAML files; you usually do not need to modify JavaScript or the HTML templates.

## Common changes

| What you want to change | File to edit |
| --- | --- |
| Homepage title and text | `_pages/about.md` |
| CV content | `_pages/cv.md` |
| Site name, description, profile biography, email, and social links | `_config.yml` |
| Profile photograph | `images/profile.png` |
| Header links and their order | `_data/navigation.yml` |
| Light-mode colors | `_sass/theme/_default_light.scss` |
| Dark-mode colors | `_sass/theme/_default_dark.scss` |
| Fonts, font sizes, and responsive breakpoints | `_sass/_themes.scss` |
| Footer wording | `_includes/footer.html` |
| Favicons | `_includes/head/custom.html` and files under `images/` |

## Edit the homepage

The homepage is `_pages/about.md`.

Its first section is YAML front matter:

```yaml
---
permalink: /
title: "About Me"
author_profile: true
redirect_from:
  - /about/
  - /about.html
---
```

Keep both `---` lines. Change `title` to change the page heading, and edit everything below the front matter to change the visible homepage text.

The content uses Markdown:

```markdown
## Section heading

Normal text with **bold**, *italic*, and [a link](https://example.com).

![Description of an image](/images/example.jpg)
```

Place new images in `images/` before referencing them from a page.

## Edit the CV

The active webpage CV is `_pages/cv.md`. Its sections, dates, links, and descriptions are written directly in Markdown.

For example:

```markdown
## Education

**University Name** — *2024 – Present*<br>
Department or degree information
```

Editing files under `JeewonFiles/CV/` will not change the webpage. Those files are excluded from the generated site.

## Change the profile and site identity

Open `_config.yml` and update the site-level fields near the top:

```yaml
title: "Your Name"
name: "Your Name"
description: "Your website description"
url: "https://your-username.github.io"
repository: "your-username/your-username.github.io"
```

The sidebar profile comes from the `author` section:

```yaml
author:
  avatar: "profile.png"
  name: "Your Name"
  bio: "A short biography"
  employer: "Your Institution"
  email: "you@example.com"
  github: "your-username"
  linkedin: "your-linkedin-name"
```

Blank fields are hidden automatically. Some fields expect a username, while fields marked `URL` in `_config.yml` expect a complete web address.

To change the photograph, either:

1. Replace `images/profile.png` while keeping the same filename, or
2. Add a different image under `images/` and change `author.avatar` to its filename.

A square image works best because the theme displays the photograph as a circle. Restart the local Jekyll server after changing `_config.yml`; configuration changes are not automatically reloaded.

## Change the header navigation

Header links and their order are defined in `_data/navigation.yml`:

```yaml
main:
  - title: "CV"
    url: /cv/
```

Add another item to display another link:

```yaml
main:
  - title: "Research"
    url: /research/
  - title: "CV"
    url: /cv/
```

The order in this list is the order shown in the header. Removing an entry hides its header link but does not delete the corresponding page.

## Add a new page

Create a Markdown file under `_pages/`, such as `_pages/research.md`:

```yaml
---
title: "Research"
permalink: /research/
author_profile: true
---

## Current work

Write the page content here.
```

Then add its title and URL to `_data/navigation.yml` as shown above.

Useful front-matter options include:

- `title`: the page heading and browser metadata.
- `permalink`: the page's public URL.
- `author_profile: true`: show the profile sidebar.
- `author_profile: false`: hide the profile sidebar on that page.
- `layout: archive`: use the wider archive-style content layout used by the CV.

Pages without an explicit layout use the site's default `single` layout.

## Change the theme and colors

The quickest appearance change is the `site_theme` setting in `_config.yml`:

```yaml
site_theme: "default"
```

Available themes are:

- `default`
- `air`
- `sunrise`
- `mint`
- `dirt`
- `contrast`

Restart Jekyll after changing this setting.

For custom colors, edit both the light and dark Sass files for the selected theme. For the default theme, these are:

- `_sass/theme/_default_light.scss`
- `_sass/theme/_default_dark.scss`

Important color variables include:

```scss
--global-bg-color
--global-text-color
--global-text-color-light
--global-link-color
--global-link-color-hover
--global-masthead-link-color
--global-border-color
--global-footer-bg-color
```

Update both theme files because the site follows the user's color preference and also provides a manual light/dark toggle.

Typography, font sizes, and responsive breakpoints are defined in `_sass/_themes.scss`. Page-specific layout rules are under `_sass/layout/`.

The Sass entry point is `assets/css/main.scss`. Jekyll compiles it into the final CSS automatically.

## Change shared page elements

Only edit these files when you need to change the structure shared by multiple pages:

- `_includes/masthead.html`: header markup and the theme toggle.
- `_includes/author-profile.html`: profile/sidebar markup and social icons.
- `_includes/footer.html`: copyright, social links, and sitemap text.
- `_includes/footer/custom.html`: custom scripts or footer additions.
- `_includes/head/custom.html`: favicons and custom head elements.
- `_layouts/default.html`: overall page shell.
- `_layouts/single.html`: normal page structure.
- `_layouts/archive.html`: archive and CV page structure.

For ordinary text, navigation, profile, or color edits, these template files do not need to be changed.

## JavaScript changes

JavaScript source files are under `assets/js/`. If you modify them, rebuild the generated bundle with:

```bash
npm run build:js
```

Do not edit `assets/js/main.min.js` directly because the build command overwrites it.

## Preview changes locally

If the Ruby dependencies are installed, run:

```bash
bundle exec jekyll serve -l -H localhost
```

Open <http://localhost:4000> in a browser. Markdown, HTML, and Sass changes should rebuild automatically. Stop and restart the server after editing `_config.yml`.

Alternatively, use Docker:

```bash
docker compose up
```

Then open <http://localhost:4000>.

## Publish the website

The GitHub Actions workflow in `.github/workflows/jekyll-build.yml` builds and publishes the website whenever changes are pushed to the `main` branch.

A typical publishing workflow is:

```bash
git add _pages/about.md
git commit -m "Update homepage"
git push origin main
```

Adjust the `git add` command to include the files you changed. After pushing, check the repository's Actions page if the website does not update.

## Files to avoid editing

- `_site/`: generated website output. It will be overwritten.
- Generated `main.css`: change the Sass source files instead.
- `assets/js/main.min.js`: rebuild it from the JavaScript sources.
- `_sass/vendor/`: third-party theme dependencies.
- `images/themes/homepage-*.png`: README preview screenshots, not live backgrounds.
- `JeewonFiles/CV/*.tex`: these do not control the current webpage CV.
- `_layouts/cv-layout.html`, `_includes/cv-template.html`, and `_sass/layout/_json_cv.scss`: inactive for the current Markdown CV.

For most updates, start with `_pages/about.md`, `_pages/cv.md`, `_config.yml`, and `_data/navigation.yml`.
