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

## Running it

The app is built for the Claude artifact runtime. Claude features and account storage are only available when it is opened in Claude. Opening `index.html` directly in a desktop browser works for editing, with maps saved in that browser and Claude features disabled.

Desktop browsers only.

## Status

Current version: v2.8. See `SPEC.md` for what's built, what's planned (import and export, sitemap numbering, image import) and known issues.
