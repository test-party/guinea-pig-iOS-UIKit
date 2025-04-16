import UIKit
import SwiftUI

class SteppersViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    private var copies = 1
    private var tickets = 1
    
    private let darkGreen = UIColor(red: 0/255, green: 102/255, blue: 0/255, alpha: 1.0)
    private let darkRed = UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0)
    
    private var copiesTextField: UITextField!
    private var ticketsLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Steppers"
        view.backgroundColor = .systemBackground
        setupUI()
        
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Create scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Create content stack view
        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        // Add content
        addContentViews(to: contentStackView)
    }
    
    private func addContentViews(to stackView: UIStackView) {
        // Introduction Text
        let introLabel = UILabel()
        introLabel.text = "Steppers are used to increase or decrease incremental values. Use internal `Stepper` `Text(\"Label\")` to create a visible label that becomes the accessibility label for VoiceOver users."
        introLabel.numberOfLines = 0
        stackView.addArrangedSubview(introLabel)
        
        // Good Examples Header
        let goodExamplesHeader = createHeaderLabel(text: "Good Examples", color: darkGreen)
        stackView.addArrangedSubview(goodExamplesHeader)
        
        let goodDivider = createDivider(color: darkGreen)
        stackView.addArrangedSubview(goodDivider)
        
        // Good Example 1 Header
        let goodExample1Header = createHeaderLabel(text: "Good Example `Stepper` with `Text` label", color: .label)
        stackView.addArrangedSubview(goodExample1Header)
        
        // Good Stepper 1
        let goodStepperContainer1 = UIView()
        stackView.addArrangedSubview(goodStepperContainer1)
        
        ticketsLabel = UILabel()
        ticketsLabel.text = "Tickets: \(tickets)"
        ticketsLabel.translatesAutoresizingMaskIntoConstraints = false
        goodStepperContainer1.addSubview(ticketsLabel)
        
        let goodStepper1 = UIStepper()
        goodStepper1.value = Double(tickets)
        goodStepper1.minimumValue = 1
        goodStepper1.maximumValue = 100
        goodStepper1.addTarget(self, action: #selector(ticketsStepperChanged), for: .valueChanged)
        goodStepper1.accessibilityLabel = "Tickets: \(tickets)"
        goodStepper1.accessibilityIdentifier = "stepperGood1"
        goodStepper1.translatesAutoresizingMaskIntoConstraints = false
        goodStepperContainer1.addSubview(goodStepper1)
        
        NSLayoutConstraint.activate([
            ticketsLabel.leadingAnchor.constraint(equalTo: goodStepperContainer1.leadingAnchor),
            ticketsLabel.centerYAnchor.constraint(equalTo: goodStepperContainer1.centerYAnchor),
            
            goodStepper1.trailingAnchor.constraint(equalTo: goodStepperContainer1.trailingAnchor),
            goodStepper1.centerYAnchor.constraint(equalTo: goodStepperContainer1.centerYAnchor),
            
            goodStepperContainer1.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        // Good Example 1 Details
        let goodDetails1 = createDisclosureGroup(
            title: "Details",
            content: "The first good Stepper example uses `Text(\"Tickets: \\(tickets)\")` as the visible label text which becomes the VoiceOver accessibility label.",
            hint: "Good Example Btn `Stepper` with `Text` label"
        )
        stackView.addArrangedSubview(goodDetails1)
        
        // Good Example 2 Header
        let goodExample2Header = createHeaderLabel(text: "Good Example with `TextField` and `.accessibilityLabel`", color: .label)
        stackView.addArrangedSubview(goodExample2Header)
        
        // Good Stepper 2
        let goodStepperContainer2 = UIView()
        stackView.addArrangedSubview(goodStepperContainer2)
        
        let copiesLabel = UILabel()
        copiesLabel.text = "Copies"
        copiesLabel.translatesAutoresizingMaskIntoConstraints = false
        goodStepperContainer2.addSubview(copiesLabel)
        
        copiesTextField = UITextField()
        copiesTextField.borderStyle = .roundedRect
        copiesTextField.text = "\(copies)"
        copiesTextField.keyboardType = .numberPad
        copiesTextField.accessibilityLabel = "Copies"
        copiesTextField.delegate = self
        copiesTextField.translatesAutoresizingMaskIntoConstraints = false
        goodStepperContainer2.addSubview(copiesTextField)
        
        // Add toolbar with Done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.items = [flexSpace, doneButton]
        copiesTextField.inputAccessoryView = toolbar
        
        let goodStepper2 = UIStepper()
        goodStepper2.value = Double(copies)
        goodStepper2.minimumValue = 1
        goodStepper2.maximumValue = 100
        goodStepper2.addTarget(self, action: #selector(copiesStepperChanged), for: .valueChanged)
        goodStepper2.accessibilityLabel = "Copies"
        goodStepper2.accessibilityIdentifier = "stepperGood2"
        goodStepper2.translatesAutoresizingMaskIntoConstraints = false
        goodStepperContainer2.addSubview(goodStepper2)
        
        NSLayoutConstraint.activate([
            copiesLabel.leadingAnchor.constraint(equalTo: goodStepperContainer2.leadingAnchor),
            copiesLabel.centerYAnchor.constraint(equalTo: goodStepperContainer2.centerYAnchor),
            
            copiesTextField.leadingAnchor.constraint(equalTo: copiesLabel.trailingAnchor, constant: 8),
            copiesTextField.centerYAnchor.constraint(equalTo: goodStepperContainer2.centerYAnchor),
            copiesTextField.widthAnchor.constraint(equalToConstant: 60),
            
            goodStepper2.leadingAnchor.constraint(equalTo: copiesTextField.trailingAnchor, constant: 8),
            goodStepper2.trailingAnchor.constraint(equalTo: goodStepperContainer2.trailingAnchor),
            goodStepper2.centerYAnchor.constraint(equalTo: goodStepperContainer2.centerYAnchor),
            
            goodStepperContainer2.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        // Good Example 2 Details
        let goodDetails2 = createDisclosureGroup(
            title: "Details",
            content: "The second good Stepper example includes a text field so that users can quickly enter a large value, e.g., 50 copies. The Stepper uses `.accessibilityLabel(\"Copies\")` to create an accessibility label for VoiceOver because the visible stepper text is empty.",
            hint: "Good Example btn with `TextField` and `.accessibilityLabel`"
        )
        stackView.addArrangedSubview(goodDetails2)
        
        // Bad Examples Header
        let badExamplesHeader = createHeaderLabel(text: "Bad Examples", color: darkRed)
        stackView.addArrangedSubview(badExamplesHeader)
        
        let badDivider = createDivider(color: darkRed)
        stackView.addArrangedSubview(badDivider)
        
        // Bad Example 1 Header
        let badExample1Header = createHeaderLabel(text: "Bad Example `Stepper` with no `Text` label", color: .label)
        stackView.addArrangedSubview(badExample1Header)
        
        // Bad Stepper 1
        let badStepperContainer1 = UIView()
        stackView.addArrangedSubview(badStepperContainer1)
        
        let badTicketsLabel = UILabel()
        badTicketsLabel.text = "Tickets: \(tickets)"
        badTicketsLabel.translatesAutoresizingMaskIntoConstraints = false
        badStepperContainer1.addSubview(badTicketsLabel)
        
        let badStepper1 = UIStepper()
        badStepper1.value = Double(tickets)
        badStepper1.minimumValue = 1
        badStepper1.maximumValue = 100
        badStepper1.addTarget(self, action: #selector(ticketsStepperChanged), for: .valueChanged)
        badStepper1.accessibilityIdentifier = "stepperBad1"
        badStepper1.translatesAutoresizingMaskIntoConstraints = false
        badStepperContainer1.addSubview(badStepper1)
        
        NSLayoutConstraint.activate([
            badTicketsLabel.leadingAnchor.constraint(equalTo: badStepperContainer1.leadingAnchor),
            badTicketsLabel.centerYAnchor.constraint(equalTo: badStepperContainer1.centerYAnchor),
            
            badStepper1.trailingAnchor.constraint(equalTo: badStepperContainer1.trailingAnchor),
            badStepper1.centerYAnchor.constraint(equalTo: badStepperContainer1.centerYAnchor),
            
            badStepperContainer1.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        // Bad Example 1 Details
        let badDetails1 = createDisclosureGroup(
            title: "Details",
            content: "The first bad Stepper example has no internal `Stepper` label text so there is no accessibility label spoken to VoiceOver.",
            hint: "Bad Example `Stepper` with no `Text` label"
        )
        stackView.addArrangedSubview(badDetails1)
        
        // Bad Example 2 Header
        let badExample2Header = createHeaderLabel(text: "Bad Example no label text, no `.accessibilityLabel`, and no `TextField`", color: .label)
        stackView.addArrangedSubview(badExample2Header)
        
        // Bad Stepper 2
        let badStepperContainer2 = UIView()
        stackView.addArrangedSubview(badStepperContainer2)
        
        let badCopiesLabel = UILabel()
        badCopiesLabel.text = "Copies: \(copies)"
        badCopiesLabel.translatesAutoresizingMaskIntoConstraints = false
        badStepperContainer2.addSubview(badCopiesLabel)
        
        let badStepper2 = UIStepper()
        badStepper2.value = Double(copies)
        badStepper2.minimumValue = 1
        badStepper2.maximumValue = 100
        badStepper2.addTarget(self, action: #selector(badCopiesStepperChanged), for: .valueChanged)
        badStepper2.accessibilityIdentifier = "stepperBad2"
        badStepper2.translatesAutoresizingMaskIntoConstraints = false
        badStepperContainer2.addSubview(badStepper2)
        
        NSLayoutConstraint.activate([
            badCopiesLabel.leadingAnchor.constraint(equalTo: badStepperContainer2.leadingAnchor),
            badCopiesLabel.centerYAnchor.constraint(equalTo: badStepperContainer2.centerYAnchor),
            
            badStepper2.trailingAnchor.constraint(equalTo: badStepperContainer2.trailingAnchor),
            badStepper2.centerYAnchor.constraint(equalTo: badStepperContainer2.centerYAnchor),
            
            badStepperContainer2.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        // Bad Example 2 Details
        let badDetails2 = createDisclosureGroup(
            title: "Details",
            content: "The second bad Stepper example has no text field for users to quickly enter a large value, e.g., 50 copies. The Stepper has no internal label text and no `.accessibilityLabel` for VoiceOver users.",
            hint: "Bad Example no label text, no `.accessibilityLabel`, and no `TextField`"
        )
        stackView.addArrangedSubview(badDetails2)
    }
    
    // MARK: - Helper Methods
    private func createHeaderLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = color
        label.numberOfLines = 0
        label.accessibilityTraits = .header
        return label
    }
    
    private func createDivider(color: UIColor) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        divider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return divider
    }
    
    private func createDisclosureGroup(title: String, content: String, hint: String) -> UIView {
        let containerView = UIView()
        containerView.accessibilityHint = hint
        
        let button = UIButton(type: .system)
        button.setTitle("\(title) ▼", for: .normal)
        button.contentHorizontalAlignment = .left
        button.accessibilityLabel = hint
        button.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(button)
        
        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.numberOfLines = 0
        contentLabel.isHidden = true
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: containerView.topAnchor),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        button.addAction(UIAction { _ in
            contentLabel.isHidden.toggle()
            button.setTitle("\(title) \(contentLabel.isHidden ? "▼" : "▲")", for: .normal)
        }, for: .touchUpInside)
        
        return containerView
    }
    
    // MARK: - Actions
    @objc private func ticketsStepperChanged(_ sender: UIStepper) {
        tickets = Int(sender.value)
        ticketsLabel.text = "Tickets: \(tickets)"
        sender.accessibilityLabel = "Tickets: \(tickets)"
    }
    
    @objc private func copiesStepperChanged(_ sender: UIStepper) {
        copies = Int(sender.value)
        copiesTextField.text = "\(copies)"
    }
    
    @objc private func badCopiesStepperChanged(_ sender: UIStepper) {
        copies = Int(sender.value)
        // Update any related labels
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                for scrollSubview in scrollView.subviews {
                    if let stackView = scrollSubview as? UIStackView {
                        for arrangedSubview in stackView.arrangedSubviews {
                            for subsubview in arrangedSubview.subviews {
                                if let label = subsubview as? UILabel, label.text?.starts(with: "Copies:") == true {
                                    label.text = "Copies: \(copies)"
                                }
                            }
                        }
                    }
                }
            }
        }
        copiesTextField.text = "\(copies)"
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        
        // Update values from text field
        if let text = copiesTextField.text, let value = Int(text) {
            if value >= 1 && value <= 100 {
                copies = value
                // Update steppers
                for subview in view.subviews {
                    if let scrollView = subview as? UIScrollView {
                        for scrollSubview in scrollView.subviews {
                            if let stackView = scrollSubview as? UIStackView {
                                for arrangedSubview in stackView.arrangedSubviews {
                                    for subsubview in arrangedSubview.subviews {
                                        if let stepper = subsubview as? UIStepper,
                                           stepper.accessibilityIdentifier == "stepperGood2" ||
                                           stepper.accessibilityIdentifier == "stepperBad2" {
                                            stepper.value = Double(copies)
                                        }
                                        if let label = subsubview as? UILabel, label.text?.starts(with: "Copies:") == true {
                                            label.text = "Copies: \(copies)"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                // Reset to previous value if out of range
                copiesTextField.text = "\(copies)"
            }
        } else {
            // Reset to previous value if invalid
            copiesTextField.text = "\(copies)"
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == copiesTextField, let text = textField.text, let value = Int(text) {
            if value >= 1 && value <= 100 {
                copies = value
            } else {
                // Reset to previous value if out of range
                textField.text = "\(copies)"
            }
        }
    }
}

// MARK: - UIView Wrapper
struct UIKitStepperView: UIViewRepresentable {
    var configuration: ((UIView) -> Void)?
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        configuration?(view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        configuration?(uiView)
    }
}

// MARK: - UIViewController Wrapper
struct SteppersUIKitWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SteppersViewController {
        return SteppersViewController()
    }
    
    func updateUIViewController(_ uiViewController: SteppersViewController, context: Context) {
        // Updates from SwiftUI to UIKit (if needed)
    }
}

// MARK: - SwiftUI View
struct SteppersView: View {
    var body: some View {
        SteppersUIKitWrapper()
    }
}
