import SwiftUI
import ExpandableText

struct ArticlePreviewExample: View {
    private let text = """
    Good interfaces reveal complexity gradually. They give people enough
    information to understand what is happening without forcing every detail
    onto the screen at once. Expandable text is a small example of that idea:
    preserve the full content, keep the first view compact, and let the reader
    decide when they want more.
    """

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Design note")
                .font(.headline)

            ExpandableText(
                text,
                lineLimit: 3,
                moreLabel: "Read more",
                lessLabel: "Show less"
            )
            .font(.body)
        }
        .padding()
        .frame(maxWidth: 520)
    }
}
