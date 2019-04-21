import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor(r: 47, g: 47, b: 59)
        tabBar.tintColor = UIColor(r: 32, g: 187, b: 72)
        let tableViewController = TableViewController()
        tableViewController.tabBarItem = UITabBarItem(title: "Банкоматы", image: UIImage(named: "flag"), tag: 0)
        let mapViewController = MapViewController()
        mapViewController.tabBarItem = UITabBarItem(title: "Карта",image: UIImage(named: "map"), tag: 1)
        let tabBarList = [UINavigationController(rootViewController: tableViewController), UINavigationController(rootViewController: mapViewController)]
        viewControllers = tabBarList
    }
}
