//
//  ViewController.swift
//  CoffeeApp
//
//  Created by David Kochkin on 25.07.2023.
//

import UIKit

class HomeViewController: CoffeeAppViewController {
    
    let headerView = HomeHeaderView()
    var headerViewTopConstraints: NSLayoutConstraint?
    
    let cellId = "cellId"
    let tiles = [
        "Star balance",
        "Bonus Stars",
        "Try these",
        "Welcome back",
        "Uplifting"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarImage(imageName: "house.fill", title: "Home")
        
        style()
        layout()
        
        if #available(iOS 15.0, *) {
            navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
        }
    }
}


extension HomeViewController {
    func style() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemPink
    }
    
    func layout() {
        view.addSubview(headerView)
        
        headerViewTopConstraints = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        NSLayoutConstraint.activate([

            headerViewTopConstraints!,
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
       
    }
}


//MARK: Animating scrollView

    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let y = scrollView.contentOffset.y
//
//        let swipinDown = y <= 0
//        let shouldSnap = y > 30
//        let labelHeight = headerView.greeting.frame.height + 16 // label + spacer (102)
//
//        UIView.animate(withDuration: 0.3) {
//            self.headerView.greeting.alpha = swipinDown ? 1.0 : 0.0
//        }
//
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) {
//            self.headerViewTopConstraints?.constant = shouldSnap ? -labelHeight : 0
//            self.view.layoutIfNeeded()
//        }
//    }

