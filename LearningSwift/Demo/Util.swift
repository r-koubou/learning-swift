import SwiftUI

func nameOfType<T>(_ t: T.Type) -> String
{
    return String(describing: t)
}

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
