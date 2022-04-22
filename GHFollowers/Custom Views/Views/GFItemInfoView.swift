//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Brandon Rodriguez on 2/25/22.
//

import UIKit

enum itemInfoType {
    
    case repos, gists, followers, following
    
}

class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configure() {
        
        addSubviews(symbolImageView, titleLabel, countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFit
        symbolImageView.tintColor = .label
        
        let symbolImageViewHeight: CGFloat = 20
        let titleLabelHeight: CGFloat = 18
        
        NSLayoutConstraint.activate([
        
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: symbolImageViewHeight),
            symbolImageView.heightAnchor.constraint(equalToConstant: symbolImageViewHeight),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight)
        
        ])
        
    }
    
    func set(itemInfoType: itemInfoType, withCount: Int) {
        
        switch itemInfoType {
            
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
            
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
            
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
            
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
            
        }
        
        countLabel.text = String(withCount)
        
    }

}
