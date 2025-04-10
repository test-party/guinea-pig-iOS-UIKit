import SwiftUI
import UIKit

class TogglesViewController: UIViewController {
    
    // MARK: - Properties
    private var toggleGoodOn1 = false
    private var toggleGoodOn2 = false
    private var toggleBadOn1 = false
    private var toggleBadOn2 = false
    private var isAustinBookmarked = false
    private var isCupertinoBookmarked = false
    private var isToggleOn = false
    
    private let darkGreen = UIColor(red: 0/255, green: 102/255, blue: 0/255, alpha: 1.0)
    private let darkRed = UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Toggles"
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Create a scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Create a content stack view
        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        
        // Set up constraints
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
        
        // Add content to stack view
        addContentViews(to: contentStackView)
    }
    
    private func addContentViews(to stackView: UIStackView) {
        // Introduction text
        let introLabel = UILabel()
        introLabel.text = "Toggles are used to switch between two options (also called switch controls). Use `Toggle` to create native toggle controls with an \"On\" and \"Off\" state. Use `Toggle(\"Label Text\")` to create label text. Give each `Toggle` without unique label text a specific `.accessibilityLabel`. Set the correct `.accessibilityValue` if the toggles have visible value text other than On and Off. A custom `.toggleStyle` can be used to customize the appearance and color of the toggle, e.g., to set the off state color to `Color.gray` which has 3:1 contrast ratio in the off state."
        introLabel.numberOfLines = 0
        stackView.addArrangedSubview(introLabel)
        
        // Good Examples Header
        let goodExamplesHeader = createHeaderLabel(text: "Good Examples", color: darkGreen)
        stackView.addArrangedSubview(goodExamplesHeader)
        
        let goodDivider = createDivider(color: darkGreen)
        stackView.addArrangedSubview(goodDivider)
        
        // Good Example 1 Header
        let goodExample1Header = createHeaderLabel(text: "Good Example `Toggle` with label text", color: .label)
        stackView.addArrangedSubview(goodExample1Header)
        
        // Good Example 1 Content
        let goodToggleContainer1 = UIView()
        goodToggleContainer1.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.addArrangedSubview(goodToggleContainer1)
        
        let goodLabel1 = UILabel()
        goodLabel1.text = "Use Face ID to log in."
        goodLabel1.translatesAutoresizingMaskIntoConstraints = false
        goodToggleContainer1.addSubview(goodLabel1)
        
        let goodSwitch1 = UISwitch()
        goodSwitch1.isOn = toggleGoodOn1
        goodSwitch1.addTarget(self, action: #selector(goodSwitch1Changed), for: .valueChanged)
        goodSwitch1.accessibilityIdentifier = "toggleGood1"
        goodSwitch1.translatesAutoresizingMaskIntoConstraints = false
        goodToggleContainer1.addSubview(goodSwitch1)
        
        NSLayoutConstraint.activate([
            goodLabel1.leadingAnchor.constraint(equalTo: goodToggleContainer1.layoutMarginsGuide.leadingAnchor),
            goodLabel1.centerYAnchor.constraint(equalTo: goodToggleContainer1.centerYAnchor),
            
            goodSwitch1.trailingAnchor.constraint(equalTo: goodToggleContainer1.layoutMarginsGuide.trailingAnchor),
            goodSwitch1.centerYAnchor.constraint(equalTo: goodToggleContainer1.centerYAnchor),
            
            goodToggleContainer1.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        // Configure accessibility for good toggle 1
        goodSwitch1.accessibilityLabel = "Use Face ID to log in."
        
        // Good Example 1 Details
        let goodDetails1 = createDisclosureGroup(
            title: "Details",
            content: "The first good toggle example uses a native `Toggle` with included label text. VoiceOver reads the accessibility label and the \"On\" and \"Off\" state.",
            hint: "Good Example `Toggle` with label text"
        )
        stackView.addArrangedSubview(goodDetails1)
        
        // Good Example 2 Header
        let goodExample2Header = createHeaderLabel(text: "Good Example `Toggle` with `.accessibilityLabel` and `.accessibilityValue`", color: .label)
        stackView.addArrangedSubview(goodExample2Header)
        
        // Display Mode Label
        let displayModeLabel = UILabel()
        displayModeLabel.text = "Display Mode"
        stackView.addArrangedSubview(displayModeLabel)
        
        // Good Example 2 Content
        let goodToggleContainer2 = UIView()
        goodToggleContainer2.layer.cornerRadius = 10
        goodToggleContainer2.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        goodToggleContainer2.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.addArrangedSubview(goodToggleContainer2)
        
        let lightLabel = UILabel()
        lightLabel.text = "Light"
        lightLabel.textColor = .white
        lightLabel.translatesAutoresizingMaskIntoConstraints = false
        goodToggleContainer2.addSubview(lightLabel)
        
        let goodSwitch2 = UISwitch()
        goodSwitch2.isOn = toggleGoodOn2
        goodSwitch2.onTintColor = .blue
        goodSwitch2.addTarget(self, action: #selector(goodSwitch2Changed), for: .valueChanged)
        goodSwitch2.accessibilityIdentifier = "toggleGood2"
        goodSwitch2.translatesAutoresizingMaskIntoConstraints = false
        goodToggleContainer2.addSubview(goodSwitch2)
        
        let darkLabel = UILabel()
        darkLabel.text = "Dark"
        darkLabel.textColor = .white
        darkLabel.translatesAutoresizingMaskIntoConstraints = false
        goodToggleContainer2.addSubview(darkLabel)
        
        NSLayoutConstraint.activate([
            lightLabel.leadingAnchor.constraint(equalTo: goodToggleContainer2.layoutMarginsGuide.leadingAnchor),
            lightLabel.centerYAnchor.constraint(equalTo: goodToggleContainer2.centerYAnchor),
            
            goodSwitch2.centerXAnchor.constraint(equalTo: goodToggleContainer2.centerXAnchor),
            goodSwitch2.centerYAnchor.constraint(equalTo: goodToggleContainer2.centerYAnchor),
            
            darkLabel.trailingAnchor.constraint(equalTo: goodToggleContainer2.layoutMarginsGuide.trailingAnchor),
            darkLabel.centerYAnchor.constraint(equalTo: goodToggleContainer2.centerYAnchor),
            
            goodToggleContainer2.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        // Configure accessibility for good toggle 2
        goodSwitch2.accessibilityLabel = "Display Mode"
        updateGoodSwitch2AccessibilityValue()
        
        // Set up tap gestures for the labels
        let lightTapGesture = UITapGestureRecognizer(target: self, action: #selector(lightLabelTapped))
        lightLabel.isUserInteractionEnabled = true
        lightLabel.addGestureRecognizer(lightTapGesture)
        
        let darkTapGesture = UITapGestureRecognizer(target: self, action: #selector(darkLabelTapped))
        darkLabel.isUserInteractionEnabled = true
        darkLabel.addGestureRecognizer(darkTapGesture)
        
        // Good Example 2 Details
        let goodDetails2 = createDisclosureGroup(
            title: "Details",
            content: "The second good toggle example uses `.toggleStyle(SwitchToggleStyle(tint: .blue))`. The `Toggle` label is hidden with `.labelsHidden()`. The values \"Light\" and \"Dark\" are also included in the `.accessibilityValue` so that VoiceOver speaks \"Light\" and \"Dark\" instead of \"On\" and \"Off\".",
            hint: "Good Example `Toggle` with `.accessibilityLabel` and `.accessibilityValue`"
        )
        stackView.addArrangedSubview(goodDetails2)
        
        // Good Example 3 Header
        let goodExample3Header = createHeaderLabel(text: "Good Example `.toggleStyle(.button)` and unique `.accessibilityLabel`", color: .label)
        stackView.addArrangedSubview(goodExample3Header)
        
        // Locations Label
        let locationsLabel = UILabel()
        locationsLabel.text = "Locations"
        stackView.addArrangedSubview(locationsLabel)
        
        // Good Example 3 Content - Cupertino
        let cupertinoContainer = UIView()
        stackView.addArrangedSubview(cupertinoContainer)
        
        let cupertinoLabel = UILabel()
        cupertinoLabel.text = "Cupertino"
        cupertinoLabel.translatesAutoresizingMaskIntoConstraints = false
        cupertinoContainer.addSubview(cupertinoLabel)
        
        let cupertinoButton = UIButton(type: .system)
        cupertinoButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        cupertinoButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        cupertinoButton.isSelected = isCupertinoBookmarked
        cupertinoButton.addTarget(self, action: #selector(cupertinoBookmarkTapped), for: .touchUpInside)
        cupertinoButton.accessibilityIdentifier = "toggleGood3a"
        cupertinoButton.translatesAutoresizingMaskIntoConstraints = false
        cupertinoContainer.addSubview(cupertinoButton)
        
        NSLayoutConstraint.activate([
            cupertinoLabel.leadingAnchor.constraint(equalTo: cupertinoContainer.leadingAnchor),
            cupertinoLabel.centerYAnchor.constraint(equalTo: cupertinoContainer.centerYAnchor),
            cupertinoLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            cupertinoButton.leadingAnchor.constraint(equalTo: cupertinoLabel.trailingAnchor, constant: 8),
            cupertinoButton.centerYAnchor.constraint(equalTo: cupertinoContainer.centerYAnchor),
            
            cupertinoContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        // Configure accessibility for Cupertino button
        cupertinoButton.accessibilityLabel = "Bookmark Cupertino Location"
        cupertinoButton.accessibilityTraits = isCupertinoBookmarked ? [.button, .selected] : .button
        
        // Good Example 3 Content - Austin
        let austinContainer = UIView()
        stackView.addArrangedSubview(austinContainer)
        
        let austinLabel = UILabel()
        austinLabel.text = "Austin"
        austinLabel.translatesAutoresizingMaskIntoConstraints = false
        austinContainer.addSubview(austinLabel)
        
        let austinButton = UIButton(type: .system)
        austinButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        austinButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        austinButton.isSelected = isAustinBookmarked
        austinButton.addTarget(self, action: #selector(austinBookmarkTapped), for: .touchUpInside)
        austinButton.accessibilityIdentifier = "toggleGood3b"
        austinButton.translatesAutoresizingMaskIntoConstraints = false
        austinContainer.addSubview(austinButton)
        
        NSLayoutConstraint.activate([
            austinLabel.leadingAnchor.constraint(equalTo: austinContainer.leadingAnchor),
            austinLabel.centerYAnchor.constraint(equalTo: austinContainer.centerYAnchor),
            austinLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            austinButton.leadingAnchor.constraint(equalTo: austinLabel.trailingAnchor, constant: 8),
            austinButton.centerYAnchor.constraint(equalTo: austinContainer.centerYAnchor),
            
            austinContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        // Configure accessibility for Austin button
        austinButton.accessibilityLabel = "Bookmark Austin Location"
        austinButton.accessibilityTraits = isAustinBookmarked ? [.button, .selected] : .button
        
        // Good Example 3 Details
        let goodDetails3 = createDisclosureGroup(
            title: "Details",
            content: "The third good toggle example uses `.toggleStyle(.button)` and includes unique and specific `.accessibilityLabel` text for each bookmark button. `sensoryFeedback(_:trigger:)` is used to provide haptic feedback felt by users when they toggle the buttons.",
            hint: "Good Example `.toggleStyle(.button)` and unique `.accessibilityLabel`"
        )
        stackView.addArrangedSubview(goodDetails3)
        
        // Good Example 4 Header
        let goodExample4Header = createHeaderLabel(text: "Good Example Custom `.toggleStyle`", color: .label)
        stackView.addArrangedSubview(goodExample4Header)
        
        // Good Example 4 Content - Custom Toggle
        let goodCustomToggleContainer = UIView()
        stackView.addArrangedSubview(goodCustomToggleContainer)
        
        let goodCustomToggleView = createCustomToggle(isOn: isToggleOn, onColor: .green, offColor: .gray)
        goodCustomToggleView.translatesAutoresizingMaskIntoConstraints = false
        goodCustomToggleContainer.addSubview(goodCustomToggleView)
        
        NSLayoutConstraint.activate([
            goodCustomToggleView.leadingAnchor.constraint(equalTo: goodCustomToggleContainer.leadingAnchor, constant: 16),
            goodCustomToggleView.topAnchor.constraint(equalTo: goodCustomToggleContainer.topAnchor, constant: 16),
            goodCustomToggleView.bottomAnchor.constraint(equalTo: goodCustomToggleContainer.bottomAnchor, constant: -16),
            
            goodCustomToggleContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
        
        // Add tap gesture for the custom toggle
        let goodCustomToggleTap = UITapGestureRecognizer(target: self, action: #selector(goodCustomToggleTapped))
        goodCustomToggleView.isUserInteractionEnabled = true
        goodCustomToggleView.addGestureRecognizer(goodCustomToggleTap)
        
        // Configure accessibility for custom toggle
        goodCustomToggleView.isAccessibilityElement = true
        goodCustomToggleView.accessibilityLabel = "Use Face ID to log in."
        goodCustomToggleView.accessibilityTraits = isToggleOn ? .selected : []
        goodCustomToggleView.accessibilityValue = isToggleOn ? "On" : "Off"
        
        // Good Example 4 Details
        let goodDetails4 = createDisclosureGroup(
            title: "Details",
            content: "The good custom `.toggleStyle` example uses `.toggleStyle(ColoredToggleStyle())` which customizes the appearance and color of the toggle and sets the off state color to `Color.gray` which has 3:1 contrast ratio in the off state. `sensoryFeedback(_:trigger:)` is used to provide haptic feedback felt by users when they toggle the custom switch.",
            hint: "Good Example Custom `.toggleStyle`"
        )
        stackView.addArrangedSubview(goodDetails4)
        
        // Bad Examples Header
        let badExamplesHeader = createHeaderLabel(text: "Bad Examples", color: darkRed)
        stackView.addArrangedSubview(badExamplesHeader)
        
        let badDivider = createDivider(color: darkRed)
        stackView.addArrangedSubview(badDivider)
        
        // Bad Example 1 Header
        let badExample1Header = createHeaderLabel(text: "Bad Example `Toggle` with no label text", color: .label)
        stackView.addArrangedSubview(badExample1Header)
        
        // Bad Example 1 Content
        let badToggleContainer1 = UIView()
        badToggleContainer1.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.addArrangedSubview(badToggleContainer1)
        
        let badLabel1 = UILabel()
        badLabel1.text = "Use Face ID to log in."
        badLabel1.translatesAutoresizingMaskIntoConstraints = false
        badToggleContainer1.addSubview(badLabel1)
        
        let badSwitch1 = UISwitch()
        badSwitch1.isOn = toggleBadOn1
        badSwitch1.addTarget(self, action: #selector(badSwitch1Changed), for: .valueChanged)
        badSwitch1.accessibilityIdentifier = "toggleBad1"
        badSwitch1.translatesAutoresizingMaskIntoConstraints = false
        badToggleContainer1.addSubview(badSwitch1)
        
        NSLayoutConstraint.activate([
            badLabel1.leadingAnchor.constraint(equalTo: badToggleContainer1.layoutMarginsGuide.leadingAnchor),
            badLabel1.centerYAnchor.constraint(equalTo: badToggleContainer1.centerYAnchor),
            
            badSwitch1.trailingAnchor.constraint(equalTo: badToggleContainer1.layoutMarginsGuide.trailingAnchor),
            badSwitch1.centerYAnchor.constraint(equalTo: badToggleContainer1.centerYAnchor),
            
            badToggleContainer1.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        // Bad Example 1 Details
        let badDetails1 = createDisclosureGroup(
            title: "Details",
            content: "The first bad toggle example uses `Toggle(\"\").labelsHidden()` to remove the label text. A separate `Text()` element is placed next to the toggle which is not spoken to VoiceOver as the accessibility label.",
            hint: "Bad Example `Toggle` with no label text"
        )
        stackView.addArrangedSubview(badDetails1)
        
        // Bad Example 2 Header
        let badExample2Header = createHeaderLabel(text: "Bad Example `Toggle` with no `.accessibilityLabel` and no `.accessibilityValue`", color: .label)
        stackView.addArrangedSubview(badExample2Header)
        
        // Display Mode Label for Bad Example 2
        let badDisplayModeLabel = UILabel()
        badDisplayModeLabel.text = "Display Mode"
        stackView.addArrangedSubview(badDisplayModeLabel)
        
        // Bad Example 2 Content
        let badToggleContainer2 = UIView()
        badToggleContainer2.layer.cornerRadius = 10
        badToggleContainer2.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        badToggleContainer2.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.addArrangedSubview(badToggleContainer2)
        
        let badLightLabel = UILabel()
        badLightLabel.text = "Light"
        badLightLabel.textColor = .gray
        badLightLabel.translatesAutoresizingMaskIntoConstraints = false
        badToggleContainer2.addSubview(badLightLabel)
        
        let badSwitch2 = UISwitch()
        badSwitch2.isOn = toggleBadOn2
        badSwitch2.onTintColor = .blue
        badSwitch2.addTarget(self, action: #selector(badSwitch2Changed), for: .valueChanged)
        badSwitch2.accessibilityIdentifier = "toggleBad2"
        badSwitch2.translatesAutoresizingMaskIntoConstraints = false
        badToggleContainer2.addSubview(badSwitch2)
        
        let badDarkLabel = UILabel()
        badDarkLabel.text = "Dark"
        badDarkLabel.textColor = .blue
        badDarkLabel.translatesAutoresizingMaskIntoConstraints = false
        badToggleContainer2.addSubview(badDarkLabel)
        
        NSLayoutConstraint.activate([
            badLightLabel.leadingAnchor.constraint(equalTo: badToggleContainer2.layoutMarginsGuide.leadingAnchor),
            badLightLabel.centerYAnchor.constraint(equalTo: badToggleContainer2.centerYAnchor),
            
            badSwitch2.centerXAnchor.constraint(equalTo: badToggleContainer2.centerXAnchor),
            badSwitch2.centerYAnchor.constraint(equalTo: badToggleContainer2.centerYAnchor),
            
            badDarkLabel.trailingAnchor.constraint(equalTo: badToggleContainer2.layoutMarginsGuide.trailingAnchor),
            badDarkLabel.centerYAnchor.constraint(equalTo: badToggleContainer2.centerYAnchor),
            
            badToggleContainer2.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        // Bad Example 2 Details
        let badDetails2 = createDisclosureGroup(
            title: "Details",
            content: "The second bad toggle example hides its label using `.labelsHidden()` and does not provide an `.accessibilityLabel`. The values \"Light\" and \"Dark\" are not included in the `.accessibilityValue` so VoiceOver incorrectly speaks \"On\" and \"Off\" instead of \"Light\" and \"Dark\".",
            hint: "Bad Example `Toggle` with no `.accessibilityLabel` and no `.accessibilityValue`"
        )
        stackView.addArrangedSubview(badDetails2)
        
        // Bad Example 3 Header
        let badExample3Header = createHeaderLabel(text: "Bad Example `.toggleStyle(.button)` and no unique `.accessibilityLabel`", color: .label)
        stackView.addArrangedSubview(badExample3Header)
        
        // Bad Example 3 Locations Label
        let badLocationsLabel = UILabel()
        badLocationsLabel.text = "Locations"
        stackView.addArrangedSubview(badLocationsLabel)
        
        // Bad Example 3 Content - Cupertino
        let badCupertinoContainer = UIView()
        stackView.addArrangedSubview(badCupertinoContainer)
        
        let badCupertinoLabel = UILabel()
        badCupertinoLabel.text = "Cupertino"
        badCupertinoLabel.translatesAutoresizingMaskIntoConstraints = false
        badCupertinoContainer.addSubview(badCupertinoLabel)
        
        let badCupertinoButton = UIButton(type: .system)
        badCupertinoButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        badCupertinoButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        badCupertinoButton.isSelected = isCupertinoBookmarked
        badCupertinoButton.addTarget(self, action: #selector(badCupertinoBookmarkTapped), for: .touchUpInside)
        badCupertinoButton.accessibilityIdentifier = "toggleBad3a"
        badCupertinoButton.translatesAutoresizingMaskIntoConstraints = false
        badCupertinoContainer.addSubview(badCupertinoButton)
        
        NSLayoutConstraint.activate([
            badCupertinoLabel.leadingAnchor.constraint(equalTo: badCupertinoContainer.leadingAnchor),
            badCupertinoLabel.centerYAnchor.constraint(equalTo: badCupertinoContainer.centerYAnchor),
            badCupertinoLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            badCupertinoButton.leadingAnchor.constraint(equalTo: badCupertinoLabel.trailingAnchor, constant: 8),
            badCupertinoButton.centerYAnchor.constraint(equalTo: badCupertinoContainer.centerYAnchor),
            
            badCupertinoContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        // Bad Example 3 Content - Austin
        let badAustinContainer = UIView()
        stackView.addArrangedSubview(badAustinContainer)
        
        let badAustinLabel = UILabel()
        badAustinLabel.text = "Austin"
        badAustinLabel.translatesAutoresizingMaskIntoConstraints = false
        badAustinContainer.addSubview(badAustinLabel)
        
        let badAustinButton = UIButton(type: .system)
        badAustinButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        badAustinButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        badAustinButton.isSelected = isAustinBookmarked
        badAustinButton.addTarget(self, action: #selector(badAustinBookmarkTapped), for: .touchUpInside)
        badAustinButton.accessibilityIdentifier = "toggleBad3b"
        badAustinButton.translatesAutoresizingMaskIntoConstraints = false
        badAustinContainer.addSubview(badAustinButton)
        
        NSLayoutConstraint.activate([
            badAustinLabel.leadingAnchor.constraint(equalTo: badAustinContainer.leadingAnchor),
            badAustinLabel.centerYAnchor.constraint(equalTo: badAustinContainer.centerYAnchor),
            badAustinLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            badAustinButton.leadingAnchor.constraint(equalTo: badAustinLabel.trailingAnchor, constant: 8),
            badAustinButton.centerYAnchor.constraint(equalTo: badAustinContainer.centerYAnchor),
            
            badAustinContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        // Bad Example 3 Details
        let badDetails3 = createDisclosureGroup(
            title: "Details",
            content: "The third bad toggle example uses `.toggleStyle(.button)` and does not include unique and specific `.accessibilityLabel` text for each bookmark button.",
            hint: "Bad Example `.toggleStyle(.button)` and no unique `.accessibilityLabel`"
        )
        stackView.addArrangedSubview(badDetails3)
        
        // Bad Example 4 Header
        let badExample4Header = createHeaderLabel(text: "Bad Example Custom `.toggleStyle`", color: .label)
        stackView.addArrangedSubview(badExample4Header)
        
        // Bad Example 4 Content - Custom Toggle
        let badCustomToggleContainer = UIView()
        stackView.addArrangedSubview(badCustomToggleContainer)
        
        let badCustomToggleView = createCustomToggle(
            isOn: isToggleOn,
            onColor: .green,
            offColor: UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        )
        badCustomToggleView.translatesAutoresizingMaskIntoConstraints = false
        badCustomToggleContainer.addSubview(badCustomToggleView)
        
        NSLayoutConstraint.activate([
            badCustomToggleView.leadingAnchor.constraint(equalTo: badCustomToggleContainer.leadingAnchor, constant: 16),
            badCustomToggleView.topAnchor.constraint(equalTo: badCustomToggleContainer.topAnchor, constant: 16),
            badCustomToggleView.bottomAnchor.constraint(equalTo: badCustomToggleContainer.bottomAnchor, constant: -16),
            
            badCustomToggleContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
        
        // Add tap gesture for the bad custom toggle
        let badCustomToggleTap = UITapGestureRecognizer(target: self, action: #selector(badCustomToggleTapped))
        badCustomToggleView.isUserInteractionEnabled = true
        badCustomToggleView.addGestureRecognizer(badCustomToggleTap)
        
        // Configure accessibility for bad custom toggle
        badCustomToggleView.isAccessibilityElement = true
        badCustomToggleView.accessibilityLabel = "Use Face ID to log in."
        badCustomToggleView.accessibilityTraits = isToggleOn ? .selected : []
        badCustomToggleView.accessibilityValue = isToggleOn ? "On" : "Off"
        
        // Bad Example 4 Details
        let badDetails4 = createDisclosureGroup(
            title: "Details",
            content: "The bad custom `.toggleStyle` example uses `.toggleStyle(ColoredToggleStyleBad())` which customizes the appearance and color of the toggle and sets the off state color to `Color(red: 240 / 255, green: 240 / 255, blue: 240 / 255)` which does not have a 3:1 contrast ratio in the off state.",
            hint: "Bad Example Custom `.toggleStyle`"
        )
        stackView.addArrangedSubview(badDetails4)
    }
    
    // MARK: - Custom Toggle
    private func createCustomToggle(isOn: Bool, onColor: UIColor, offColor: UIColor) -> UIView {
        let containerView = UIView()
        
        let label = UILabel()
        label.text = "Use Face ID to log in."
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        
        let toggleBackgroundView = UIView()
        toggleBackgroundView.backgroundColor = isOn ? onColor : offColor
        toggleBackgroundView.layer.cornerRadius = 15
        toggleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(toggleBackgroundView)
        
        let toggleThumbView = UIView()
        toggleThumbView.backgroundColor = .white
        toggleThumbView.layer.cornerRadius = 13.5
        toggleThumbView.layer.shadowRadius = 1
        toggleThumbView.layer.shadowOpacity = 0.5
        toggleThumbView.layer.shadowOffset = CGSize(width: 0, height: 1)
        toggleThumbView.translatesAutoresizingMaskIntoConstraints = false
        toggleBackgroundView.addSubview(toggleThumbView)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            toggleBackgroundView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            toggleBackgroundView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            toggleBackgroundView.widthAnchor.constraint(equalToConstant: 50),
            toggleBackgroundView.heightAnchor.constraint(equalToConstant: 30),
            
            toggleThumbView.centerYAnchor.constraint(equalTo: toggleBackgroundView.centerYAnchor),
            toggleThumbView.widthAnchor.constraint(equalToConstant: 27),
            toggleThumbView.heightAnchor.constraint(equalToConstant: 27),
            toggleThumbView.leadingAnchor.constraint(equalTo: toggleBackgroundView.leadingAnchor, constant: isOn ? 20 : 3)
        ])
        
        return containerView
    }
    
    // MARK: - UI Helpers
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
    
    private func updateGoodSwitch2AccessibilityValue() {
        if let view = view.viewWithTag(200) as? UISwitch {
            view.accessibilityValue = toggleGoodOn2 ? "Dark" : "Light"
        }
    }
    
    // MARK: - Actions
    @objc private func goodSwitch1Changed(_ sender: UISwitch) {
        toggleGoodOn1 = sender.isOn
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    @objc private func goodSwitch2Changed(_ sender: UISwitch) {
        toggleGoodOn2 = sender.isOn
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        sender.accessibilityValue = toggleGoodOn2 ? "Dark" : "Light"
    }
    
    @objc private func lightLabelTapped() {
        toggleGoodOn2 = false
        if let view = view.viewWithTag(200) as? UISwitch {
            view.setOn(false, animated: true)
            view.accessibilityValue = "Light"
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    @objc private func darkLabelTapped() {
        toggleGoodOn2 = true
        if let view = view.viewWithTag(200) as? UISwitch {
            view.setOn(true, animated: true)
            view.accessibilityValue = "Dark"
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    @objc private func cupertinoBookmarkTapped(_ sender: UIButton) {
        isCupertinoBookmarked.toggle()
        sender.isSelected = isCupertinoBookmarked
        sender.accessibilityTraits = isCupertinoBookmarked ? [.button, .selected] : .button
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    @objc private func austinBookmarkTapped(_ sender: UIButton) {
        isAustinBookmarked.toggle()
        sender.isSelected = isAustinBookmarked
        sender.accessibilityTraits = isAustinBookmarked ? [.button, .selected] : .button
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    @objc private func goodCustomToggleTapped(_ sender: UITapGestureRecognizer) {
        isToggleOn.toggle()
        
        if let view = sender.view {
            // Update the custom toggle UI
            for subview in view.subviews {
                if let toggleBackground = subview as? UIView, toggleBackground.layer.cornerRadius == 15 {
                    toggleBackground.backgroundColor = isToggleOn ? .green : .gray
                    
                    for thumbView in toggleBackground.subviews {
                        if thumbView.layer.cornerRadius == 13.5 {
                            UIView.animate(withDuration: 0.2) {
                                thumbView.frame.origin.x = self.isToggleOn ? 20 : 3
                            }
                        }
                    }
                }
            }
            
            // Update accessibility properties
            view.accessibilityTraits = isToggleOn ? .selected : []
            view.accessibilityValue = isToggleOn ? "On" : "Off"
        }
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    @objc private func badCustomToggleTapped(_ sender: UITapGestureRecognizer) {
        isToggleOn.toggle()
        
        if let view = sender.view {
            // Update the custom toggle UI
            for subview in view.subviews {
                if let toggleBackground = subview as? UIView, toggleBackground.layer.cornerRadius == 15 {
                    toggleBackground.backgroundColor = isToggleOn ? .green : UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
                    
                    for thumbView in toggleBackground.subviews {
                        if thumbView.layer.cornerRadius == 13.5 {
                            UIView.animate(withDuration: 0.2) {
                                thumbView.frame.origin.x = self.isToggleOn ? 20 : 3
                            }
                        }
                    }
                }
            }
            
            // Update accessibility properties
            view.accessibilityTraits = isToggleOn ? .selected : []
            view.accessibilityValue = isToggleOn ? "On" : "Off"
        }
    }
    
    @objc private func badSwitch1Changed(_ sender: UISwitch) {
        toggleBadOn1 = sender.isOn
    }
    
    @objc private func badSwitch2Changed(_ sender: UISwitch) {
        toggleBadOn2 = sender.isOn
    }
    
    @objc private func badCupertinoBookmarkTapped(_ sender: UIButton) {
        isCupertinoBookmarked.toggle()
        sender.isSelected = isCupertinoBookmarked
    }
    
    @objc private func badAustinBookmarkTapped(_ sender: UIButton) {
        isAustinBookmarked.toggle()
        sender.isSelected = isAustinBookmarked
    }
}

// MARK: - UIViewRepresentable Wrapper for Individual UIKit Views
struct UIKitToggleView: UIViewRepresentable {
    typealias UIViewType = UISwitch
    
    @Binding var isOn: Bool
    var label: String
    var onChange: ((Bool) -> Void)?
    
    func makeUIView(context: Context) -> UISwitch {
        let toggle = UISwitch()
        toggle.isOn = isOn
        toggle.addTarget(context.coordinator, action: #selector(Coordinator.toggleChanged(_:)), for: .valueChanged)
        toggle.accessibilityLabel = label
        return toggle
    }
    
    func updateUIView(_ uiView: UISwitch, context: Context) {
        uiView.isOn = isOn
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: UIKitToggleView
        
        init(_ parent: UIKitToggleView) {
            self.parent = parent
        }
        
        @objc func toggleChanged(_ sender: UISwitch) {
            parent.isOn = sender.isOn
            parent.onChange?(sender.isOn)
        }
    }
}

// MARK: - UIViewControllerRepresentable Wrapper for the ViewController
struct TogglesUIKitWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TogglesViewController {
        return TogglesViewController()
    }
    
    func updateUIViewController(_ uiViewController: TogglesViewController, context: Context) {
        // Updates from SwiftUI to UIKit (if needed)
    }
}

// MARK: - SwiftUI View
struct TogglesView: View {
    var body: some View {
        TogglesUIKitWrapper()
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview Provider
struct TogglesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TogglesView()
        }
    }
}
