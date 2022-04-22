//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Brandon Rodriguez on 2/23/22.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    
    func didRequestFollowers(for username: String)
    
}

class UserInfoVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var itemViews: [UIView] = []
    var username: String!
    
    weak var delegate: UserInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
        
    }
    
    func configureViewController() {
        
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func configureScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
        
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        
        ])
        
    }
    
    func getUserInfo() {
        
        Task {
            
            do {
                
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                configureUIElements(with: user)
                
            } catch {
                
                if let gfError = error as? GFError {
                    
                    presentGFAlert(title: "Something went wrong", message: gfError.rawValue, buttonTitle: "Ok")
                    
                } else {
                    
                    presentDefaultError()
                    
                }
                
            }
            
        }
        
    }
    
    func configureUIElements(with user: User) {
        
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemView1)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemView2)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "GitHub Since \(user.createdAt.convertToMonthYearFormat())"
        
    }
    
    func layoutUI() {
        
        itemViews = [headerView, itemView1, itemView2, dateLabel]
        
        let padding: CGFloat = 20
        let headerViewHeight: CGFloat = 210
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            
            contentView.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
            
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            
            ])
            
        }
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerViewHeight),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    @objc func dismissVC() {
        
        dismiss(animated: true)
        
    }
    
}

extension UserInfoVC: GFRepoItemVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        
        guard let url = URL(string: user.htmlUrl) else {

            presentGFAlert(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "OK")
            return

        }

        presentSafariVC(with: url)
        
    }
    
}

extension UserInfoVC: GFFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        
        guard user.followers != 0 else {

            presentGFAlert(title: "No followers", message: "This user has no followers. What a shame 😔.", buttonTitle: "OK")
            return

        }

        delegate.didRequestFollowers(for: user.login)
        dismissVC()
        
    }

}
