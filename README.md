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

The whole app is one file, `index.html`, with no build step and no dependencies. Fonts load from Google Fonts.

- **Locally:** open `index.html` in a browser.
- **GitHub Pages:** in the repo go to *Settings → Pages*, choose *Deploy from a branch*, then pick `main` and `/ (root)`. The site appears at `https://<user>.github.io/operational-readiness-app/`.
- **Your own domain:** host the file on Netlify, Vercel, Cloudflare Pages or GitHub Pages, and point your domain at it.

## Where data is saved

Right now data is saved in the browser's `localStorage`, so each person on each browser has their own copy. To back up a tracker, move it to another machine, or share a snapshot, use **Export → Backup (JSON)** and restore it with **Restore from a backup**.

**Export** also produces a CSV for spreadsheets and a Markdown summary of blockers and unassessed items for tickets, chat or a wiki.

For a shared team tracker, the next step is a small backend, such as Supabase or Firebase, or a Node server with a database. The app keeps all of its data in one JSON object, which makes that change straightforward. All saving happens in the `save()` function.

## Licence

MIT. See [LICENSE](LICENSE).
