import UIKit

/*:
 # The Debugging with Xcode and LLDB

 ## The Debugging settings
    You can configure the behavior settings when pausing in the debugger.
    See Preferences / Befaviors / Pauses, for more details.
 */

final class DBugViewController: UIViewController {

    @IBOutlet private weak var leftTopView: UIView!
    @IBOutlet private weak var rightTopView: UIView!
    @IBOutlet private weak var leftBottomView: UIView!
    @IBOutlet private weak var rightBottomView: UIView!

    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Direction: " + currentDirection.title
        }
    }

    @IBOutlet private var cornerViews: [UIView]! {
        didSet {
            cornerViews
                .forEach { view in
                    view.layer.cornerRadius = 10
                    view.layer.borderWidth = 2
                    view.layer.borderColor = UIColor.lightGray.cgColor
                    view.backgroundColor = .black
            }
        }
    }

    private let button: GradientButton = {
        let b = GradientButton()
        b.frame.size = CGSize(width: 100, height: 100)
        b.layer.cornerRadius = 10
        b.gradientView.colors = [UIColor(hex: 0xFF28A5), UIColor(hex: 0x7934CF)]
        return b
    }()

    private var currentPoint = Point.leftTop

    private var currentDirection = AnimationDirection.clockwise

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: 0x222222)

        view.addSubview(button)

        button.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = targetView(for: currentPoint).frame
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc private func selectButton(_ sender: UIButton) {
        currentPoint = currentPoint.next(direction: currentDirection)
        runAnimation()
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

    private func runAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.button.frame = self.targetView(for: self.currentPoint).frame
        }
    }
}

extension DBugViewController {
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

    enum AnimationDirection {
        case clockwise
        case anticlockwise
        case random

        var title: String {
            switch self {
            case .clockwise:
                return "Clockwise 🕐"

            case .anticlockwise:
                return "Anticlockwise 🕒"

            case .random:
                return "Random ♻️"
            }
        }
    }
}
