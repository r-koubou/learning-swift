
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("View List")
                    .font(.system(size: 32))
                    .fontWeight(.medium)
                
                Divider()
                
                    
                ScrollView {

                    VStack {
 
                        makeLinkView(AsyncScrollViewDemo.self){
                            AsyncScrollViewDemo()
                        }
                        
                        makeLinkView(TabViewDemo.self){
                            TabViewDemo()
                        }
                        
                        makeLinkView(TextFieldViewDemo.self){
                            TextFieldViewDemo()
                        }
                        
                        makeLinkView(ValueSelectorDemo.self){
                            ValueSelectorDemo()
                        }
                        
                        makeLinkView(LabelViewDemo.self){
                            LabelViewDemo()
                        }
                        
                        makeLinkView(ProgressViewDemo.self){
                            ProgressViewDemo()
                        }
                        
                        makeLinkView(FormDemo.self){
                            FormDemo()
                        }
                        makeLinkView(WebApiClientDemo.self){
                            WebApiClientDemo()
                        }
                        makeLinkView(AdvancedWebApiClientDemo.self){
                            AdvancedWebApiClientDemo()
                        }
                        makeLinkView(ImageFromBinaryDemo.self){
                            ImageFromBinaryDemo()
                        }
                    }
                }
                
            }
            .padding()
        }
    }
    
    private func makeLinkView<T>(
        _ type:T.Type,
        factory:() ->some View
    ) -> some View
    {
        NavigationLink(destination:factory()){
            Text(String(describing: type))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
