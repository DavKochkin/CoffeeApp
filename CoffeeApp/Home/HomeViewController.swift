//
//  ViewController.swift
//  CoffeeApp
//
//  Created by David Kochkin on 25.07.2023.
//

import UIKit

class HomeViewController: CoffeeAppViewController {
    
    let headerView = HomeHeaderView()
    let scrollView = UIScrollView()
    let rootStackView = UIStackView()
    
    var headerViewTopConstraint: NSLayoutConstraint?
    
    let tiles = [
                TileView("Star balance"),
                TileView("Bonus stars"),
                TileView("Try these"),
                TileView("Welcome back"),
                TileView("Uplifting")
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
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemPink

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
        rootStackView.axis = .vertical
        rootStackView.spacing = 8
        
        view.addSubview(headerView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(rootStackView)
        
        for tile in tiles {
            addChild(tile)
            rootStackView.addArrangedSubview(tile.view)
            tile.didMove(toParent: self)
        }
        
        headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)

        NSLayoutConstraint.activate([
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
