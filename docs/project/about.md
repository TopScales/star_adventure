# About the project

This project has been created from a [template](https://github.com/TopScales/godot_starter.git) Godot project. Check its [wiki](https://github.com/TopScales/godot_starter/wiki) to learn how to include the template's updates into this project in the best way.

## VSCode Setup

The recommended way of working with this project is by using [VSCode](https://code.visualstudio.com/) and launching the Godot Editor from there. This allows to use the full extension ecosystem and coding capabilities of VSCode, for both, Godot related and external files. Also, using the debugging capabilities of VSCode, it becomes easier to spot errors that could be not directly related to GScript code, but to the core engine itself. This helps finding errors when, for instance, the editor crashes while working in the project.

It is highly recommended for programmers to use [GitHub Copilot](https://code.visualstudio.com/docs/copilot/getting-started).

### Extensions

- **Godot-tools**. Useful for working with Godot files.
- **GitLens**. Shows more information on git changes.
- **C/C++ Extension Pack**. Useful when developing custom modules and GDExtension libraries.
- **MkDocs Syntax Highlight**. To edit the documentation.
- **Material Icon Theme**. Improves the look of VSCode.
- **Code Spell Checker**. Helps with spelling, for code and documentation.

### Settings

To standardize and keep clean files, add the option to trim whitespaces.
```json
"files.trimTrailingWhitespace": true
```
Other recommended settings are:

```json
"workbench.editor.enablePreviewFromCodeNavigation": true,
"workbench.editor.enablePreviewFromQuickOpen": true,
"editor.cursorBlinking": "expand",
"editor.fontFamily": "Jetbrains Mono, Consolas, 'Courier New', monospace",
"editor.smoothScrolling": true,
"editor.mouseWheelZoom": true,
"editor.fontLigatures": true,
"workbench.iconTheme": "material-icon-theme"
```
If you want to use the [Jetbrains Mono](https://www.jetbrains.com/es-es/lp/mono/) font, make sure you have it installed.

## Custom Godot Editor



- Allows to make small changes to the core code without the need to go through the official Godot PR process.
- Export with [encrypted data](https://docs.godotengine.org/en/stable/engine_details/development/compiling/compiling_with_script_encryption_key.html).
- Customize the editor splash screen.
- Can add modules with the advantages of core systems.
- Avoid version conflicts.

- Fork godot
- Checkout branch
- Copy misc files to compile
- Execute debug

## Godot Editor Settings

To standardize and keep clean files, activate the trimming of whitespaces. In the Godot Editor, go to the `Editor` menu and select `Editor Settings...`. Activate the option to show Advanced Settings, and go to `Text Editor/Behavior/Files` and check the option `Trim Trailing Whitespace on Save`.

It is also recommended to allow the script editor to scroll past the end of the file. To do so, in the Editor Settings, go to `Text Editor/Behavior/Files` and check the option `Scroll Past End of File`.

## Project version

- Version rsrc
- Proj vers Updated automatically
- Vers convention

## Addons

### GUT

- Link
- Make unit tests whenever new features are added to the project

### LogErr

- Simple logger
- Error management

## Modules

## GDExtension Libraries

## Assets

- Icons
- Logo

## Autoloads

### Game

### Data

