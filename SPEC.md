# StructureMindMap: Functional Spec

Nov 26, 2026 · @Henri Block

This spec describes StructureMindMap v2.8 as built on 26 Nov 2026. Items marked *Planned* are not built yet.

## Overview

StructureMindMap is a minimal mind-mapping and information-architecture tool built as an AI-powered Claude artifact. Each user signs in with their own Claude account, and all Claude usage counts against that user's plan.

- **Platform:** one HTML file published as a Claude artifact ([StructureMindMap](https://claude.ai/artifact/E257LQK1ipFd92TchSgf3N)). Source is kept in the GitHub repo Hablock/StructureMindMap as index.html. Desktop browsers only.
- **Users:** personal maps only. Collaboration comes later.
- **Language:** English UI. Content in English or Finnish. Claude writes node text in the language of the surrounding nodes and replies in the language the user writes in.
- **Scale:** usually under 100 nodes per map, but must stay usable with several hundred. No hard node limit.

**Distribution:** every user runs their own copy of the artifact, so Claude features use their own plan and maps save to their own account. A shared link to someone else's copy opens the editor only, because Claude features and account saving don't work for people other than the owner. The repo is also a Claude plugin marketplace: users add `Hablock/StructureMindMap` under Customize > Plugins, install the StructureMindMap plugin, and say "Set up StructureMindMap". Its skill publishes the bundled index.html as the user's own artifact with the sample, db and user capabilities. "Update StructureMindMap" republishes the same artifact, so maps are kept. The version is stored in a `structuremindmap-version` meta tag and in the plugin manifest; `scripts/release.sh` sets both and copies index.html into the plugin.

## Version history

| Version | Changes |
| --- | --- |
| v2.8 | Auto-save rebuilt: every change is written at once to a backup copy in the browser, then to the Claude account with retries; on load the two are merged so a reload or failed save no longer loses maps. A new map's name is selected for typing. The version number shows in the shortcuts list. A Claude plugin installs and updates the app |
| v2.7.3 | Shortcuts help grouped under headings with dividers (Adding and editing, Selecting and moving, Clipboard and history, View, Tools) and more space between rows |
| v2.7.2 | Fix: primary dialog buttons (Close, Delete, Generate) turn dark with white text on hover instead of dark on dark |
| v2.7.1 | Fix: dialog buttons (Shortcuts Close, confirmations, paste and Generate dialogs) did nothing in the published artifact; they now close their dialog directly |
| v2.7 | Hover tooltips on toolbar and panel buttons; toolbar stays on one line down to about 1280 px |
| v2.6 | Checklist mode: tick nodes off; parents follow their children; progress counts (v2.6.1: done nodes greyed instead of struck through; v2.6.2: done parents reopen only through their children; v2.6.3: a box click ticks the whole selection) |
| v2.5 | Structure with Claude reads the whole map and places the note where it fits best, or under the selected node; notes and nodes can be selected at the same time |
| v2.4 | Staging area becomes a left side panel, open by default and hideable; notes look like square post-it notes |
| v2.3 | Staging area: raw notes to the left of the map, paste into it, drag notes onto the map, Structure with Claude |
| v2.2 | Remaining children re-centre on their parent after a deletion (Mind map and Tree) |
| v2.1 | Gaps close after deletions and moves |
| v2 | Chat panel with Claude; suggestions for edits, moves and removals as well as additions |
| v1.5 | Rename maps in the header and the maps list |
| v1.4 | Right-button drag pans the map |
| v1.3 | Fixed node positions on a grid; Tidy; one "between these two" drop target |
| v1.2 | Alt/Option+Enter adds a line break |
| v1.1 | Text editing works like a normal text field |
| v1 | Core editing, three layouts, canvas, multi-select, drag and drop, paste and copy, saved maps, Expand and Generate |

## Layouts and positions

Node positions are fixed and snapped to a 12 px grid. Nodes move only as a result of something the user does.

| Layout | Arrangement |
| --- | --- |
| Mind map | Central node in the middle; first-level branches split between its right and left, balanced by size |
| Tree | Left to right, central node on the left |
| Sitemap / IA | Central node as a box above a row of first-level nodes side by side; each first-level node's descendants stacked vertically beneath it |

A true circular layout was dropped because wide, multi-line boxes fit badly around a circle.

**Arranging on request**

- Clicking a layout button re-arranges the whole map once in that layout, as one undo step. The layout also decides where new nodes go. Clicking the active layout re-arranges again.
- **Tidy** re-arranges the branch below the selected node. The selected node itself stays in place.
- Maps saved before fixed positions existed are arranged once when opened.

**Placing new nodes**

- A new node goes directly below its previous sibling's branch, or next to its parent and vertically centred on it if it is the first child. Nothing above or beside it moves.
- In Mind map, a new first-level branch goes to the side with fewer branches and stays there.
- If there is no room, only what follows moves down: the node's later siblings and, if the branch grows into the next one, the parent's later siblings, level by level. In Sitemap, a new first-level column pushes later columns right.
- If a node cannot fit beside nodes that are not allowed to move, it steps down below them.
- When editing makes a node wider or taller, its children and following siblings move out of the way. The same check runs when a collapsed branch is expanded.

**Cleanup after deletions and moves**

- Later siblings move up into the freed space. If the parent's branch got shorter, the parent's later siblings follow, level by level.
- Mind map and Tree: the remaining children re-centre on their parent, at every level up the tree, within the space their group already used.
- Sitemap: gaps close upward; deleting a first-level column shifts later columns left.
- Applies to delete, cut, dragging a node to another branch, accepting a suggested removal or move, and rejecting a suggested addition.

**Node style**

- Root, level 1 and level 2: rounded-corner rectangles.
- Level 3 and deeper: plain text with a line underneath.
- Text wraps at word boundaries at about 50 characters per line. Boxes grow to fit and stay readable with multi-line text.
- Minimal look: thin, neutral connector lines and no decoration beyond colour.

**Colour**

- Basic colour set for nodes. Palettes come later.
- Colour is inherited: children take their parent's colour unless they have their own. Recolouring a node recolours its descendants that have no colour of their own, and never affects its parent.
- The parent decides line colour: the line from a parent to a child always uses the parent's colour.

**Sitemap numbering:** *Planned.* Optional automatic numbering (1, 1.1, 1.1.2), off by default, included in copied text.

## Canvas and navigation

The map sits on an infinite canvas.

| Input | Action |
| --- | --- |
| Scroll | Pan up and down |
| Shift + scroll | Pan left and right |
| Cmd/Ctrl + scroll, trackpad pinch | Zoom |
| Right-button or middle-button drag | Pan; the cursor turns into a grabbing hand. The browser's right-click menu is off on the canvas |
| Drag on empty canvas | Marquee selection |
| Shift+1 / Shift+2 | Fit map to screen / centre map |

**On-screen controls, bottom right:** zoom out, zoom percentage (click resets to 100%), zoom in, Fit, Center.

**Side panels:** the staging area on the left (open by default) and the chat on the right. Opening or closing a panel keeps the map where it was on screen; Fit, Center and scrolling nodes into view use the space between the panels.

**Shortcuts help:** the ? button opens a list of keyboard and mouse shortcuts in five groups separated by dividers: Adding and editing, Selecting and moving, Clipboard and history, View, and Tools (checklist, staging area, chat).

**Tooltips:** every toolbar, zoom and panel button shows a tooltip on hover: its name and what it does, the shortcut where there is one, or why it is disabled (for example "Select a node first"). The first tooltip appears after about half a second; moving to the next button shows its tooltip right away. Claude buttons say when Claude is not available.

**Toolbar width:** below about 1780 px, buttons other than the Claude ones show icons only and the app name is hidden; below about 1360 px the map name and save status shorten. The toolbar stays on one line down to about 1280 px.

## Editing, selection and moving

**Editing**

- Tab adds a child. Enter adds a sibling below the selected node (on the central node, a child).
- Click a selected node to edit with the cursor where you clicked. Double-click edits with all text selected. F2 edits. Typing on a selected node starts editing and adds to the end of its text.
- While editing, the node behaves like a normal text field: clicks move the cursor, double-click selects all text, arrows, Home/End and Shift selection work. Enter finishes, Escape cancels, Tab finishes and adds a child.
- Alt/Option+Enter or Shift+Enter adds a line break inside the node.
- Space collapses or expands the selected branch. Arrow keys move between nodes.
- Multi-step undo and redo cover every change to the map, including positions and Claude's suggestions. History lasts until switching maps or reloading.

**Selection**

- Shift + click toggles a node in or out of the selection.
- A marquee drag on empty canvas selects every node whose label it touches.
- Selecting a node always includes its whole subtree.
- All actions apply to the selection: move, copy, colour, delete, Tidy and Claude features.

**Drag and drop**

- Middle of a node (40% of its height): the dragged nodes become its last children.
- From the lower part of one sibling, through the gap, to the upper part of the next: one "between these two" target, shown as a line in the gap. Above the first sibling and below the last work the same way.
- Empty canvas: nothing happens; the node snaps back.
- Subtrees always move with their parents. Dropping a node into its own branch is blocked. Nodes selected from different branches keep their relative order.

**Deletion**

- Only the Delete/Backspace key or the delete button deletes. Selecting, dragging or dropping never deletes anything.
- Deleting a node deletes all its children. The central node cannot be deleted. Undo restores everything, positions included.

## Staging area

A side panel of post-it notes for raw ideas, on the left of the screen. It shows the flow from raw ideas to a structured map.

- **Panel:** open by default; hidden and shown with the Notes button in the toolbar or the close button in the panel. The choice is remembered per browser. On windows narrower than 900 px it starts hidden.
- **Notes:** square, post-it yellow, in two columns in their own order. Long text fades out at the bottom of the square; the full text shows on hover and while editing. There is no manual positioning.
- **Adding notes:** "+ Note" in the panel header, a double-click on empty space in the panel, or Enter/Tab with the panel or a note selected.
- **Editing:** works like nodes. Click a selected note to edit with the cursor where you clicked, double-click to edit with all text selected, F2, or start typing. Enter finishes, Escape cancels, Alt/Option+Enter or Shift+Enter adds a line break.
- **Selecting:** click a note; Shift+click adds notes. Clicking empty space in the panel selects the panel itself, which makes it the paste target. Map nodes and notes can be selected at the same time. Keyboard actions (Delete, Enter, typing, paste, copy) apply to the area clicked last; the other area's selection shows dashed.
- **Pasting:** with the panel or a note selected, one line becomes one note. Several lines open a choice: one note with the full text, or one note per line. Nesting does not change the choice; list markers, numbers and indentation are stripped per line. New notes go after the selected note, or at the end.
- **To the map as they are:** drag notes from the panel onto a node to make them its children, or between two siblings to insert them there. Dropping anywhere else does nothing. The notes leave the staging area.
- **Structure with Claude:** a selected note shows this button. Claude turns the note into one or more nodes, using only what the note says and leaving out what the map already covers. With a map node selected, that node is the parent. Otherwise Claude reads the whole map and picks the node where the content fits best, using the central node only if nothing fits better. The nodes arrive as suggestions to keep or remove, a message names the chosen parent and the reason, and the note leaves the staging area.
- **Delete, copy, cut:** Delete or Backspace removes selected notes. Ctrl/Cmd+C or X copies the note texts separated by blank lines.
- **Undo** covers every staging change, including notes moved to the map.
- **Chat:** Claude sees the staging notes as context and can suggest where they belong, but cannot change them.
- The first visit's welcome map comes with three notes explaining the area.

## Checklist

Checklist mode is turned on and off per map with the Checklist button in the toolbar. Ticks are kept when it is off.

- Every node, the central node included, gets a box on its left. Click a box to tick that node. If several nodes are selected and the clicked node is one of them, the click ticks or unticks all of them; Ctrl/Cmd+Enter does the same for the selection.
- A node without children keeps its own tick. A node with children is done when all its children are done, so it updates by itself.
- Ticking a parent ticks its whole branch. A done parent cannot be unticked directly: to reopen it, untick one of its children or add a new child. Unticking a child unticks every parent above it that was done. With several nodes selected, unticking applies only to the nodes without children.
- A new child under a done parent makes the parent not done. Suggested additions from Claude do not count until kept.
- Done nodes show a green box with a checkmark and greyed text. Nodes with children show progress as done/total, counting the nodes at the ends of the branch.
- Ticks are part of undo.
- Copy writes `[x]` and `[ ]` boxes into the nested list while checklist mode is on. Pasting a list with `[x]` marks those nodes done.
- In the chat, Claude sees which nodes are done.

## Maps

- The maps list (menu button, top left) opens, creates, renames and deletes maps. Deleting asks for confirmation and also deletes the map's chat history.
- Rename by clicking the map name in the header, or with the pencil button or a double-click in the maps list. Enter or leaving the field saves, Escape cancels, an empty name restores the default.
- A map's name is separate from its central node. Until renamed, it follows the central node's text. Renaming is not part of undo.
- The first visit creates a welcome map that explains the controls.
- Save status shows next to the map name.

## Clipboard

Paste and copy are symmetric, so a branch can go into a Claude chat as text and come back unchanged.

**Paste target**

| Selection when pasting | Result |
| --- | --- |
| One node | Content becomes children of that node, after existing children |
| Several nodes | Content goes under the first selected node only |
| Nothing | Nothing is created; a short message asks to select a node |
| Image | Not yet: a message says image import comes in a later version |
| Staging area | Content becomes notes; several lines ask: one note, or one note per line |

**Text parsing**

- Each non-empty line becomes one node. Order is preserved and blank lines are ignored.
- Nesting is detected from tabs, spaces, `*` `-` `+` list markers, numbered prefixes (`1.`, `1.2`) and Markdown headings (`#`, `##`). Markers, numbers and checkboxes are stripped from the node text; `[x]` marks the node done.
- With space indentation, the smallest indent found counts as one level.
- A line indented two or more levels deeper than the line above becomes one level deeper.

**Copy and cut:** Ctrl/Cmd+C and X put the selection on the clipboard as an indented Markdown list. Line breaks inside a node become spaces. The Copy button copies the selection, or the whole map when nothing is selected.

## Claude features

Claude never changes the map directly. Every change arrives as a suggestion that the user keeps or removes. All Claude calls run on the viewer's own account.

| Feature | Status | What it does |
| --- | --- | --- |
| Chat | Built | Questions and free-form requests about the map; adds, edits, moves and removes nodes |
| Expand | Built | Suggests 3 to 5 child ideas for each selected node (up to 5 nodes) |
| Generate | Built | Turns pasted text into a branch under the selected node, or a new map |
| Restructure, summarize, translate | Through chat | No separate buttons; ask in the chat |
| Read image | *Planned* | Converts a photo, sketch or screenshot of a map into nodes |

**Chat panel**

- Opened with the Chat button. The panel sits on the right and the map shifts left to stay visible.
- One conversation per map; the full history is saved. A purge button clears it after confirmation.
- Every message sends the whole current map. With nodes selected, Claude changes only the selected branches unless asked otherwise, but sees the whole map and points out inconsistencies, duplicates and overlaps anywhere in it. With nothing selected, the whole map is in scope. The current scope shows under the panel header.
- Claude changes the map through four tools: add nodes, edit node, delete node, move node.
- Send turns into Stop while Claude answers. An empty chat offers a few example requests.
- A whole Claude reply undoes as one step.

**Suggestions**

| Kind | Shown as |
| --- | --- |
| Added | Green dashed outline |
| Edited | Amber dashed outline, new text with "Was: ..." underneath |
| Moved | Blue dashed outline with "Move to: ..." |
| Removed | Red dashed outline, text struck through |

- Each suggestion has its own keep and remove buttons. Accept all and Reject all sit in the review bar at the bottom.
- Editing a node with a suggested edit adopts the suggested text.
- *Planned:* version branching for suggestions.

## Import and export

*Planned.* Nothing in this section is built yet.

| Format | Import | Export | Keeps |
| --- | --- | --- | --- |
| JSON | Yes | Yes | Everything: structure, positions, colours, layout, checked states, staging notes |
| OPML | Yes | Yes | Structure; opens in XMind, MindNode and most mind-map tools |
| Markdown | Yes | Yes | Structure as a nested list; numbers when sitemap numbering is on |
| Image (PNG, JPG) | Yes, through Claude | PNG | Import: structure read by Claude. Export: the map as rendered |
| PDF | No | Yes | The map as rendered |

- When something is selected, export asks whether to export the selection or the whole map.
- PDF and PNG exports ask whether to include the staging area.
- Image import follows the clipboard paste rules. JSON, OPML and Markdown files open as a new map (assumption, to be confirmed).

## Data model and storage

Each map is saved as one document; its chat history is saved separately so a long chat never blocks saving the map.

| Who | Where maps are saved |
| --- | --- |
| Owner and Contributors | The user's Claude account, private to that user |
| Viewers through a shared link, including everyone outside an organization | This browser only |
| Neither available | Not saved; the status warns to copy the map |

| Entity | Fields |
| --- | --- |
| Map | id, name (optional), title, layout, checklist on/off, numbering, rootId, nodes, staging notes (id, text, in order), created, updated |
| Node | id, parent, children order, text, own colour, collapsed, checked, pending (suggested addition), suggestion (new text, removal or move), x, y, side (right, left or centred) |
| Chat | messages: role, text, time, error flag; stored as `<map id>~chat` |

**Auto-save:** there is no save button. Every change is written at once to a backup copy in this browser, then to the Claude account about 0.7 s later. A failed account save is retried (2 s, growing to 30 s between tries) until it succeeds; after three failures a message says so. Leaving or reloading the page finishes any open edit and writes the backup first.

**Loading:** the account maps and the browser copy are merged, map by map, and the newer version wins (last edit time, then save count). A map that only exists in the browser copy is uploaded. If the account can't be reached, the browser copy is shown and the account is retried every 30 s. Deleted maps are remembered in the browser so a failed delete doesn't bring them back. Maps saved by versions before 2.8 in the browser are merged in once.

**Status text:** Saving…, Saved, Saved in this browser, retrying (account save failing), or Saved in this browser (no account).

**Other storage details**

- Positions are stored per node and snapped to the grid. For left-side nodes, x is the right edge, so they grow leftward.
- The last opened map is remembered per browser.
- A chat history over about 200 KB shows a warning suggesting a purge.

## Known issues

- Real Claude calls and saving to a Claude account have only been tested against a simulated Claude.
- Performance with several hundred nodes is untested.
- Dark mode and Firefox have not been checked visually.
- In a crowded map, a node with no room can land far below its parent.
- Undo history is lost when switching maps or reloading.
- Arrow keys in Sitemap follow tree order, not exactly what is visually above or below.
- Clicking inside a dialog opened from the maps panel also closes the panel.

## Later features

**Other later work**

- Collaboration and shared maps
- Colour palettes
- Search and other navigation for large maps
- Version branching for Claude suggestions
- Import and export formats, image import, sitemap numbering

**Out of scope for now:** mobile support and free manual positioning (dragging a node to an empty spot).
