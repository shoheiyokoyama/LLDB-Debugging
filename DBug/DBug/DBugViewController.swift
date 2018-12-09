import UIKit

/*:
 # The Debugging with Xcode and LLDB

 ## The Debugging settings

    You can configure the behavior settings when pausing in the debugger.
    See Preferences / Befaviors / Pauses, for more details.

 ## The LLDB command

    The LLDB commands are all of the form:

    ```
    <noun> <verb> [-options [option-value]] [argument [argument...]]
    ```

    You can see the debugger commands with the help command.

    ```
    (lldb) help
    (lldb) help breakpoint
    ```

 ### Evaluating variable

    - `expression` or `expr`
        Evaluate an expression on the current thread. Displays any returned value with LLDB's default formatting.
        Syntax: `expression <cmd-options> -- <expr>`

        ```
        (lldb) po variable
        true
        (lldb) expr variable = false
        (lldb) po variable
        false
        ```

    - `print`
        `print` command takes no arguments, unlike the `expression` command.
        This is an abbreviation for `expression --`.
 
    - `po`
        `po` command is an abbreviation for `expression -O  --`.
        `expression -O  --` ( --object-description ):
            Display using a language-specific description API, if possible.
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

    /// Before running the animation, you can change animation behavior by changing the value at runtime.
    /// Let's set a breakpoint on this function and change the value.
    ///
    ///    1. Move point
    ///
    ///        If you run the following command in LLDB, button will move to `Point.leftBottom`.
    ///
    ///        ```
    ///        (lldb) expr currentPoint = .leftBottom
    ///        ```
    ///
    ///    2. Move direction
    ///
    ///        If you change `currentDirection` using LLDB, The position that `button` moves will change.
    ///
    ///        ```
    ///        (lldb) expr currentDirection = .random
    ///        ```
    ///
    ///    3. Update text
    ///
    ///       After updating `currentDirection`, let's update the Label's text.
    ///
    ///       ```
    ///       (lldb) expr titleLabel.text = "Direction: " + currentDirection.title
    ///       ```
    ///
    ///       - Note:
    ///           In suspended state, the frame isn't updated. To update, run the following command:
    ///
    ///               ```
    ///               (lldb) CATransaction.flush()
    ///               ```
    @objc private func selectButton(_ sender: UIButton) {
        currentPoint = currentPoint.next(direction: currentDirection)

        /* Set a breakpoint on this line */

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

    /// In addition to updating frame, you can add various animation processing at runtime.
    ///
    /// Action with Debugger command
    ///
    ///     1. Click `Edit Breakpoint ...` or double-click a breakpoint.
    ///     2. Click `Add Action`
    ///     3. Add command
    ///
    ///         e.g.
    ///         `expr self.button.transform  = self.button.transform.rotated(by: 90 * (.pi / 180))`
    ///         `expr self.button.layer.cornerRadius = 50`
    ///
    /// - Note:
    ///     If `automatically continue after evaluating actions` is checked,
    ///     processing will not stop at the breakpoint.
    private func runAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.button.frame = self.targetView(for: self.currentPoint).frame

            /* Set a breakpoint on this line */

        }
    }
}

extension DBugViewController {

    /// Point where the button moves
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

    /// Direction in which the button moves
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
