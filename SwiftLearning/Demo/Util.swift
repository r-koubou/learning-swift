import SwiftUI


func makeTitleText( _ title: String) -> Text
{
    Text(title)
        .fontWeight(.bold)
        .font(.system(size: 24))
}


func millisToNano(milliSecond: Int) -> UInt64
{
    return UInt64(milliSecond) * 1000000
}
