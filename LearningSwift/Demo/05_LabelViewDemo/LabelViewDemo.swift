import SwiftUI

struct LabelViewDemo: View {
    var body: some View {
        Group{
            VStack(alignment: .leading)
            {
                iconAndTitlle()
                Spacer()
                iconOnly()
                Spacer()
                titleOnly()
                Spacer().frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
    
    private func iconAndTitlle() -> some View
    {
        Group
        {
            makeTitleText("Icon + Title")
            Label("Icon + Title", systemImage: "trash")
        }
    }

    private func iconOnly() -> some View
    {
        Group
        {
            makeTitleText("Icon only")
            Label("Icon only", systemImage: "trash").labelStyle(.iconOnly)
        }
    }
    
    private func titleOnly() -> some View
    {
        Group
        {
            makeTitleText("Title only")
            Label("Title only", systemImage: "trash").labelStyle(.titleOnly)
        }
    }
}

struct LabelViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        LabelViewDemo()
    }
}
