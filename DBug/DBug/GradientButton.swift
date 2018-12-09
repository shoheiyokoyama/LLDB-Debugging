import UIKit

final class GradientButton: UIButton {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    var gradientColors: [UIColor] = [] {
        didSet {
            (layer as? CAGradientLayer)?.colors = gradientColors.map { $0.cgColor }
        }
    }
}
