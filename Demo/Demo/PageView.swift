import SwiftUI

struct PageView<Content: View, Link: View, Destination: View>: View {
    @EnvironmentObject var appState: AppState

    let number: Int
    let title: String
    let color: Color
    let content: Content
    let link: Link?
    let destination: Destination?

    var body: some View {
        ZStack {
            Rectangle()
                .do {
                    if #available(iOS 16, *) {
                        $0.fill(color.gradient)
                    } else {
                        $0.fill(color)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.45)
                .blendMode(.multiply)
            VStack {
                VStack(spacing: 20) {
                    content
                }
                .font(.system(size: 20, design: .rounded))
                .lineSpacing(4)
                .shadow(color: .white.opacity(0.25), radius: 1, x: 0, y: 1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(Color(white: 0.14))
                if let link = link, let destination = destination {
                    if #available(iOS 16, *) {
                        NavigationLink(value: number + 1) { link }
                    } else {
                        NavigationLink(destination: destination) { link }
                    }
                }
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .navigationBarTitle(Text(title), displayMode: .inline)
        .navigationBarItems(
            trailing: Button(action: { appState.isPresentingSettings = true }) {
                Group {
                    if #available(iOS 14, *) {
                        Image(systemName: "gearshape")
                    } else {
                        Image(systemName: "gear")
                    }
                }
                .font(.system(size: 16, weight: .semibold))
            }
        )
    }
}

extension PageView {
    init(
        number: Int,
        title: String,
        color: Color,
        @ViewBuilder content: () -> Content,
        @ViewBuilder link: () -> Link,
        @ViewBuilder destination: () -> Destination = { EmptyView() }
    ) {
        self.init(
            number: number,
            title: title,
            color: color,
            content: content(),
            link: link(),
            destination: destination()
        )
    }
}

extension PageView where Link == EmptyView, Destination == EmptyView {
    static func final(
        number: Int,
        title: String,
        color: Color,
        @ViewBuilder content: () -> Content
    ) -> some View {
        Self(
            number: number,
            title: title,
            color: color,
            content: content(),
            link: nil,
            destination: nil
        )
    }
}

extension View {
    func `do`<ModifiedView: View>(
        @ViewBuilder modifierClosure: (Self) -> ModifiedView
    ) -> some View {
        modifierClosure(self)
    }
}
