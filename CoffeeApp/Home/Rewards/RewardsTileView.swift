//
//  RewardTileView.swift
//  CoffeeApp
//
//  Created by David Kochkin on 27.07.2023.
//

import UIKit

class RewardsTileView: UIView {
    
    let balanceView = BalanceView()
    var rewardsButtons = UIButton()
    let rewardsGraphView = RewardsGraphView()
    let starRewardsView = StarRewardsView()
    var detailsButton = UIButton()
    
    var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RewardsTileView {
    func style() {
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        rewardsGraphView.translatesAutoresizingMaskIntoConstraints = false
        starRewardsView.translatesAutoresizingMaskIntoConstraints = false
        
        makeRewardsOptionButton()
        
        detailsButton = makeClearButton(withText: "Details")
    }
    
    func makeRewardsOptionButton() {
        rewardsButtons.translatesAutoresizingMaskIntoConstraints = false
        rewardsButtons.addTarget(self, action: #selector(rewardOptionsTapped), for: .primaryActionTriggered)
        
        rewardsButtons.configuration = .plain()
        
        rewardsButtons.configuration?.title = "Rewards Options"
        rewardsButtons.configuration?.baseForegroundColor = .darkGray
        rewardsButtons.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        rewardsButtons.configuration?.image = UIImage(systemName: "chevron.down")
        rewardsButtons.configuration?.imagePadding = 2
        rewardsButtons.configuration?.imagePlacement = .trailing
        rewardsButtons.configuration?.imageColorTransformer = .preferredTint
    
    }
    
    func layout() {
        addSubview(balanceView)
        addSubview(rewardsButtons)
        addSubview(rewardsGraphView)
        addSubview(starRewardsView)
        addSubview(detailsButton)
        
        heightConstraint = starRewardsView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: topAnchor),
            balanceView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            rewardsButtons.centerYAnchor.constraint(equalTo: balanceView.pointsLabel.centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rewardsButtons.trailingAnchor, multiplier: 3),
            
            rewardsGraphView.topAnchor.constraint(equalToSystemSpacingBelow: balanceView.bottomAnchor, multiplier: 1),
            rewardsGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            rewardsGraphView.widthAnchor.constraint(equalToConstant: frame.width), 
            rewardsGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rewardsGraphView.trailingAnchor, multiplier: 2),
            
            starRewardsView.topAnchor.constraint(equalTo: rewardsGraphView.bottomAnchor, constant: 8),
            starRewardsView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: starRewardsView.trailingAnchor, multiplier: 1),
            heightConstraint!,
            
            detailsButton.topAnchor.constraint(equalToSystemSpacingBelow: starRewardsView.bottomAnchor, multiplier: 2),
            detailsButton.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor),
            bottomAnchor.constraint(equalToSystemSpacingBelow: detailsButton.bottomAnchor, multiplier: 2),
            
        ])
        
        starRewardsView.isHidden = true
    }
    
    // Redraw our graph once we know our actual device width & height
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rewardsGraphView.actualFrameWidth = frame.width
        rewardsGraphView.drawRewardsGraph()
    }
}

// MARK: Actions
extension RewardsTileView {
    @objc func rewardOptionsTapped() {
        
        if heightConstraint?.constant == 0 {
            self.setChevronUp()
            
            let heightAnimator = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut) {
                self.heightConstraint?.constant = 270
                self.layoutIfNeeded()
            }
            heightAnimator.startAnimation()
            
            let alphaAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
                self.starRewardsView.isHidden = false
                self.starRewardsView.alpha = 1
            }
            alphaAnimator.startAnimation(afterDelay: 0.5)
            
        } else {
            self.setChevronDown()
            
            let animator = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut) {
                self.heightConstraint?.constant = 0
                self.starRewardsView.isHidden = true
                self.starRewardsView.alpha = 0
                self.layoutIfNeeded()
            }
            animator.startAnimation()
        }
    }
    
    @objc func detailsButtonTapper() {
        print("Details tapeed!!!")
    }
    
    private func setChevronUp() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.up", withConfiguration: configuration)
        rewardsButtons.setImage(image, for: .normal)
    }
    
    private func setChevronDown() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        rewardsButtons.setImage(image, for: .normal)
    }
}
