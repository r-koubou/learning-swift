import SwiftUI

struct FormDemo: View {
    
    @State private var accountName = ""
    @State private var accountPassword = ""
    @State private var streetAddress = ""
    @State private var phoneNumber = ""
    
    
    @State private var userAgreed = false
    
    var body: some View {
        VStack(alignment: .leading)
        {
            Form {
                
                Section(header: Text("Account")) {
                    TextField("e-mail", text: $accountName)
                    SecureField("password", text: $accountPassword)
                }
                Section(header: Text("Address")) {
                    TextField("Street", text: $streetAddress)
                    TextField("Phone", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }
            }
            
            Spacer()

            GroupBox(label: Label("GroupBox", systemImage: "checkmark.seal.fill")) {
                VStack(alignment: .leading) {
                    Text("Text")
                    .padding()
                    
                    Toggle(isOn: $userAgreed) {
                        Text("Toggle")
                    }
                }
            }
            
            //Color.clear.frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
}

struct FormDemo_Previews: PreviewProvider {
    static var previews: some View {
        FormDemo()
    }
}
