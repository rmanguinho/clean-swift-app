# Run instructions

An iOS application in Swift built with Clean Architecture, TDD and SOLID principles. It
is the iOS counterpart of the reference implementations in this series, and it is
structured as separate framework targets so that the layer boundaries are enforced by the
compiler rather than by convention.

## Prerequisites

Xcode with a Swift 5 toolchain, and an iOS simulator or device. There are no external
dependencies: no CocoaPods, no Swift Package Manager manifest, nothing to fetch.

## Open and run

```bash
open CleanApp.xcodeproj
```

Select the `Main` scheme and run. `Main` is the composition root and the only target that
knows about all the others.

## Tests

Run the full suite from Xcode with `Cmd+U`, or from the command line:

```bash
xcodebuild test -project CleanApp.xcodeproj -scheme Main \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

Adjust the simulator name to one your Xcode has installed.

## Layout

Each layer is its own framework target, with a matching test target:

```
Domain/         Models and use-case protocols — imports nothing
Data/           Use-case implementations, depending only on Domain
Infra/          URLSession-based HTTP client
Presentation/   Presenters and the view protocols they talk to
UI/             View controllers and storyboards
Main/           Composition root: factories, adapters, and the app delegate
```

The framework-per-layer split is what makes the dependency rule real: `Domain` has no
`import` of any other target, so a violation of the layer boundary does not compile.
