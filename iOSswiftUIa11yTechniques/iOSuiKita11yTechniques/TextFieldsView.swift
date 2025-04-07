import SwiftUI
import UIKit

class TextFieldsViewController: UIViewController {
    
    // MARK: - Properties
    // Good example properties
    private var text = ""
    private var username = ""
    private var password = ""
    private var fname = ""
    private var lname = ""
    private var phone = ""
    private var email = ""
    private var address = ""
    private var address2 = ""
    private var city = ""
    private var state = ""
    private var website = ""
    private var bmonth = ""
    private var bday = ""
    private var byear = ""
    private var birthday = ""
    
    // Bad example properties
    private var usernameBad = ""
    private var passwordBad = ""
    private var fnameBad = ""
    private var lnameBad = ""
    private var phoneBad = ""
    private var emailBad = ""
    private var addressBad = ""
    private var address2Bad = ""
    private var cityBad = ""
    private var stateBad = ""
    private var websiteBad = ""
    
    private let darkGreen = UIColor(red: 0/255, green: 102/255, blue: 0/255, alpha: 1.0)
    private let darkRed = UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0)
    
    private var scrollView: UIScrollView!
    private var contentStackView: UIStackView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Text Fields"
        view.backgroundColor = .systemBackground
        setupUI()
        
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Setup scroll view
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Setup content stack view
        contentStackView = UIStackView()
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
        
        // Add content
        setupContent()
    }
    
    private func setupContent() {
        // Introduction text
        let introLabel = UILabel()
        introLabel.numberOfLines = 0
        introLabel.text = "Text fields require visible label text next to the field set as the `.accessibilityLabel` of the `TextField`. Or provide visible labels using `LabeledContent` and then an `.accessibilityLabel` is not required. Don't use `.labeledContentStyle(.vertical)` or else VoiceOver won't be able to double tap to activate the `TextField`. Don't use placeholder text which has insufficient contrast and disappears. Use `.textFieldStyle(.roundedBorder)` to make the `TextField` visually identifiable. Use `.border(.secondary)` to give the border a 3:1 contrast ratio in light and dark mode. Use `.keyboardType` to specify the keyboard displayed on input. Use `.textContentType` to enable form AutoFill for each `TextField`."
        contentStackView.addArrangedSubview(introLabel)
        
        // Good Examples Header
        let goodExamplesHeader = createHeaderLabel(text: "Good Examples", color: darkGreen)
        contentStackView.addArrangedSubview(goodExamplesHeader)
        
        let goodDivider = createDivider(color: darkGreen)
        contentStackView.addArrangedSubview(goodDivider)
        
        // Good Example 1 Header
        let goodExample1Header = createHeaderLabel(text: "Good Example Using `.accessibilityLabel`", color: .label)
        contentStackView.addArrangedSubview(goodExample1Header)
        
        // First Name
        contentStackView.addArrangedSubview(createLabel(text: "First Name"))
        let fnameTextField = createTextField(placeholder: "", tag: 1)
        fnameTextField.accessibilityLabel = "First Name"
        fnameTextField.autocorrectionType = .no
        fnameTextField.textContentType = .givenName
        fnameTextField.accessibilityIdentifier = "fNameGood"
        contentStackView.addArrangedSubview(fnameTextField)
        
        // Last Name
        contentStackView.addArrangedSubview(createLabel(text: "Last Name"))
        let lnameTextField = createTextField(placeholder: "", tag: 2)
        lnameTextField.accessibilityLabel = "Last Name"
        lnameTextField.autocorrectionType = .no
        lnameTextField.textContentType = .familyName
        lnameTextField.accessibilityIdentifier = "lNameGood"
        contentStackView.addArrangedSubview(lnameTextField)
        
        // Username
        contentStackView.addArrangedSubview(createLabel(text: "Username"))
        let usernameTextField = createTextField(placeholder: "", tag: 3)
        usernameTextField.accessibilityLabel = "Username"
        usernameTextField.textContentType = .username
        usernameTextField.accessibilityIdentifier = "usernameGood"
        contentStackView.addArrangedSubview(usernameTextField)
        
        // Password
        contentStackView.addArrangedSubview(createLabel(text: "Password"))
        let passwordTextField = createTextField(placeholder: "", tag: 4, isSecure: true)
        passwordTextField.accessibilityLabel = "Password"
        passwordTextField.textContentType = .password
        passwordTextField.accessibilityIdentifier = "passwordGood"
        contentStackView.addArrangedSubview(passwordTextField)
        
        // Email
        contentStackView.addArrangedSubview(createLabel(text: "Email"))
        let emailTextField = createTextField(placeholder: "", tag: 5)
        emailTextField.accessibilityLabel = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.textContentType = .emailAddress
        emailTextField.accessibilityIdentifier = "emailGood"
        contentStackView.addArrangedSubview(emailTextField)
        
        // Street Address
        contentStackView.addArrangedSubview(createLabel(text: "Street Address"))
        let addressTextField = createTextField(placeholder: "", tag: 6)
        addressTextField.accessibilityLabel = "Street Address"
        addressTextField.autocorrectionType = .no
        addressTextField.textContentType = .streetAddressLine1
        addressTextField.accessibilityIdentifier = "streetGood"
        contentStackView.addArrangedSubview(addressTextField)
        
        // Street Address Line 2
        contentStackView.addArrangedSubview(createLabel(text: "Street Address Line 2"))
        let address2TextField = createTextField(placeholder: "", tag: 7)
        address2TextField.accessibilityLabel = "Street Address Line 2"
        address2TextField.autocorrectionType = .no
        address2TextField.textContentType = .streetAddressLine2
        address2TextField.accessibilityIdentifier = "street2Good"
        contentStackView.addArrangedSubview(address2TextField)
        
        // City
        contentStackView.addArrangedSubview(createLabel(text: "City"))
        let cityTextField = createTextField(placeholder: "", tag: 8)
        cityTextField.accessibilityLabel = "City"
        cityTextField.textContentType = .addressCity
        cityTextField.accessibilityIdentifier = "cityGood"
        contentStackView.addArrangedSubview(cityTextField)
        
        // State
        contentStackView.addArrangedSubview(createLabel(text: "State"))
        let stateTextField = createTextField(placeholder: "", tag: 9)
        stateTextField.accessibilityLabel = "State"
        stateTextField.textContentType = .addressState
        stateTextField.accessibilityIdentifier = "stateGood"
        contentStackView.addArrangedSubview(stateTextField)
        
        // Phone Number
        contentStackView.addArrangedSubview(createLabel(text: "Phone Number"))
        let phoneTextField = createTextField(placeholder: "", tag: 10)
        phoneTextField.accessibilityLabel = "Phone Number"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.textContentType = .telephoneNumber
        phoneTextField.accessibilityIdentifier = "phoneGood"
        contentStackView.addArrangedSubview(phoneTextField)
        
        // Website
        contentStackView.addArrangedSubview(createLabel(text: "Website"))
        let websiteTextField = createTextField(placeholder: "", tag: 11)
        websiteTextField.accessibilityLabel = "Website"
        websiteTextField.keyboardType = .URL
        websiteTextField.accessibilityIdentifier = "websiteGood"
        contentStackView.addArrangedSubview(websiteTextField)
        
        // Birth Date
        contentStackView.addArrangedSubview(createLabel(text: "Birth Date"))
        let birthdayTextField = createTextField(placeholder: "", tag: 12)
        birthdayTextField.accessibilityLabel = "Birth Date"
        birthdayTextField.autocorrectionType = .no
        birthdayTextField.textContentType = .birthdate
        birthdayTextField.keyboardType = .numbersAndPunctuation
        contentStackView.addArrangedSubview(birthdayTextField)
        
        // Birth Date Day
        contentStackView.addArrangedSubview(createLabel(text: "Birth Date Day"))
        let bdayTextField = createTextField(placeholder: "", tag: 13)
        bdayTextField.accessibilityLabel = "Birth Date Day"
        bdayTextField.autocorrectionType = .no
        bdayTextField.textContentType = .birthdateDay
        bdayTextField.keyboardType = .numberPad
        contentStackView.addArrangedSubview(bdayTextField)
        
        // Birth Date Month
        contentStackView.addArrangedSubview(createLabel(text: "Birth Date Month"))
        let bmonthTextField = createTextField(placeholder: "", tag: 14)
        bmonthTextField.accessibilityLabel = "Birth Date Month"
        bmonthTextField.autocorrectionType = .no
        bmonthTextField.textContentType = .birthdateMonth
        bmonthTextField.keyboardType = .numberPad
        contentStackView.addArrangedSubview(bmonthTextField)
        
        // Birth Date Year
        contentStackView.addArrangedSubview(createLabel(text: "Birth Date Year"))
        let byearTextField = createTextField(placeholder: "", tag: 15)
        byearTextField.accessibilityLabel = "Birth Date Year"
        byearTextField.autocorrectionType = .no
        byearTextField.textContentType = .birthdateYear
        byearTextField.keyboardType = .numberPad
        contentStackView.addArrangedSubview(byearTextField)
        
        // Good Example 1 Details
        let goodDetails1 = createDisclosureGroup(
            title: "Details",
            content: "The first good Text Fields example uses visible label text that is set as the `.accessibilityLabel` for each `TextField`. `.border(.secondary)` is used to give the border a 3:1 contrast ratio. `.keyboardType` is used to provide the most usable keyboard for each type of input. `.textContentType` is used to enable AutoFill for each `TextField` and automatic password management.",
            hint: "Good Example Using `.accessibilityLabel`"
        )
        contentStackView.addArrangedSubview(goodDetails1)
        
        // Good Example 2 Header
        let goodExample2Header = createHeaderLabel(text: "Good Example Using `LabeledContent`", color: .label)
        contentStackView.addArrangedSubview(goodExample2Header)
        
        // First Name with Labeled Content
        let fnameGoodLabeledContentTuple = createLabeledContentField(label: "First Name", tag: 16)
        let fnameGoodLabeledContent = fnameGoodLabeledContentTuple.container
        fnameGoodLabeledContentTuple.textField.autocorrectionType = .no
        fnameGoodLabeledContentTuple.textField.textContentType = .givenName
        contentStackView.addArrangedSubview(fnameGoodLabeledContent)
        
        // Last Name with Labeled Content
        let lnameGoodLabeledContentTuple = createLabeledContentField(label: "Last Name", tag: 17)
        let lnameGoodLabeledContent = lnameGoodLabeledContentTuple.container
        lnameGoodLabeledContentTuple.textField.autocorrectionType = .no
        lnameGoodLabeledContentTuple.textField.textContentType = .familyName
        contentStackView.addArrangedSubview(lnameGoodLabeledContent)
        
        // Good Example 2 Details
        let goodDetails2 = createDisclosureGroup(
            title: "Details",
            content: "The second good Text Fields example uses `LabeledContent` to provide visible label text that also becomes the accessible name of each `TextField`. When using `LabeledContent` an `.accessibilityLabel` is not required. Don't stack the labels vertically or else VoiceOver TextField activation will be blocked to due to an Apple bug.",
            hint: "Good Example Using `LabeledContent`"
        )
        contentStackView.addArrangedSubview(goodDetails2)
        
        // Bad Examples Header
        let badExamplesHeader = createHeaderLabel(text: "Bad Examples", color: darkRed)
        contentStackView.addArrangedSubview(badExamplesHeader)
        
        let badDivider = createDivider(color: darkRed)
        contentStackView.addArrangedSubview(badDivider)
        
        // Bad Example 1 Header
        let badExample1Header = createHeaderLabel(text: "Bad Example Using placeholders with no label text or `.accessibilityLabel`", color: .label)
        contentStackView.addArrangedSubview(badExample1Header)
        
        // Bad First Name
        let fnameBadTextField = createBadTextField(placeholder: "First Name", tag: 18)
        contentStackView.addArrangedSubview(fnameBadTextField)
        
        // Bad Last Name
        let lnameBadTextField = createBadTextField(placeholder: "Last Name", tag: 19)
        contentStackView.addArrangedSubview(lnameBadTextField)
        
        // Bad Username
        let usernameBadTextField = createBadTextField(placeholder: "Username", tag: 20)
        contentStackView.addArrangedSubview(usernameBadTextField)
        
        // Bad Password
        let passwordBadTextField = createBadTextField(placeholder: "Password", tag: 21, isSecure: true)
        contentStackView.addArrangedSubview(passwordBadTextField)
        
        // Bad Email
        let emailBadTextField = createBadTextField(placeholder: "Email", tag: 22)
        contentStackView.addArrangedSubview(emailBadTextField)
        
        // Bad Street Address
        let addressBadTextField = createBadTextField(placeholder: "Street Address", tag: 23)
        contentStackView.addArrangedSubview(addressBadTextField)
        
        // Bad Street Address Line 2
        let address2BadTextField = createBadTextField(placeholder: "", tag: 24)
        contentStackView.addArrangedSubview(address2BadTextField)
        
        // Bad City
        let cityBadTextField = createBadTextField(placeholder: "City", tag: 25)
        contentStackView.addArrangedSubview(cityBadTextField)
        
        // Bad State
        let stateBadTextField = createBadTextField(placeholder: "State", tag: 26)
        contentStackView.addArrangedSubview(stateBadTextField)
        
        // Bad Phone
        let phoneBadTextField = createBadTextField(placeholder: "Phone Number", tag: 27)
        phoneBadTextField.accessibilityIdentifier = "phoneBad"
        contentStackView.addArrangedSubview(phoneBadTextField)
        
        // Bad Website
        let websiteBadTextField = createBadTextField(placeholder: "Website", tag: 28)
        contentStackView.addArrangedSubview(websiteBadTextField)
        
        // Bad Example 1 Details
        let badDetails1 = createDisclosureGroup(
            title: "Details",
            content: "The bad Text Fields example uses placeholder text which disappears and has insufficient contrast rather than visible label text. There is no `.accessibilityLabel` for each `TextField`. The default border style has an insufficient contrast ratio. Keyboard types are not specified. AutoFill and password management are not enabled.",
            hint: "Bad Example Using placeholders with no label text or `.accessibilityLabel`"
        )
        contentStackView.addArrangedSubview(badDetails1)
        
        // Bad Example 2 Header
        let badExample2Header = createHeaderLabel(text: "Bad Example Using `LabeledContent`", color: .label)
        contentStackView.addArrangedSubview(badExample2Header)
        
        // Bad First Name with Vertical Labeled Content
        let fnameBadLabeledContentTuple = createVerticalLabeledContentField(label: "First Name", tag: 29)
        let fnameBadLabeledContent = fnameBadLabeledContentTuple.container
        fnameBadLabeledContentTuple.textField.autocorrectionType = .no
        fnameBadLabeledContentTuple.textField.textContentType = .givenName
        contentStackView.addArrangedSubview(fnameBadLabeledContent)
        
        // Bad Last Name with Vertical Labeled Content
        let lnameBadLabeledContentTuple = createVerticalLabeledContentField(label: "Last Name", tag: 30)
        let lnameBadLabeledContent = lnameBadLabeledContentTuple.container
        lnameBadLabeledContentTuple.textField.autocorrectionType = .no
        lnameBadLabeledContentTuple.textField.textContentType = .familyName
        contentStackView.addArrangedSubview(lnameBadLabeledContent)
        
        // Bad Example 2 Details
        let badDetails2 = createDisclosureGroup(
            title: "Details",
            content: "The second bad Text Fields example uses `LabeledContent` to provide visible label text that also becomes the accessible name of each `TextField`. When using `.labeledContentStyle(.vertical)` VoiceOver operation is blocked because VoiceOver users cannot double tap to activate the TextField and enter a value. When using `LabeledContent` an `.accessibilityLabel` is not required.",
            hint: "Bad Example Using `LabeledContent`"
        )
        contentStackView.addArrangedSubview(badDetails2)
    }
    
    // MARK: - Helper Methods
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createTextField(placeholder: String, tag: Int, isSecure: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecure
        textField.delegate = self
        textField.tag = tag
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add border with secondary color for better contrast
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.cornerRadius = 5.0
        
        return textField
    }
    
    private func createBadTextField(placeholder: String, tag: Int, isSecure: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecure
        textField.delegate = self
        textField.tag = tag
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func createHeaderLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = color
        label.numberOfLines = 0
        label.accessibilityTraits = .header
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createDivider(color: UIColor) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return divider
    }
    
    private func createDisclosureGroup(title: String, content: String, hint: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
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
    
    // Creates a horizontal labeled content field
    private func createLabeledContentField(label: String, tag: Int) -> (container: UIView, textField: UITextField) {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelView = UILabel()
        labelView.text = label
        labelView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelView)
        
        let textField = UITextField()
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.tag = tag
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add border with secondary color for better contrast
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.cornerRadius = 5.0
        
        containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            labelView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            textField.leadingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            
            containerView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Set accessibility properties
        textField.accessibilityLabel = label
        
        return (containerView, textField)
    }
    
    // Creates a vertical labeled content field (bad example)
    private func createVerticalLabeledContentField(label: String, tag: Int) -> (container: UIView, textField: UITextField) {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelView = UILabel()
        labelView.text = label
        labelView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelView)
        
        let textField = UITextField()
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.tag = tag
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add border with secondary color for better contrast
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.cornerRadius = 5.0
        
        containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: containerView.topAnchor),
            labelView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            
            containerView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // Set accessibility properties
        textField.accessibilityLabel = label
        
        return (containerView, textField)
    }
    
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Save values based on tag
        switch textField.tag {
        case 1: self.fname = textField.text ?? ""
        case 2: self.lname = textField.text ?? ""
        case 3: self.username = textField.text ?? ""
        case 4: self.password = textField.text ?? ""
        case 5: self.email = textField.text ?? ""
        case 6: self.address = textField.text ?? ""
        case 7: self.address2 = textField.text ?? ""
        case 8: self.city = textField.text ?? ""
        case 9: self.state = textField.text ?? ""
        case 10: self.phone = textField.text ?? ""
        case 11: self.website = textField.text ?? ""
        case 12: self.birthday = textField.text ?? ""
        case 13: self.bday = textField.text ?? ""
        case 14: self.bmonth = textField.text ?? ""
        case 15: self.byear = textField.text ?? ""
        // Handle bad examples
        case 18: self.fnameBad = textField.text ?? ""
        case 19: self.lnameBad = textField.text ?? ""
        case 20: self.usernameBad = textField.text ?? ""
        case 21: self.passwordBad = textField.text ?? ""
        case 22: self.emailBad = textField.text ?? ""
        case 23: self.addressBad = textField.text ?? ""
        case 24: self.address2Bad = textField.text ?? ""
        case 25: self.cityBad = textField.text ?? ""
        case 26: self.stateBad = textField.text ?? ""
        case 27: self.phoneBad = textField.text ?? ""
        case 28: self.websiteBad = textField.text ?? ""
        default: break
        }
    }
}

struct UIKitTextFieldView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool
    var keyboardType: UIKeyboardType
    var textContentType: UITextContentType?
    var autocorrectionDisabled: Bool
    var autocapitalizationType: UITextAutocapitalizationType
    var accessibilityLabel: String?
    var accessibilityIdentifier: String?
    var hasBorder: Bool
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecure
        textField.keyboardType = keyboardType
        textField.autocorrectionType = autocorrectionDisabled ? .no : .default
        textField.autocapitalizationType = autocapitalizationType
        textField.delegate = context.coordinator
        
        if let contentType = textContentType {
            textField.textContentType = contentType
        }
        
        if let accessLabel = accessibilityLabel {
            textField.accessibilityLabel = accessLabel
        }
        
        if let identifier = accessibilityIdentifier {
            textField.accessibilityIdentifier = identifier
        }
        
        if hasBorder {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor
            textField.layer.cornerRadius = 5.0
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UIKitTextFieldView
        
        init(_ parent: UIKitTextFieldView) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
}

import SwiftUI
import UIKit

struct TextFieldsViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TextFieldsViewController {
        return TextFieldsViewController()
    }
    
    func updateUIViewController(_ uiViewController: TextFieldsViewController, context: Context) {
        // Updates from SwiftUI to UIKit if needed
    }
}

// This is the main SwiftUI view that will be used in your app
struct TextFieldsView: View {
    // State variables
    @State private var text = ""
    @State private var username = ""
    @State private var password = ""
    @State private var fname = ""
    @State private var lname = ""
    
    var body: some View {
        // Option 1: Use the UIViewControllerRepresentable wrapper for the entire screen
        TextFieldsViewControllerRepresentable()
            .navigationBarTitleDisplayMode(.inline)
        
        // Option 2: Use individual UIKit text fields within a SwiftUI layout
        // Commenting this out to use Option 1, but showing how both wrappers could be used
        /*
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("First Name")
                UIKitTextFieldView(
                    text: $fname,
                    placeholder: "",
                    isSecure: false,
                    keyboardType: .default,
                    textContentType: .givenName,
                    autocorrectionDisabled: true,
                    autocapitalizationType: .words,
                    accessibilityLabel: "First Name",
                    accessibilityIdentifier: "fNameGood",
                    hasBorder: true
                )
                .frame(height: 44)
                
                Text("Username")
                UIKitTextFieldView(
                    text: $username,
                    placeholder: "",
                    isSecure: false,
                    keyboardType: .default,
                    textContentType: .username,
                    autocorrectionDisabled: true,
                    autocapitalizationType: .none,
                    accessibilityLabel: "Username",
                    accessibilityIdentifier: "usernameGood",
                    hasBorder: true
                )
                .frame(height: 44)
                
                Text("Password")
                UIKitTextFieldView(
                    text: $password,
                    placeholder: "",
                    isSecure: true,
                    keyboardType: .default,
                    textContentType: .password,
                    autocorrectionDisabled: true,
                    autocapitalizationType: .none,
                    accessibilityLabel: "Password",
                    accessibilityIdentifier: "passwordGood",
                    hasBorder: true
                )
                .frame(height: 44)
            }
            .padding()
        }
        */
    }
}

struct TextFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TextFieldsView()
        }
    }
}
