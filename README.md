# StructureMindMap

A minimal mind-mapping and information-architecture tool that runs as a Claude artifact. It takes raw ideas to a structured map, with Claude helping along the way.

**Open it:** [StructureMindMap on Claude](https://claude.ai/artifact/E257LQK1ipFd92TchSgf3N)

Each person uses it with their own Claude account. Claude features run on that account's plan, and maps are saved privately to it. Non-commercial project.

## Features

- **Three layouts:** Mind map, Tree, and Sitemap / IA. Node positions stay put until you choose to re-arrange a layout or Tidy a branch.
- **Fast editing:** Tab adds a child and Enter adds a sibling. Edit text like a normal text field, multi-select with Shift+click or a marquee drag, drag and drop branches, and undo every step.
- **Infinite canvas:** scroll to pan, Cmd/Ctrl+scroll to zoom, right-drag to pan, plus Fit and Center buttons.
- **Staging area:** a side panel of post-it notes for raw ideas. Drag notes onto the map, or let Claude place them where they fit.
- **Chat with Claude:** ask about the map or have Claude add, edit, move and remove nodes. Every change arrives as a suggestion that you keep or reject.
- **Expand and Generate:** Claude suggests child ideas for selected nodes, or turns pasted text into a branch or a new map.
- **Checklist mode:** tick nodes off. Parents complete when all their children are done, and progress counts show on parents.
- **Clipboard:** paste indented lists, Markdown or numbered outlines as nested nodes. Copy gives an indented Markdown list.
- **Auto-save:** every change is saved to your Claude account, with a backup copy in the browser.

Press **?** in the app for all keyboard and mouse shortcuts.

## Files

| File | Contents |
| --- | --- |
| `index.html` | The whole app: one self-contained HTML file with its CSS and JavaScript |
| `SPEC.md` | Functional spec describing the current version, with version history and known issues |
| `.claude-plugin/marketplace.json` | Lists the plugin so this repo can be added as a plugin marketplace in Claude |
| `plugins/structuremindmap/` | The plugin: a skill that installs and updates the app as the user's own artifact, with a copy of `index.html` |
| `scripts/release.sh` | Prepares a release (see below) |

## Running it

The app is built for the Claude artifact runtime. Claude features and account storage are only available when it is opened in Claude. Opening `index.html` directly in a desktop browser works for editing, with maps saved in that browser and Claude features disabled.

Desktop browsers only.

## Install it in your Claude

Each person runs their own copy. It uses your own Claude plan for the Claude features and saves your maps privately to your Claude account. Someone else's shared link only opens the editor, without Claude features or account saving.

You need a paid Claude plan (Pro or higher).

1. In Claude, open **Customize** in the sidebar and select **Plugins**.
2. Select **Add marketplace** and enter `Hablock/StructureMindMap`.
3. Install the **StructureMindMap** plugin.
4. In a new chat, say **"Set up StructureMindMap"**. Claude publishes the app as your own artifact and gives you its link. Bookmark it.

### Updating

1. On the Plugins page, select **Check for updates** on the StructureMindMap marketplace, or turn on **Sync automatically**.
2. In a chat, say **"Update StructureMindMap"**. Claude republishes your existing copy, so your maps stay.

Your version number is shown at the bottom of the shortcuts list (the **?** button).

### Without the plugin

Download `index.html`, attach it in a new chat on claude.ai and send:

> Publish this file unchanged as an artifact titled StructureMindMap. It uses the sample, db and user capabilities.

To update later, attach the new file and ask Claude to publish it as a new version of your existing StructureMindMap artifact. A newly published artifact starts with no maps.

## Releasing a new version

1. Make the changes in `index.html`.
2. Run `bash scripts/release.sh X.Y.Z`. It sets the version in `index.html` and the plugin manifest, and copies `index.html` into the plugin.
3. Commit and push.

Users only receive a plugin update when its version changes, so always release through the script.

## Status

Current version: v2.8. See `SPEC.md` for what's built, what's planned (import and export, sitemap numbering, image import) and known issues.
