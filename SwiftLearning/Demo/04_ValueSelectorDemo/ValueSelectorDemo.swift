import SwiftUI

struct ValueSelectorDemo: View {
    
    @State private var toggleValue = false
    @State private var sliderValue = 0.0
    @State private var stepperValue = 0
    @State private var pickerValue = 1
    @State private var dateValue = Date.now
    @State private var colorValue = Color.clear
    
    var body: some View {
        Group {
            ScrollView{
                VStack (alignment: .leading)
                {
                    toggleView()
                    sliderView()
                    stepperView()
                    pickerView()
                    datePickerView()
                    colorPickerView()
                    Spacer()
                }
            }
        }
        .padding()
    }
    
    private func toggleView() -> some View
    {
        Group
        {
            makeTitleText("Toggle")
            Toggle("Toggle", isOn: $toggleValue)
        }
    }
    
    private func sliderView() -> some View
    {
        Group
        {
            makeTitleText("Slider")
            Slider(
                value: $sliderValue,
                onEditingChanged: { editing in
                    
                }
            )
            Text(String(sliderValue))
        }
    }
    
    private func stepperView() -> some View
    {
        Group
        {
            makeTitleText("Stepper")
            Stepper("Stepper", value: $stepperValue, onEditingChanged: { edited in
            }
            )
            Text(String(stepperValue))
        }
    }
    
    private func pickerView() -> some View
    {
        Group
        {
            makeTitleText("Picker")
            Picker("Picker", selection: $pickerValue){
                Text("1").tag(0)
                Text("2").tag(1)
                Text("3").tag(2)
            }
        }
    }
    
    private func datePickerView() -> some View
    {
        Group
        {
            makeTitleText("DatePicker")
            DatePicker(
                "DatePicker",
                selection: $dateValue,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.wheel)
            //.datePickerStyle(.graphical)
            //.datePickerStyle(.compact)
        }
    }
    
    
    private func colorPickerView() -> some View
    {
        Group
        {
            makeTitleText("ColorPicker")
            ColorPicker(
                "Color",
                selection: $colorValue,
                supportsOpacity: false
            )
            .background(colorValue)
            
        }
    }
}

struct ValueSelectorDemo_Previews: PreviewProvider {
    static var previews: some View {
        ValueSelectorDemo()
    }
}
