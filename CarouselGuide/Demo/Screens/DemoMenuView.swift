import SwiftUI

struct DemoMenuView: View {
    
    // MARK: - UI
    private var header: some View {
        Text("Six demos covering finite and infinite paging (horizontal + vertical), auto vs manual playback, and a \"3D circle\" stack.")
            .font(.callout).bold()
            .foregroundStyle(.primary)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    
    // MARK: - Main View
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    header

                    VStack(spacing: 16) {
                        ForEach(DemoType.allCases) { kind in
                            NavigationLink(value: kind) {
                                DemoRowView(kind: kind)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 32)
            }
            .navigationTitle("Carousels")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: DemoType.self) { kind in
                CarouselDemoView(kind: kind)
            }
        }
    }
}


// MARK: - Preview
#Preview {
    DemoMenuView()
}
