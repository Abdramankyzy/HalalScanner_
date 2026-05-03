import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TabBarVC coordinator:", coordinator as Any)
        
    }
    weak var coordinator: AppCoordinator? {
        didSet{
            setupBar()
        }
    }
    
    func setupBar() {
        
        let historyVC = UINavigationController(rootViewController: HistoryVC())
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock"), tag: 0)
        
        
        let scannerVCRoot = ViewController()
        scannerVCRoot.coordinator = coordinator
        let scannerVC = UINavigationController(rootViewController: scannerVCRoot)
        scannerVC.tabBarItem = UITabBarItem(title: "Scanner", image: UIImage(systemName: "camera.viewfinder"), tag: 1)

        let favoritesVC = UINavigationController(rootViewController: FavoritesVC())
        favoritesVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "star.circle"), tag: 2)

        
        let profileVCRoot = ProfileVC()
        profileVCRoot.coordinator = coordinator
        let profileVC = UINavigationController(rootViewController: profileVCRoot)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 3)
        
        
      
        
        
        
        
        let isAdmin = UserDefaults.standard.string(forKey: "userRole") == "admin"
        if isAdmin {
            let adminVCRoot = AdminVC()
            let adminVC = UINavigationController(rootViewController: adminVCRoot)
            adminVC.tabBarItem = UITabBarItem(title: "Admin", image: UIImage(systemName: "shield.checkered"), tag: 4)
            viewControllers = [historyVC, scannerVC, favoritesVC, profileVC, adminVC]
        } else {
            viewControllers = [historyVC, scannerVC, favoritesVC, profileVC]
        }

        tabBar.tintColor = UIColor.appGreen

        tabBar.unselectedItemTintColor = .systemGray3
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
