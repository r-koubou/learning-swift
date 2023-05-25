import SwiftUI

struct LocalizationDemo: View {

    @State private var localeIndex = 0

    
    var body: some View {
        Group {
            VStack (alignment: .leading) {
                Spacer()
                
                makeTitleText("Localized text")
                Text("key_hello")
                
                Spacer()
                
                makeTitleText("Language")
                
                Picker("Picker", selection: $localeIndex){
                    Text("en").tag(0)
                    Text("ja").tag(1)
                }
                .pickerStyle(.wheel)
            }
            .padding()
        }
        .environment(\.locale, Locale(identifier: localeIndex == 0 ? "en" : "ja"))
    }
}

struct LocalizationDemo_Previews: PreviewProvider {
    static var previews: some View {
        LocalizationDemo()
    }
}
