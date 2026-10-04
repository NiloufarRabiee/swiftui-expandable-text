import SwiftUI

/// A lightweight text view that automatically shows expansion controls
/// only when its content is actually truncated.
public struct ExpandableText: View {
    private let text: String
    private let lineLimit: Int
    private let moreLabel: String
    private let lessLabel: String
    private let buttonAlignment: HorizontalAlignment
    private let animation: Animation
    private let onExpansionChange: ((Bool) -> Void)?

    @State private var isExpanded: Bool
    @State private var collapsedHeight: CGFloat = 0
    @State private var fullHeight: CGFloat = 0
    @State private var isTruncated = false

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        _ text: String,
        lineLimit: Int = 3,
        moreLabel: String = "Show more",
        lessLabel: String = "Show less",
        buttonAlignment: HorizontalAlignment = .leading,
        initiallyExpanded: Bool = false,
        animation: Animation = .easeInOut(duration: 0.2),
        onExpansionChange: ((Bool) -> Void)? = nil
    ) {
        self.text = text
        self.lineLimit = ExpandableTextConfiguration.normalizedLineLimit(lineLimit)
        self.moreLabel = moreLabel
        self.lessLabel = lessLabel
        self.buttonAlignment = buttonAlignment
        self.animation = animation
        self.onExpansionChange = onExpansionChange
        _isExpanded = State(initialValue: initiallyExpanded)
    }

    public var body: some View {
        VStack(alignment: buttonAlignment, spacing: 6) {
            Text(text)
                .lineLimit(isExpanded ? nil : lineLimit)
                .background(collapsedMeasurement)
                .background(fullMeasurement)

            if isTruncated {
                Button(isExpanded ? lessLabel : moreLabel) {
                    toggleExpansion()
                }
                .buttonStyle(.plain)
                .accessibilityValue(isExpanded ? "Expanded" : "Collapsed")
                .accessibilityHint(
                    isExpanded ? "Collapses the full text" : "Shows the full text"
                )
            }
        }
        .onPreferenceChange(CollapsedTextHeightPreferenceKey.self) {
            collapsedHeight = $0
            updateTruncation()
        }
        .onPreferenceChange(FullTextHeightPreferenceKey.self) {
            fullHeight = $0
            updateTruncation()
        }
    }

    private var collapsedMeasurement: some View {
        Text(text)
            .lineLimit(lineLimit)
            .fixedSize(horizontal: false, vertical: true)
            .hidden()
            .background {
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: CollapsedTextHeightPreferenceKey.self,
                        value: proxy.size.height
                    )
                }
            }
    }

    private var fullMeasurement: some View {
        Text(text)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .hidden()
            .background {
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: FullTextHeightPreferenceKey.self,
                        value: proxy.size.height
                    )
                }
            }
    }

    private func toggleExpansion() {
        let nextValue = !isExpanded

        if reduceMotion {
            isExpanded = nextValue
        } else {
            withAnimation(animation) {
                isExpanded = nextValue
            }
        }

        onExpansionChange?(nextValue)
    }

    private func updateTruncation() {
        isTruncated = TruncationDetector.isTruncated(
            fullHeight: fullHeight,
            collapsedHeight: collapsedHeight
        )
    }
}

enum ExpandableTextConfiguration {
    static func normalizedLineLimit(_ value: Int) -> Int {
        max(value, 1)
    }
}

enum TruncationDetector {
    static func isTruncated(
        fullHeight: CGFloat,
        collapsedHeight: CGFloat,
        tolerance: CGFloat = 0.5
    ) -> Bool {
        guard fullHeight.isFinite, collapsedHeight.isFinite else {
            return false
        }

        guard fullHeight > 0, collapsedHeight > 0 else {
            return false
        }

        return fullHeight - collapsedHeight > max(tolerance, 0)
    }
}

private struct CollapsedTextHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private struct FullTextHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
