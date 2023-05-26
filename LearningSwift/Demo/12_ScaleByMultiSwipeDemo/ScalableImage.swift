import UIKit
import SwiftUI

// UIKit でしかViewに対するスワイプ検知がサポートされていないため
// 内部的に UIKit を用いてSwiftUI View のラップをするサンプル (UIViewRepresentable)

struct ScalableImage: UIViewRepresentable
{
    let image: UIImage?
    
    init(imagePath: String) {
        self.image = UIImage(named:imagePath)
    }
    
    // UIKit の delegate 実装のためクラスで宣言
    // UIViewRepresentable.Self.Coordinator の型がこれになる
    class Coordinator: NSObject, UICollectionViewDelegate {
        // UICollectionViewDelegateのメソッドをここで実装する
        
        let imageView: UIImageView
        
        init(image: UIImage?) {
            imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
        }
    
        // UICollectionViewDelegate デリゲート実装
    
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imageView
        }
        
        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        }

        func scrollViewDidZoom(_ scrollView: UIScrollView) {
        }
        
    }
    
    // UIViewRepresentable プロトコル実装
    
    // Context.coordinator に格納する変数を生成
    func makeCoordinator() -> Coordinator {
        Coordinator(image: image)
    }
    
    // UIViewのViewを作成
    func makeUIView(context: Context) -> UIView {
        // UIKitの設定をここで行う

        let scrollView = UIScrollView()
        scrollView.maximumZoomScale = 8.0
        scrollView.minimumZoomScale = 1
        
        scrollView.addSubview(context.coordinator.imageView)
        
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    // View更新時に必要であれば UIView の更新
    func updateUIView(_ uiView: UIView, context: Context) {
        // Viewの更新が必要な場合にはここで行う
    }
}

struct ScalableImage_Previews: PreviewProvider {
    static var previews: some View {
        ScalableImage(imagePath: "sample1")
    }
}
