# Operational Readiness

A tracker for deciding whether the features in a release are ready to ship.

Each feature is a row and each readiness category is a column. For every cell you set a status, work through a checklist, and record an owner, a due date, a link and notes. The page rolls this up into a readiness percentage for each feature and a go / no-go verdict for the release.

## Categories

The tracker starts with 14 categories. You can rename, reorder, remove or add categories, and edit their checklists, from **Edit categories**.

| Category | The question it answers |
|---|---|
| Documentation | Are the docs people need written and published? |
| Data migration | Does this change existing data, and is there a tested plan to move it? |
| Deployment | Does this change how we build, package or deploy? |
| Configuration | Is new or changed configuration needed in each environment? |
| Dependencies | Does this rely on other teams, services or versions? |
| Rollback | Can we safely back this out if it goes wrong? |
| Observability | Will we know quickly if it breaks in production? |
| Security & privacy | Has the change been reviewed for security and data handling? |
| Performance & capacity | Will it hold up at production scale? |
| Testing & QA | Is the feature verified and signed off? |
| Compatibility | Does it break anything customers or integrations rely on? |
| Release strategy | How will it be turned on, and for whom? |
| Support & training | Can support and customer teams handle it on day one? |
| Customer communication | Do customers know what is changing and when? |

## Statuses

| Status | Meaning |
|---|---|
| Not assessed | Nobody has looked at this category yet |
| Not applicable | The category does not apply to this feature, so it is left out of the readiness score |
| Not started | It applies, but no work has been done |
| In progress | Work is under way |
| Blocked | Something is stopping progress. Any blocked item makes the feature, and the release, show as blocked |
| Ready | Done and verified |

A feature's readiness is the share of its applicable categories marked **Ready**.

## Running it

It's a static site with no build step and no dependencies. Fonts load from Google Fonts.

- **Locally:** open `index.html` in a browser.
- **Hosting:** deploy the repo root as a static site (no build command, output directory `/`) on any static host, such as GitHub Pages, Netlify, Vercel or Cloudflare Pages.
- **Live site:** https://operational-readiness.app

| File | What it is |
|---|---|
| `index.html` | The app |
| `config.js` | Database connection settings (empty means browser-only saving) |
| `supabase/setup.sql` | One-time database setup |
| `og.png`, `favicon.svg`, `apple-touch-icon.png` | Link preview image and icons |
| `assets/og-source.html` | Source for `og.png` |

## Where data is saved

**Without a database** (`config.js` left empty), each browser keeps its own copy in `localStorage`.

**With Supabase** connected, a **Share** button appears. It creates a shared board saved online, with a link like `/?board=<id>`. Everyone with the link sees the same board and can edit it, and changes from other people appear within about 15 seconds. Visiting the site without a board link still gives you a private, browser-only tracker with example data, which works as a demo for visitors.

### Connecting Supabase (about 5 minutes, free tier)

1. Create a free account at [supabase.com](https://supabase.com) and start a new project.
2. Open **SQL Editor → New query**, paste in the contents of `supabase/setup.sql`, and click **Run**.
3. Open **Project Settings → API** and copy the **Project URL** and the **anon public** key (newer projects call it the **publishable** key).
4. Paste both into `config.js`, then commit and push.

The public key is meant to be visible in the browser. The database doesn't allow it to read the table or list boards: it can only load or save a single board whose id it already knows, and that id is a 24-character random string kept in the board's link. Treat a board link like a shared document link. Never put the `service_role` or secret key in `config.js`.

Two people editing at the same moment is handled as last-save-wins.

### Backups and exports

**Export → Backup (JSON)** downloads the whole tracker, and **Restore from a backup** loads one back in. **Export** also produces a CSV for spreadsheets, and a Markdown summary of blockers and unassessed items for tickets, chat or a wiki.

## Link previews

The `og:` and `twitter:` tags in `index.html` point to `https://operational-readiness.app/og.png`. If the site moves to another domain, update those URLs and the `canonical` link.

## Licence

MIT. See [LICENSE](LICENSE).
