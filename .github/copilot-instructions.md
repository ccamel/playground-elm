# Elm Playground Development Guide

## Project Overview

This is a single-page application (SPA) built with Elm 0.19.1 to **explore, study and assess the Elm language** through
diverse and compelling showcases. The project demonstrates Elm's capabilities across diverse domains (graphics, games,
WebGL, JavaScript interop) while providing a **high-quality example of Elm best practices** and functional programming
patterns. It uses a **modular page-based architecture** where each demo is self-contained in its own `Page` module with
standardized structure.

## Elm Best Practices & Functional Patterns

### Core Principles

- **Immutability**: All data structures are immutable; use functional updates with record syntax
  `{ model | field = newValue }`
- **Pure Functions**: Functions should be deterministic with no side effects (except in `update` for `Cmd` and `Sub`)
- **Explicit State**: All application state lives in the `Model`; no hidden mutable state
- **Type Safety**: Leverage Elm's type system - use custom types over primitives, make impossible states unrepresentable
- **Function Composition**: Build complex functionality by composing simple functions rather than creating large
  monolithic functions

### Functional Programming Patterns

- **Pipeline Operator**: Use `|>` for data transformation chains (see `Lib.Array`, `Lib.String`)
  ```elm
  -- Example from Lib.String
  input
      |> Lib.String.trim
      |> Lib.String.split ","
  ```
- **Maybe/Result Chaining**: Use `Maybe.map`, `Maybe.andThen`, `Result.map` instead of case statements when possible
- **Partial Application**: Leverage currying for reusable function builders (see `Lib.Svg` utilities)
- **Custom Types**: Model domain concepts with union types (see `Page.Calc.State`, `App.Routing.Route`)
- **Function Composition**: Build complex operations from simple, composable functions
  ```elm
  -- Example pattern: transform data through multiple steps
  strToNumberWithMinMax s converter minv maxv =
      s |> converter |> map (limitRange (minv, maxv))
  ```

### Code Quality Standards

- **Single Responsibility**: Each function does one thing well; modules have clear purposes
- **Descriptive Naming**: Function and type names should clearly express intent (avoid abbreviations)
- **Small Functions**: Keep functions focused and composable (typically 5-15 lines)
- **Documentation**: Use doc comments for public functions, especially in `Lib.*` modules
- **Make Impossible States Unrepresentable**: Use custom types to model valid states only
  ```elm
  -- Example from Page.Calc: State machine prevents invalid calculator states
  type State = ACCUM | OPERATOR | DOT
  ```
- **Opaque Types**: Use opaque types for data validation (see `Lib.Array.BoundedArray`)
- **Update Pattern**: Always return `(Model, Cmd Msg)` tuples and use `Tuple.mapFirst` for transformations

## Architecture Patterns

### Page Module Structure

Every page follows this strict pattern in `src/Page/`:

```elm
module Page.Example exposing (Model, Msg, info, init, subscriptions, update, view)

-- PAGE INFO
info : Lib.Page.PageInfo Msg
info = { name = "example", hash = "example", date = "2024-06-01", description = ..., srcRel = "Page/Example.elm" }

-- MODEL, MSG, INIT, UPDATE, VIEW functions
```

### Adding New Pages

1. Create `src/Page/YourPage.elm` following the standard pattern
2. Add to `src/App/Pages.elm` in the `pages` list and routing functions
3. Add route parsing in `src/App/Routing.elm`
4. Add page model field to `PagesModel` in `src/App/Models.elm`
5. Import CSS in `src/index.js` if needed

### JavaScript Interop via Ports

Pages requiring JavaScript use port modules:

- Declare ports in the page module: `port module Page.Example exposing (...)`
- Create corresponding `.port.js` file in `src/Page/`
- Register ports in `src/index.js`: `import { registerPorts } from './Page/example.port.js'; registerPorts(app);`

Examples: `Page.Term` (JavaScript evaluation), `Page.Dapp` (Web3 wallet integration)

## Build System & Dependencies

### Core Tools

- **Parcel.js**: Bundler with Elm transformer (`@parcel/transformer-elm`)
- **pnpm**: Package manager (required - not npm/yarn)
- **elm**: 0.19.1 (specific version required)

### Key Commands

```bash
pnpm install          # Install dependencies
pnpm serve            # Development server (localhost:1234)
pnpm build            # Production build
pnpm lint             # Run elm-review + elm-format + eslint
```

### CSS Architecture

- **Bulma**: Primary CSS framework
- **Page-specific CSS**: Each page has its own CSS file imported in `index.js`
- **Animate.css**: For animations
- **Font Awesome**: Icons

## Development Workflows

### Project Structure Navigation

- `src/Main.elm`: Entry point using `Browser.application`
- `src/App/`: Core application logic (routing, models, messages, views)
- `src/Page/`: Individual demo pages (self-contained)
- `src/Lib/`: Shared utilities and components
- `static/`: Static assets (images, etc.)

### State Management

- Global state in `App.Models.Model` with `PagesModel` containing optional page states
- Each page manages its own model independently
- Pages lazy-initialize models when first accessed

### Styling Conventions

- Use Bulma classes for layout (`section`, `container`, `columns`, etc.)
- Page-specific styles in dedicated CSS files
- SVG-heavy demos for graphics and animations

### WebGL & Canvas Integration

- WebGL shaders: See `Page.Glsl` for GLSL shader integration
- Canvas rendering: See `Page.Physics` using `joakin/elm-canvas`
- SVG graphics: Most visual demos use SVG (see `Lib.Svg` utilities)

### Git Conventions

- **Gitmoji**: Use [gitmoji](https://gitmoji.dev/) for commit messages
- Format: `:emoji_code: Verb in title case followed by description`
- Examples: `:hammer: Level up copilot`, `:sparkles: Add new terrain generator`, `:memo: Update website screenshot`
- Common emojis: `:sparkles:` (features), `:bug:` (bugfixes), `:memo:` (docs), `:art:` (code structure), `:zap:` (performance), `:wrench:` (config)

## Testing & Quality

### Linting Setup

- `elm-review`: Elm code analysis (config in `review/`)
- `elm-format`: Code formatting
- `eslint`: JavaScript linting
- Run all: `pnpm lint`

### Deployment

- GitHub Pages deployment via Actions workflow
- Static site generation with Parcel
- Uses `BASE_URL` environment variable for path handling

## Key Libraries & Patterns

### Essential Elm Packages

- `elm/browser`: SPA foundation
- `elm-explorations/webgl`: 3D graphics
- `joakin/elm-canvas`: 2D canvas rendering
- `harmboschloo/elm-ecs`: Entity Component System (see `Page.Asteroids`)
