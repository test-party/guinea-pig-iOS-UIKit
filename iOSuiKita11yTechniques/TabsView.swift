import UIKit
import SwiftUI

class TabsViewController: UIViewController {
    
    // MARK: - Properties
    private var tab1Visible = true
    private var tab2Visible = false
    private var tab1VisibleBad = true
    private var tab2VisibleBad = false
    
    private let darkGreen = UIColor(red: 0/255, green: 102/255, blue: 0/255, alpha: 1.0)
    private let darkRed = UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0)
    
    private var scrollView: UIScrollView!
    private var contentStack: UIStackView!
    
    private var homeTabContent: UILabel!
    private var messagesTabContent: UILabel!
    private var homeBadTabContent: UILabel!
    private var messagesBadTabContent: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Tabs"
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Create scroll view
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Create content stack view
        contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.alignment = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        // Add content
        setupContent()
    }
    
    private func setupContent() {
        // Introduction Text
        let introText = UILabel()
        introText.numberOfLines = 0
        introText.text = "Tabs show and hide content inside tab panels. VoiceOver users must hear the selected tab state. Use `TabView` to create native tab controls with selected state. Give each `TabView` a unique and meaningful `.accessibilityLabel`. For custom tabs use `isTabBar` and `isSelected` Traits with `.accessibilityElement(children: .contain)`."
        contentStack.addArrangedSubview(introText)
        
        // Good Examples Header
        let goodExamplesHeader = createHeaderLabel(text: "Good Examples", color: darkGreen)
        contentStack.addArrangedSubview(goodExamplesHeader)
        
        let goodDivider = createDivider(color: darkGreen)
        contentStack.addArrangedSubview(goodDivider)
        
        // Good Example 1 Header
        let goodExample1Header = createHeaderLabel(text: "Good Example native `TabView`", color: .label)
        contentStack.addArrangedSubview(goodExample1Header)
        
        // Good Example 1 Link
        let tabsGoodLink = UIButton(type: .system)
        tabsGoodLink.setTitle("Tabs Good Example", for: .normal)
        tabsGoodLink.contentHorizontalAlignment = .center
        tabsGoodLink.addTarget(self, action: #selector(openGoodTabsExample), for: .touchUpInside)
        tabsGoodLink.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        contentStack.addArrangedSubview(tabsGoodLink)
        
        // Good Example 1 Details
        let goodDetails1 = createDisclosureGroup(
            title: "Details",
            content: "The first good tabs example uses a native `TabView` with default functionality. VoiceOver reads the tab trait and selected state as well as the number of tabs and current tab number.",
            hint: "Good Example native `TabView`"
        )
        contentStack.addArrangedSubview(goodDetails1)
        
        // Good Example 2 Header
        let goodExample2Header = createHeaderLabel(text: "Good Example `.tabViewStyle(.page)` with `.accessibilityLabel` and `backgroundDisplayMode: .always`", color: .label)
        contentStack.addArrangedSubview(goodExample2Header)
        
        // Good Example 2 Content - Page Control
        let pageContainer = UIView()
        pageContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true
        contentStack.addArrangedSubview(pageContainer)
        
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.addChild(pageViewController)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageContainer.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // Create content pages
        let pages = [
            createPageContent(text: "First Slide"),
            createPageContent(text: "Second Slide"),
            createPageContent(text: "Third Slide"),
            createPageContent(text: "Fourth Slide")
        ]
        
        // Set initial page
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
        
        // Create page control
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.backgroundStyle = .prominent
        pageControl.pageIndicatorTintColor = .blue
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.preferredIndicatorImage = UIImage(systemName: "circle")
        pageControl.preferredCurrentPageIndicatorImage = UIImage(systemName: "circle.fill")
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.accessibilityLabel = "Slideshow"
        pageControl.accessibilityIdentifier = "tabsGood2"
        pageContainer.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: pageContainer.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: pageContainer.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: pageContainer.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -8),
            
            pageControl.leadingAnchor.constraint(equalTo: pageContainer.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: pageContainer.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: pageContainer.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Good Example 2 Details
        let goodDetails2 = createDisclosureGroup(
            title: "Details",
            content: "The second good tabs example uses a native `TabView` with `.tabViewStyle(.page)` and `.indexViewStyle(.page(backgroundDisplayMode: .always))` to display page indicator dots with a background. The `TabView` also has an `.accessibilityLabel`.",
            hint: "Good Example `.tabViewStyle(.page)` with `.accessibilityLabel` and `backgroundDisplayMode: .always`"
        )
        contentStack.addArrangedSubview(goodDetails2)
        
        // Good Example 3 Header
        let goodExample3Header = createHeaderLabel(text: "Good Example Custom Tabs using `isTabBar` and `isSelected` Traits with `.accessibilityElement(children: .contain)`", color: .label)
        contentStack.addArrangedSubview(goodExample3Header)
        
        // Good Example 3 Content - Custom Tabs
        let goodTabBar = UIView()
        contentStack.addArrangedSubview(goodTabBar)
        
        let goodTabBarStack = UIStackView()
        goodTabBarStack.axis = .horizontal
        goodTabBarStack.distribution = .fillEqually
        goodTabBarStack.translatesAutoresizingMaskIntoConstraints = false
        goodTabBar.addSubview(goodTabBarStack)
        
        // Home Tab Button
        let homeIcon = UIImageView(image: UIImage(systemName: "house")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24)))
        homeIcon.tintColor = .systemBlue
        homeIcon.contentMode = .scaleAspectFit
        
        let homeLabel = UILabel()
        homeLabel.text = "Home"
        homeLabel.textAlignment = .center
        
        // Apply underline if selected
        if tab1Visible {
            let attributedText = NSAttributedString(
                string: "Home",
                attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
            )
            homeLabel.attributedText = attributedText
        }
        
        let homeStack = UIStackView(arrangedSubviews: [homeIcon, homeLabel])
        homeStack.axis = .vertical
        homeStack.alignment = .center
        homeStack.spacing = 4
        homeStack.isUserInteractionEnabled = true
        
        let homeTapGesture = UITapGestureRecognizer(target: self, action: #selector(goodHomeTabTapped))
        homeStack.addGestureRecognizer(homeTapGesture)
        
        // Messages Tab Button
        let messagesIcon = UIImageView(image: UIImage(systemName: "envelope")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24)))
        messagesIcon.tintColor = .systemBlue
        messagesIcon.contentMode = .scaleAspectFit
        
        let messagesLabel = UILabel()
        messagesLabel.text = "Messages"
        messagesLabel.textAlignment = .center
        
        // Apply underline if selected
        if tab2Visible {
            let attributedText = NSAttributedString(
                string: "Messages",
                attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
            )
            messagesLabel.attributedText = attributedText
        }
        
        let messagesStack = UIStackView(arrangedSubviews: [messagesIcon, messagesLabel])
        messagesStack.axis = .vertical
        messagesStack.alignment = .center
        messagesStack.spacing = 4
        messagesStack.isUserInteractionEnabled = true
        
        let messagesTapGesture = UITapGestureRecognizer(target: self, action: #selector(goodMessagesTabTapped))
        messagesStack.addGestureRecognizer(messagesTapGesture)
        
        // Add padding to stacks
        let homePaddingView = UIView()
        homePaddingView.translatesAutoresizingMaskIntoConstraints = false
        homePaddingView.addSubview(homeStack)
        
        let messagesPaddingView = UIView()
        messagesPaddingView.translatesAutoresizingMaskIntoConstraints = false
        messagesPaddingView.addSubview(messagesStack)
        
        NSLayoutConstraint.activate([
            homeStack.centerXAnchor.constraint(equalTo: homePaddingView.centerXAnchor),
            homeStack.centerYAnchor.constraint(equalTo: homePaddingView.centerYAnchor),
            homeStack.topAnchor.constraint(equalTo: homePaddingView.topAnchor, constant: 8),
            homeStack.bottomAnchor.constraint(equalTo: homePaddingView.bottomAnchor, constant: -8),
            
            messagesStack.centerXAnchor.constraint(equalTo: messagesPaddingView.centerXAnchor),
            messagesStack.centerYAnchor.constraint(equalTo: messagesPaddingView.centerYAnchor),
            messagesStack.topAnchor.constraint(equalTo: messagesPaddingView.topAnchor, constant: 8),
            messagesStack.bottomAnchor.constraint(equalTo: messagesPaddingView.bottomAnchor, constant: -8)
        ])
        
        goodTabBarStack.addArrangedSubview(homePaddingView)
        goodTabBarStack.addArrangedSubview(messagesPaddingView)
        
        NSLayoutConstraint.activate([
            goodTabBarStack.topAnchor.constraint(equalTo: goodTabBar.topAnchor),
            goodTabBarStack.leadingAnchor.constraint(equalTo: goodTabBar.leadingAnchor),
            goodTabBarStack.trailingAnchor.constraint(equalTo: goodTabBar.trailingAnchor),
            goodTabBarStack.bottomAnchor.constraint(equalTo: goodTabBar.bottomAnchor)
        ])
        
        // Set accessibility for good tab bar
        goodTabBar.isAccessibilityElement = true
        goodTabBar.accessibilityLabel = "Navigation"
        goodTabBar.accessibilityTraits = .tabBar
        
        // Create an array of accessibility elements for the tab bar
        var tabBarElements: [NSObject] = []
        
        // Configure Home tab accessibility
        homeStack.isAccessibilityElement = true
        homeStack.accessibilityLabel = "Home"
        homeStack.accessibilityTraits = tab1Visible ? [.button, .selected] : .button
        tabBarElements.append(homeStack)
        
        // Configure Messages tab accessibility
        messagesStack.isAccessibilityElement = true
        messagesStack.accessibilityLabel = "Messages"
        messagesStack.accessibilityTraits = tab2Visible ? [.button, .selected] : .button
        tabBarElements.append(messagesStack)
        
        // Set custom accessibility elements
        goodTabBar.accessibilityElements = tabBarElements
        
        // Tab Content Areas
        homeTabContent = UILabel()
        homeTabContent.text = "Home tab panel text."
        homeTabContent.isHidden = !tab1Visible
        contentStack.addArrangedSubview(homeTabContent)
        
        messagesTabContent = UILabel()
        messagesTabContent.text = "Messages tab panel text."
        messagesTabContent.isHidden = !tab2Visible
        contentStack.addArrangedSubview(messagesTabContent)
        
        // Good Example 3 Details
        let goodDetails3 = createDisclosureGroup(
            title: "Details",
            content: "The custom tabs good example uses `isTabBar` and `isSelected` traits with `.accessibilityElement(children: .contain)`. VoiceOver reads the tab trait and selected state as well as the number of tabs and current tab number. The custom selected Tab has an underline to show selected state without using color alone.",
            hint: "Good Example Custom Tabs using `isTabBar` and `isSelected` Traits with `.accessibilityElement(children: .contain)`"
        )
        contentStack.addArrangedSubview(goodDetails3)
        
        // Bad Examples Header
        let badExamplesHeader = createHeaderLabel(text: "Bad Examples", color: darkRed)
        contentStack.addArrangedSubview(badExamplesHeader)
        
        let badDivider = createDivider(color: darkRed)
        contentStack.addArrangedSubview(badDivider)
        
        // Bad Example 1 Header
        let badExample1Header = createHeaderLabel(text: "Bad Example custom tabs as buttons that show and hide text", color: .label)
        contentStack.addArrangedSubview(badExample1Header)
        
        // Bad Example 1 Content
        let badTabBar = UIView()
        contentStack.addArrangedSubview(badTabBar)
        
        let badTabBarStack = UIStackView()
        badTabBarStack.axis = .horizontal
        badTabBarStack.distribution = .fillEqually
        badTabBarStack.translatesAutoresizingMaskIntoConstraints = false
        badTabBar.addSubview(badTabBarStack)
        
        // Home Bad Tab Button
        let homeBadIcon = UIImageView(image: UIImage(systemName: "house")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24)))
        homeBadIcon.tintColor = .systemBlue
        homeBadIcon.contentMode = .scaleAspectFit
        
        let homeBadLabel = UILabel()
        homeBadLabel.text = "Home"
        homeBadLabel.textAlignment = .center
        
        let homeBadStack = UIStackView(arrangedSubviews: [homeBadIcon, homeBadLabel])
        homeBadStack.axis = .vertical
        homeBadStack.alignment = .center
        homeBadStack.spacing = 4
        homeBadStack.isUserInteractionEnabled = true
        
        let homeBadTapGesture = UITapGestureRecognizer(target: self, action: #selector(badHomeTabTapped))
        homeBadStack.addGestureRecognizer(homeBadTapGesture)
        
        // Messages Bad Tab Button
        let messagesBadIcon = UIImageView(image: UIImage(systemName: "envelope")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24)))
        messagesBadIcon.tintColor = .systemBlue
        messagesBadIcon.contentMode = .scaleAspectFit
        
        let messagesBadLabel = UILabel()
        messagesBadLabel.text = "Messages"
        messagesBadLabel.textAlignment = .center
        
        let messagesBadStack = UIStackView(arrangedSubviews: [messagesBadIcon, messagesBadLabel])
        messagesBadStack.axis = .vertical
        messagesBadStack.alignment = .center
        messagesBadStack.spacing = 4
        messagesBadStack.isUserInteractionEnabled = true
        
        let messagesBadTapGesture = UITapGestureRecognizer(target: self, action: #selector(badMessagesTabTapped))
        messagesBadStack.addGestureRecognizer(messagesBadTapGesture)
        
        // Add padding to stacks
        let homeBadPaddingView = UIView()
        homeBadPaddingView.translatesAutoresizingMaskIntoConstraints = false
        homeBadPaddingView.addSubview(homeBadStack)
        
        let messagesBadPaddingView = UIView()
        messagesBadPaddingView.translatesAutoresizingMaskIntoConstraints = false
        messagesBadPaddingView.addSubview(messagesBadStack)
        
        NSLayoutConstraint.activate([
            homeBadStack.centerXAnchor.constraint(equalTo: homeBadPaddingView.centerXAnchor),
            homeBadStack.centerYAnchor.constraint(equalTo: homeBadPaddingView.centerYAnchor),
            homeBadStack.topAnchor.constraint(equalTo: homeBadPaddingView.topAnchor, constant: 8),
            homeBadStack.bottomAnchor.constraint(equalTo: homeBadPaddingView.bottomAnchor, constant: -8),
            
            messagesBadStack.centerXAnchor.constraint(equalTo: messagesBadPaddingView.centerXAnchor),
            messagesBadStack.centerYAnchor.constraint(equalTo: messagesBadPaddingView.centerYAnchor),
            messagesBadStack.topAnchor.constraint(equalTo: messagesBadPaddingView.topAnchor, constant: 8),
            messagesBadStack.bottomAnchor.constraint(equalTo: messagesBadPaddingView.bottomAnchor, constant: -8)
        ])
        
        badTabBarStack.addArrangedSubview(homeBadPaddingView)
        badTabBarStack.addArrangedSubview(messagesBadPaddingView)
        
        NSLayoutConstraint.activate([
            badTabBarStack.topAnchor.constraint(equalTo: badTabBar.topAnchor),
            badTabBarStack.leadingAnchor.constraint(equalTo: badTabBar.leadingAnchor),
            badTabBarStack.trailingAnchor.constraint(equalTo: badTabBar.trailingAnchor),
            badTabBarStack.bottomAnchor.constraint(equalTo: badTabBar.bottomAnchor)
        ])
        
        // Bad Tab Content Areas
        homeBadTabContent = UILabel()
        homeBadTabContent.text = "Home tab panel text."
        homeBadTabContent.isHidden = !tab1VisibleBad
        contentStack.addArrangedSubview(homeBadTabContent)
        
        messagesBadTabContent = UILabel()
        messagesBadTabContent.text = "Messages tab panel text."
        messagesBadTabContent.isHidden = !tab2VisibleBad
        contentStack.addArrangedSubview(messagesBadTabContent)
        
        // Bad Example 1 Details
        let badDetails1 = createDisclosureGroup(
            title: "Details",
            content: "The first bad tabs example is coded as buttons that show and hide text. VoiceOver does not hear a selected state or tab trait for the tabs. The custom selected Tab has no underline to show selected state.",
            hint: "Bad Example custom tabs as btns that show and hide text"
        )
        contentStack.addArrangedSubview(badDetails1)
        
        // Bad Example 2 Header
        let badExample2Header = createHeaderLabel(text: "Bad Example `.tabViewStyle(.page)` with no `.accessibilityLabel` and no `backgroundDisplayMode: .always`", color: .label)
        contentStack.addArrangedSubview(badExample2Header)
        
        // Bad Example 2 Content - Page Control
        let badPageContainer = UIView()
        badPageContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true
        contentStack.addArrangedSubview(badPageContainer)
        
        let badPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.addChild(badPageViewController)
        badPageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        badPageContainer.addSubview(badPageViewController.view)
        badPageViewController.didMove(toParent: self)
        
        // Set initial page
        badPageViewController.setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
        
        // Create bad page control (no background, no accessibility label)
        let badPageControl = UIPageControl()
        badPageControl.numberOfPages = pages.count
        badPageControl.currentPage = 0
        badPageControl.translatesAutoresizingMaskIntoConstraints = false
        badPageControl.accessibilityIdentifier = "tabsBad2"
        badPageContainer.addSubview(badPageControl)
        
        NSLayoutConstraint.activate([
            badPageViewController.view.topAnchor.constraint(equalTo: badPageContainer.topAnchor),
            badPageViewController.view.leadingAnchor.constraint(equalTo: badPageContainer.leadingAnchor),
            badPageViewController.view.trailingAnchor.constraint(equalTo: badPageContainer.trailingAnchor),
            badPageViewController.view.bottomAnchor.constraint(equalTo: badPageControl.topAnchor, constant: -8),
            
            badPageControl.leadingAnchor.constraint(equalTo: badPageContainer.leadingAnchor),
            badPageControl.trailingAnchor.constraint(equalTo: badPageContainer.trailingAnchor),
            badPageControl.bottomAnchor.constraint(equalTo: badPageContainer.bottomAnchor),
            badPageControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Bad Example 2 Details
        let badDetails2 = createDisclosureGroup(
            title: "Details",
            content: "The second bad tabs example uses `.tabViewStyle(.page)` which has white page indicator dots that are only visible in dark mode but are invisible in light mode. There is also no `.accessibilityLabel`.",
            hint: "Bad Example `.tabViewStyle(.page)` with no `.accessibilityLabel` and no `backgroundDisplayMode: .always`"
        )
        contentStack.addArrangedSubview(badDetails2)
    }
    
    private func createPageContent(text: String) -> UIViewController {
        let contentVC = UIViewController()
        contentVC.view.backgroundColor = .systemGray6
        
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentVC.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentVC.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentVC.view.centerYAnchor)
        ])
        
        return contentVC
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
    
    private func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        UIPageControl.appearance().pageIndicatorTintColor = .blue
        UIPageControl.appearance().preferredIndicatorImage = UIImage(systemName: "circle")
        UIPageControl.appearance().preferredCurrentPageIndicatorImage = UIImage(systemName: "circle.fill")
    }
    
    // MARK: - Actions
    @objc private func openGoodTabsExample() {
        // Using TabsGoodViewController from the previous file
        let tabsGoodVC = TabsGoodViewController()
        navigationController?.pushViewController(tabsGoodVC, animated: true)
    }
    
    @objc private func goodHomeTabTapped() {
        tab1Visible = true
        tab2Visible = false
        updateGoodTabUI()
    }
    
    @objc private func goodMessagesTabTapped() {
        tab1Visible = false
        tab2Visible = true
        updateGoodTabUI()
    }
    
    @objc private func badHomeTabTapped() {
        tab1VisibleBad = true
        tab2VisibleBad = false
        updateBadTabUI()
    }
    
    @objc private func badMessagesTabTapped() {
        tab1VisibleBad = false
        tab2VisibleBad = true
        updateBadTabUI()
    }
    
    private func updateGoodTabUI() {
        // Update visibility of content
        homeTabContent.isHidden = !tab1Visible
        messagesTabContent.isHidden = !tab2Visible
        
        // Find and update the tab bar
        for view in view.subviews {
            if let scrollView = view as? UIScrollView {
                recursivelyUpdateTabBar(in: scrollView)
            }
        }
    }
    
    private func recursivelyUpdateTabBar(in view: UIView) {
        for subview in view.subviews {
            if subview.accessibilityTraits.contains(.tabBar) && subview.accessibilityLabel == "Navigation" {
                if let elements = subview.accessibilityElements as? [UIView] {
                    for (index, element) in elements.enumerated() {
                        if index == 0 { // Home tab
                            element.accessibilityTraits = tab1Visible ? [.button, .selected] : .button
                            if let stack = element as? UIStackView, let label = stack.arrangedSubviews.last as? UILabel {
                                if tab1Visible {
                                    let attributedText = NSAttributedString(
                                        string: "Home",
                                        attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
                                    )
                                    label.attributedText = attributedText
                                } else {
                                    label.text = "Home"
                                }
                            }
                        } else if index == 1 { // Messages tab
                            element.accessibilityTraits = tab2Visible ? [.button, .selected] : .button
                            if let stack = element as? UIStackView, let label = stack.arrangedSubviews.last as? UILabel {
                                if tab2Visible {
                                    let attributedText = NSAttributedString(
                                        string: "Messages",
                                        attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
                                    )
                                    label.attributedText = attributedText
                                } else {
                                    label.text = "Messages"
                                }
                            }
                        }
                    }
                }
                return
            }
            recursivelyUpdateTabBar(in: subview)
        }
    }
    
    private func updateBadTabUI() {
        // Update visibility of content
        homeBadTabContent.isHidden = !tab1VisibleBad
        messagesBadTabContent.isHidden = !tab2VisibleBad
    }
}

struct TabsViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TabsViewController {
        return TabsViewController()
    }
    
    func updateUIViewController(_ uiViewController: TabsViewController, context: Context) {
        // Updates from SwiftUI to UIKit if needed
    }
}

struct TabsGoodViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TabsGoodViewController {
        return TabsGoodViewController()
    }
    
    func updateUIViewController(_ uiViewController: TabsGoodViewController, context: Context) {
        // Updates from SwiftUI to UIKit if needed
    }
}

// TabsView that uses the UIKit implementation
struct TabsView: View {
    var body: some View {
        TabsViewControllerRepresentable()
            .navigationBarTitleDisplayMode(.inline)
    }
}

// TabsGoodView that uses the UIKit implementation
struct TabsGoodView: View {
    var body: some View {
        TabsGoodViewControllerRepresentable()
    }
}

// Preview Providers
struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TabsView()
        }
    }
}

struct TabsGoodView_Previews: PreviewProvider {
    static var previews: some View {
        TabsGoodView()
    }
}
