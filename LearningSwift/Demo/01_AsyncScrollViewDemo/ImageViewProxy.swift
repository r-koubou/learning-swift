import SwiftUI

struct ImageViewProxy
{
    private init () {}

    static func create(
        path: String,
        width: CGFloat,
        height: CGFloat,
        imageHandle: @escaping (Image) -> some View,
        asyncImageHandle: @escaping (Image) -> some View,
        placeholderHandle: @escaping () -> some View,
        failedHandle: @escaping (Error) -> some View = {err in EmptyView()}
    )
    -> some View
    {
        Group {
            if path.starts(with: "http"){
                AsyncImage(url: URL(string: path)) { phase in
                    if let image = phase.image {
                        asyncImageHandle(image)
                    } else if let error = phase.error {
                        failedHandle(error)
                    } else {
                        placeholderHandle()
                    }
                }
            } else {
                imageHandle(Image(path))
            }
        }.frame(width: width, height: height)
    }
}

