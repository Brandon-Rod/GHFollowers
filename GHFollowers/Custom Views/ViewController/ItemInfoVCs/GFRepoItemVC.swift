//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Brandon Rodriguez on 3/8/22.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
    
    func didTapGitHubProfile(for user: User)
    
}

class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: GFRepoItemVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
    }
    
    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        
        self.delegate = delegate
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configureItems() {
        
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
        
    }
    
    override func actionButtonTapped() {
        
        delegate.didTapGitHubProfile(for: user)
        
    }
    
}
