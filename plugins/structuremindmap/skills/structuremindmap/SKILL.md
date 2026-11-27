---
name: structuremindmap
description: Install, update or open StructureMindMap, a mind-mapping and information-architecture app, as the user's own Claude artifact. Use when the user asks to set up, install, update, reinstall or open StructureMindMap, or asks which version of it they have.
---

# StructureMindMap

StructureMindMap is a single-page mind-mapping app. This skill publishes it as an artifact owned by the user, so its Claude features run on the user's own plan and their maps are saved privately to their own account.

The app is the file `app/index.html` in this skill's folder. Its version is in the tag `<meta name="structuremindmap-version" content="X.Y.Z">` near the top of that file.

The app needs three artifact capabilities: `sample` (asks Claude), `db` (saves maps) and `user` (identifies the viewer). Without them it still opens, but without Claude features or account saving.

## Before anything else

1. Check that the session has an artifact tool that can publish a page from a file and declare its capabilities. If it doesn't, tell the user that StructureMindMap needs Claude's artifacts with app capabilities, available on paid plans, and stop.
2. List the user's own artifacts and look for one titled exactly `StructureMindMap`.
   - None: follow **Install**.
   - One: follow **Update**, even if the user said "install". Never publish a second copy, because each artifact has its own map storage and a new copy starts empty.
   - Several: list them with their links and last-changed dates, and ask which one to use before changing anything.

## Install

1. Publish `app/index.html` from this skill's folder as a new artifact. Use the file's absolute path, served as `index.html`, with title `StructureMindMap` and icon `map`. Publish the file unchanged: don't edit, reformat or shorten it.
2. Declare the capabilities `{"sample": {}, "db": {}, "user": {}}` for the new artifact. A new page is published first and declared second.
3. Give the user the link and say in one or two sentences what they have: their own copy, maps saved privately to their account, and Claude features on their plan. Mention that the ? button in the app lists the shortcuts.

## Update

1. Read the version of the live artifact from its `structuremindmap-version` meta tag, and the version of `app/index.html` in this skill.
2. If they're the same, tell the user they already have the latest version (give the number) and stop, unless they asked to reinstall.
3. If the skill's copy is older than the live artifact, say so and stop: the plugin itself needs updating first (in Customize > Plugins, use Check for updates on the StructureMindMap marketplace).
4. Otherwise republish the same artifact with `app/index.html` from this skill's folder, as a new version: pass the artifact's current version as the base version and keep the title and icon. Publish the file unchanged.
5. Check the artifact's declared capabilities. If `sample`, `db` or `user` is missing, declare `{"sample": {}, "db": {}, "user": {}}`.
6. Tell the user the old and new version numbers and that their maps are kept. Suggest reloading the app if it's open.

## Opening the app

If the user only wants to open it and it's installed, give them the artifact's link. If it isn't installed, offer to install it.

## Don'ts

- Don't change the artifact's sharing. Each person should run their own copy; a shared link to someone else's copy works without Claude features or account saving.
- Don't delete an existing StructureMindMap artifact. Its maps would be lost.
- Don't write to or read the app's saved maps.
