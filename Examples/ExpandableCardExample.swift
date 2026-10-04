import SwiftUI
import ExpandableText

struct ExpandableCardExample: View {
    private let description = """
    This card uses ExpandableText inside a normal SwiftUI layout. The expansion
    control appears only when the text is actually truncated, so short content
    does not receive an unnecessary button.
    """

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Project summary", systemImage: "sparkles")
                .font(.headline)

            ExpandableText(
                description,
                lineLimit: 2,
                buttonAlignment: .trailing
            ) { isExpanded in
                print("Expanded:", isExpanded)
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding()
    }
}
