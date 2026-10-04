# ExpandableText

[![CI](https://github.com/NiloufarRabiee/swiftui-expandable-text/actions/workflows/ci.yml/badge.svg)](https://github.com/NiloufarRabiee/swiftui-expandable-text/actions/workflows/ci.yml)
![Swift](https://img.shields.io/badge/Swift-5.9%2B-orange)
![iOS](https://img.shields.io/badge/iOS-16%2B-blue)
![macOS](https://img.shields.io/badge/macOS-13%2B-blue)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A lightweight reusable **SwiftUI text view with automatic truncation detection and animated Show More / Show Less controls**.

The expansion control appears only when the text is actually truncated.

## Features

- Native SwiftUI
- Automatic truncation detection
- Configurable collapsed line limit
- Custom Show More and Show Less labels
- Animated expand and collapse
- Reduce Motion support
- Optional expansion-change callback
- Leading, center, or trailing control alignment
- Dynamic-width support
- No third-party dependencies
- iOS and macOS support
- Swift Package Manager support

## Requirements

- iOS 16+
- macOS 13+
- Swift 5.9+

## Installation

### Swift Package Manager

In Xcode:

1. Open your project.
2. Go to **File > Add Package Dependencies...**
3. Enter:

```
https://github.com/NiloufarRabiee/swiftui-expandable-text
```

4. Add the `ExpandableText` package to your app target.

Then import it:

```swift
import ExpandableText
```

## Basic Usage

```swift
ExpandableText(
    description,
    lineLimit: 3
)
```

If the content fits within three lines, no control is shown. If it is truncated, the component automatically displays **Show more**.

## Custom Labels

```swift
ExpandableText(
    article,
    lineLimit: 4,
    moreLabel: "Read more",
    lessLabel: "Read less"
)
```

## Control Alignment

```swift
ExpandableText(
    description,
    lineLimit: 2,
    buttonAlignment: .trailing
)
```

Supported values are standard SwiftUI horizontal alignments such as `.leading`, `.center`, and `.trailing`.

## Initially Expanded

```swift
ExpandableText(
    details,
    lineLimit: 3,
    initiallyExpanded: true
)
```

## Observe Expansion Changes

```swift
ExpandableText(
    description,
    lineLimit: 3
) { isExpanded in
    print("Expanded:", isExpanded)
}
```

The callback is optional and can be useful when the surrounding interface needs to react to expansion state.

## Styling

Standard environment-based SwiftUI text styling works naturally:

```swift
ExpandableText(
    description,
    lineLimit: 3
)
.font(.body)
.foregroundStyle(.secondary)
.tint(.indigo)
```

## Accessibility

`ExpandableText` respects **Reduce Motion**. When Reduce Motion is enabled, expansion and collapse happen without animation.

The control also exposes its expanded or collapsed state and an accessibility hint.

## How Truncation Detection Works

The component measures two hidden versions of the same text at the available width:

1. A version constrained to the collapsed line limit.
2. A version allowed to render at full height.

If the full text is meaningfully taller than the collapsed version, the expansion control is shown.

Because both measurements remain inside SwiftUI's layout system, the result automatically updates when the available width or text size changes.

## Examples

Two examples are included:

```
Examples/ArticlePreviewExample.swift
Examples/ExpandableCardExample.swift
```

## Testing

The package includes unit tests for:

- Line-limit normalization
- Positive line-limit preservation
- Truncation detection
- Equal-height content
- Measurement tolerance
- Invalid measurements

Run:

```bash
swift test
```

## Contributing

Contributions and improvements are welcome.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This project is available under the MIT License.

See [LICENSE](LICENSE).

---

Created by **Niloufar Rabiee**
