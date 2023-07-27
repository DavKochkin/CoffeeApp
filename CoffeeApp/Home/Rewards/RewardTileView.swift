//
//  RewardTileView.swift
//  CoffeeApp
//
//  Created by David Kochkin on 27.07.2023.
//

import UIKit

class RewardTileView: UIView {
    
    let balanceView = BalanceView()
    var rewardsButtons = UIButton()
    let rewardsGraphView = UIView()
    let starRewardsView = UIView()
    var detailsButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 300)
    }
}

extension RewardTileView {
    func style() {
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        rewardsGraphView.translatesAutoresizingMaskIntoConstraints = false
        starRewardsView.translatesAutoresizingMaskIntoConstraints = false
        
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.titleLabel?.text = "Details"
        
        makeRewardsOptionButton()
        
        detailsButton.backgroundColor = .systemBlue
    }
    
    func makeRewardsOptionButton() {
        rewardsButtons.translatesAutoresizingMaskIntoConstraints = false
        
        rewardsButtons.configuration = .plain()
        
        rewardsButtons.configuration?.title = "Rewards Options"
        rewardsButtons.configuration?.baseForegroundColor = .darkGray
        rewardsButtons.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        rewardsButtons.configuration?.image = UIImage(systemName: "chevron.down")
        rewardsButtons.configuration?.imagePadding = 2
        rewardsButtons.configuration?.imagePlacement = .trailing
        rewardsButtons.configuration?.imageColorTransformer = .preferredTint
        
        //  rewardsButtons.addTarget(self, action: #selector(rewardOptionsTapped), for: .primaryActionTriggered)
    
    }
    
    func layout() {
        addSubview(balanceView)
        addSubview(rewardsButtons)
        addSubview(rewardsGraphView)
        addSubview(starRewardsView)
        addSubview(detailsButton)
    
        
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: topAnchor),
            balanceView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            rewardsButtons.centerYAnchor.constraint(equalTo: balanceView.pointsLabel.centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rewardsButtons.trailingAnchor, multiplier: 3),
            
            rewardsGraphView.topAnchor.constraint(equalToSystemSpacingBelow: balanceView.bottomAnchor, multiplier: 1),
            rewardsGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            rewardsGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            
            starRewardsView.topAnchor.constraint(equalTo: rewardsGraphView.bottomAnchor, constant: 8),
            starRewardsView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: starRewardsView.trailingAnchor, multiplier: 1),
            
            detailsButton.topAnchor.constraint(equalToSystemSpacingBelow: starRewardsView.bottomAnchor, multiplier: 2),
            detailsButton.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor),
            bottomAnchor.constraint(equalToSystemSpacingBelow: detailsButton.bottomAnchor, multiplier: 2),
            
        ])
    }
}
