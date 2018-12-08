import UIKit

final class DBugViewController: UIViewController {

    @IBOutlet private weak var leftTopView: UIView!
    @IBOutlet private weak var rightTopView: UIView!
    @IBOutlet private weak var leftBottomView: UIView!
    @IBOutlet private weak var rightBottomView: UIView!

    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = currentDirection.rawValue
        }
    }

    @IBOutlet private var cornerViews: [UIView]! {
        didSet {
            cornerViews
                .forEach { view in
                    view.layer.cornerRadius = 10
                    view.layer.borderWidth = 2
                    view.layer.borderColor = UIColor.lightGray.cgColor
                    view.backgroundColor = .clear
            }
        }
    }

    private let button: UIButton = {
        let b = UIButton()
        b.frame.size = CGSize(width: 100, height: 100)
        b.layer.cornerRadius = 10
        return b
    }()

    private var currentPoint = Point.leftTop {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.button.frame = self.targetView(for: self.currentPoint).frame
            }
        }
    }

    private var currentDirection = AnimationDirection.random

    override func viewDidLoad() {
        super.viewDidLoad()

        button.backgroundColor = .red
        view.addSubview(button)

        button.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = targetView(for: currentPoint).frame
    }

    @objc private func selectButton(_ sender: UIButton) {
        currentPoint = currentPoint.next(direction: currentDirection)
    }

    private func targetView(for point: Point) -> UIView {
        switch point {
        case .leftTop:
            return leftTopView
        case .rightTop:
            return rightTopView
        case .rightBottom:
            return rightBottomView
        case .leftBottom:
            return leftBottomView
        }
    }
}

private extension DBugViewController {
    enum Point: Int, CaseIterable {
        case leftTop
        case rightTop
        case rightBottom
        case leftBottom

        func next(direction: AnimationDirection) -> Point {
            let allCases = Point.allCases

            switch direction {
            case .clockwise:
                return allCases.first(where: { $0.rawValue > self.rawValue }) ?? .leftTop

            case .anticlockwise:
                return allCases.reversed().first(where: { $0.rawValue < self.rawValue }) ?? .leftBottom

            case .random:
                while let point = allCases.randomElement() {
                    if self != point {
                        return point
                    }
                }
                return .leftTop
            }
        }
    }

    enum AnimationDirection: String {
        case clockwise
        case anticlockwise
        case random
    }
}
