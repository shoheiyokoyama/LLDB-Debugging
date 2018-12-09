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

 ### Update UIKit

    It's possible to update the UI state at runtime.
    For example, background color, text, constraints.

        ```
        (lldb) expr label.text = "Direction: " + currentDirection.title
        ```

    - Note:
        In suspended state, the frame isn't updated. To update, run the following command:

            ```
            (lldb) expr CATransaction.flush()
            ```

        Flush is typically called automatically at the end of the current runloop, regardless of the runloop mode.

    - SeeAlso: [CATransaction / flush()](https://developer.apple.com/documentation/quartzcore/catransaction/1448270-flush)

 ### Symbolic Breakpoint

    Using the symbolic breakpoints. you can set a breakpoint based on a symbol, like a method or function name, regardless of where that name might appear in the code.
    You can set up a symbolic breakpoint for `-[UILabel setText:]` and it will be triggered any time that method is called.
 */

final class DBugViewController: UIViewController {

    @IBOutlet private weak var leftTopView: UIView!
    @IBOutlet private weak var rightTopView: UIView!
    @IBOutlet private weak var leftBottomView: UIView!
    @IBOutlet private weak var rightBottomView: UIView!

    /// Symbolic breakpoint for UILabel
    /// You can set up a symbolic breakpoint for `-[UILabel setText:]` and it will be triggered any time that method is called.
    /// Click the + button in the lower-left toolbar within the Breakpoint Navigator and choose `Add Symbolic Breakpoint…`.
    /// Add `-[UILabel setText:]` in Symbol or the the following command in LLDB:
    ///
    ///     ```
    ///     (lldb) breakpoint set --name "-[UILabel setText:]"
    ///     ```
    ///
    /// Arguments
    ///
    ///     In this state, you can see the arguments passed to the function.
    ///
    ///         ```
    ///         (lldb) po $arg1
    ///          <UILabel: 0x7fb1ae405cd0; frame = (0 0; 275 50); text = 'Direction: Clockwise 🕐'; opaque = NO; autoresize = RM+BM; userInteractionEnabled = NO; layer = <_UILabelLayer: 0x600000292ad0>>
    ///
    ///         (lldb) po (SEL)$arg2
    ///          "setText:"
    ///
    ///         (lldb) po $arg3
    ///         Direction: Clockwise 🕐
    ///         ```

    @IBOutlet private weak var directionLabel: UILabel! {
        didSet {
            directionLabel.text = "Direction: " + currentDirection.title
        }
    }

    @IBOutlet private weak var positionLabel: UILabel! {
        didSet {
            positionLabel.text = "Position: " + currentPoint.title
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
        b.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
        return b
    }()

    private var currentPoint = Point.leftTop

    private var currentDirection = AnimationDirection.clockwise

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: 0x222222)

        view.addSubview(button)
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
    ///    * Move point
    ///
    ///        If you run the following command in LLDB, button will move to `Point.leftBottom`.
    ///
    ///        ```
    ///        (lldb) expr currentPoint = .leftBottom
    ///        ```
    ///
    ///    * Move direction
    ///
    ///        If you change `currentDirection` using LLDB, The position that `button` moves will change.
    ///
    ///        ```
    ///        (lldb) expr currentDirection = .random
    ///        ```
    @objc private func selectButton(_ sender: UIButton) {
        currentPoint = currentPoint.next(direction: currentDirection)

        /* Set a breakpoint on this line */

        runAnimation()

        updateText()
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

    private func updateText() {
        directionLabel.text = "Direction: " + currentDirection.title
        positionLabel.text = "Position: " + currentPoint.title
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

        var title: String {
            switch self {
            case .leftTop:
                return "↖️"

            case .rightTop:
                return "↗️"

            case .rightBottom:
                return "↘️"

            case .leftBottom:
                return "↙️"
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
