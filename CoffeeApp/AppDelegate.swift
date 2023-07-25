//
//  AppDelegate.swift
//  CoffeeApp
//
//  Created by David Kochkin on 25.07.2023.
//

import UIKit

class CoffeeAppViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}

class ScanViewController: CoffeeAppViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemIndigo
        title = "Scan"
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "qrcode", title: "Scan")
    }
}

class OrderViewController: CoffeeAppViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
        title = "Order"
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "arrow.up.bin.fill", title: "Order")
    }
}

class GiftViewController: CoffeeAppViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGreen
        title = "Gift"
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "gift.fill", title: "Gift")
    }
}

class StoresViewController: CoffeeAppViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemCyan
        title = "Stores"
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "location.fill", title: "Stores")
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.overrideUserInterfaceStyle = .light
       
        
        let homeVC = HomeViewController()
        let scanVC = ScanViewController()
        let orderVC = OrderViewController()
        let giftVC = GiftViewController()
        let storeVC = StoresViewController()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers =  [homeVC, scanVC, orderVC, giftVC, storeVC]
        
        window?.rootViewController = tabBarController
        
        return true
    }

}

