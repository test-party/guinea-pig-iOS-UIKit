import UIKit

class TabsGoodViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TabsGoodView"
        setupTabs()
        
        // Set accessibility label for the tab bar
        tabBar.accessibilityLabel = "Navigation"
    }
    
    private func setupTabs() {
        // Create Home tab
        let homeVC = HomeTabViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        // Create Messages tab
        let messagesVC = MessagesTabViewController()
        messagesVC.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "envelope"), tag: 1)
        
        // Set view controllers
        self.viewControllers = [homeVC, messagesVC]
    }
}

// Home Tab View Controller
class HomeTabViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "Home Tab Content"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// Messages Tab View Controller
class MessagesTabViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Messages"
        view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "Messages Tab Content"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
