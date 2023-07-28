//
//  ViewController.swift
//  CoffeeApp
//
//  Created by David Kochkin on 25.07.2023.
//

import UIKit

class HomeViewController: CoffeeAppViewController {
    
    let topSpacerView = UIView()
    let headerView = HomeHeaderView()
    let scrollView = UIScrollView()
    let rootStackView = UIStackView()
    let scanButton = UIButton()
    
    var headerViewTopConstraint: NSLayoutConstraint?
    
    struct ScanButtonSpacing {
        static let height: CGFloat = 60
        static let width: CGFloat = 170
    }
    
    let tiles = [
        RewardsTileViewController(),
        TileViewController(title: "Breakfast made meatless",
                           subtitle: "Try the Beyond Meat, Cheddar & Egg Breakfast Sandwich. Vegetarian and protein-packed.",
                           imageName: "meatless"),
        TileViewController(title: "Uplifting our communities",
                           subtitle: "Thanks to our partners nominations, The Starbucks Foundation is donating $145k to more than 50 local charities.",
                           imageName: "communities"),
        TileViewController(title: "Spend at least $15 for 50 Bonus Stars",
                           subtitle: "Collect 50 Bonus Stars when you spend at least $15 pre-tax.",
                           imageName: "bonus"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupScrollView()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "house.fill", title: "Home")
    }
    
    func setupScrollView() {
        scrollView.delegate = self
    }
    
}

// MARK: Layout
extension HomeViewController {
    func layout() {
        view.backgroundColor = .backgroundWhite
        topSpacerView.backgroundColor = .white
        
        topSpacerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        
        rootStackView.axis = .vertical
        rootStackView.spacing = 8
        
        scanButton.setTitle("Scan in store", for: .normal)
        scanButton.titleLabel?.minimumScaleFactor = 0.5
        scanButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        scanButton.titleLabel?.adjustsFontSizeToFitWidth = true
        scanButton.backgroundColor = .lightGreen
        scanButton.setTitleColor(.white, for: .normal)
        scanButton.layer.cornerRadius = ScanButtonSpacing.height/2
        
        view.addSubview(topSpacerView)
        view.addSubview(headerView)
        view.addSubview(scrollView)
        view.addSubview(scanButton)
        
        scrollView.addSubview(rootStackView)
        
        for tile in tiles {
            addChild(tile)
            rootStackView.addArrangedSubview(tile.view)
            tile.didMove(toParent: self)
        }
        
        headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)

        NSLayoutConstraint.activate([
            topSpacerView.topAnchor.constraint(equalTo: view.topAnchor),
            topSpacerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSpacerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSpacerView.heightAnchor.constraint(equalToConstant: 100),
            
            headerViewTopConstraint!,
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            rootStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            rootStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            scanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            scanButton.widthAnchor.constraint(equalToConstant: ScanButtonSpacing.width),
            scanButton.heightAnchor.constraint(equalToConstant: ScanButtonSpacing.height),
        ])
    }
}

// MARK: Animating scrollView
extension HomeViewController: UIScrollViewDelegate {
        
    // Snap to position
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y

        let swipingDown = y <= 0
        let shouldSnap = y > 30
        let labelHeight = headerView.greeting.frame.height + 16

        UIView.animate(withDuration: 0.3) {
            self.headerView.greeting.alpha = swipingDown ? 1.0 : 0.0
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.headerViewTopConstraint?.constant = shouldSnap ? -labelHeight : 0
            self.view.layoutIfNeeded()
        })
    }
    
}
