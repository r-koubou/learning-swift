import SwiftUI

struct TextFieldViewDemo: View {
    @State private var inputText: String = ""
    @State private var inputTextEditor: String = ""
    private let dateFormatter: DateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("Clear Text") {
                inputText = ""
            }
            Button("Random Text") {
                inputText += String((0..<1024).map { _ in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()! })
            }
            
            ScrollView {
                VStack(alignment: .leading){
                    
                    Divider()
                    
                    Text("Input Field").fontWeight(.heavy)
                    TextField("text", text: $inputText, axis: .horizontal)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .border(.gray)
                        .frame(minHeight: 40, maxHeight: 40)

                    VStack(alignment: .leading) {
                        Text("Output")
                            .fontWeight(.heavy)
                        ScrollView {
                            Text(inputText)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.topLeading)
                        }
                        .frame(minHeight: 120, maxHeight: 120)
                        .border(.gray)
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    }
                    
                    
                    Text("Text Editor").fontWeight(.heavy)
                    TextEditor(text: $inputTextEditor)
                        .frame(minHeight: 120, maxHeight: 120)
                        .border(.gray)
                    
                    VStack(alignment: .leading) {
                        Text("Output")
                            .fontWeight(.heavy)
                        ScrollView {
                            Text(inputTextEditor)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.topLeading)
                        }
                        .frame(minHeight: 120, maxHeight: 120)
                        .border(.gray)
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    }
                }
            }
            .padding()
        }
        .statusBarHidden(false)
    }
}

struct TextFieldViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldViewDemo()
    }
}
