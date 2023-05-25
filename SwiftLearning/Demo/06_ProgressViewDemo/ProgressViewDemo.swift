import SwiftUI

struct ProgressViewDemo: View {
    
    @State private var linearValue = 0.0
    
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                
                DefaultStyle()
                Spacer(minLength: 40)
                LinearStyle()
                
                Color.clear.frame(maxWidth: .infinity)
            }
            .padding()
        }.onReceive(timer) { _ in
            linearValue += 0.02

            if linearValue > 1.0 {
                linearValue = 0
            }
        }
    }

    private func DefaultStyle() -> some View
    {
        Group {
            makeTitleText("Default style")
            ProgressView()
        }
    }

    private func LinearStyle() -> some View
    {
        Group {
            makeTitleText("Linear style")
            ProgressView(value: linearValue)
                .progressViewStyle(.linear)
        }
    }
}

struct ProgressViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewDemo()
    }
}
