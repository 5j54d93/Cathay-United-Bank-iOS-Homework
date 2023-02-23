//
//  FriendNavigationController.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/13.
//

import UIKit

class FriendNavigationController: UINavigationController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        setupViewControllers()
    }
}

// MARK: - Setup
fileprivate extension FriendNavigationController {
    func setupViewControllers() {
        let FriendVC: FriendViewController = {
            let FriendVC = FriendViewController()
            let atmBarButtonItem = UIBarButtonItem(image: UIImage(named: "icNavPinkWithdraw"), landscapeImagePhone: nil, style: .plain, target: self, action: nil)
            let transferBarButtonItem = UIBarButtonItem(image: UIImage(named: "icNavPinkTransfer"), landscapeImagePhone: nil, style: .plain, target: self, action: nil)
            FriendVC.navigationItem.leftBarButtonItems = [atmBarButtonItem, transferBarButtonItem]
            FriendVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icNavPinkScan"), landscapeImagePhone: nil, style: .plain, target: self, action: nil)
            return FriendVC
        }()
        setViewControllers([FriendVC], animated: false)
    }
    
    func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .whiteTwo
        navigationBarAppearance.shadowColor = .whiteTwo
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
