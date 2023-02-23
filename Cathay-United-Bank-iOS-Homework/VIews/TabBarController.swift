//
//  TabBarController.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarBackground()
        selectedIndex = 1
    }
}

// MARK: - Setup
fileprivate extension TabBarController {
    func setupTabs() {
        let moneyVC = UIViewController()
        moneyVC.tabBarItem.image = UIImage(named: "icTabbarProductsOff")
        let friendNC = FriendNavigationController()
        friendNC.tabBarItem.image = UIImage(named: "icTabbarFriendsOn")
        let kokoVC = UIViewController()
        kokoVC.tabBarItem.image = UIImage(named: "icTabbarHomeOff")
        kokoVC.tabBarItem.imageInsets = UIEdgeInsets(top: -11, left: 0, bottom: 11, right: 0)
        let manageVC = UIViewController()
        manageVC.tabBarItem.image = UIImage(named: "icTabbarManageOff")
        let settingVC = UIViewController()
        settingVC.tabBarItem.image = UIImage(named: "icTabbarSettingOff")
        setViewControllers([moneyVC, friendNC, kokoVC, manageVC, settingVC], animated: false)
    }
    
    func setupTabBarBackground() {
        let backgroundImgView = UIImageView(image: UIImage(named: "imgTabbarBg"))
        tabBar.addSubview(backgroundImgView)
        tabBar.sendSubviewToBack(backgroundImgView)
        backgroundImgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImgView.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.bottomAnchor, constant: -7),
            backgroundImgView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            backgroundImgView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor)
        ])
    }
}

// MARK: - Preview Provider
import SwiftUI

struct TabBarControllerView_Provider: PreviewProvider {
    static var previews: some View {
        TabBarControllerView()
    }
    
    struct TabBarControllerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> TabBarController {
            TabBarController()
        }
        
        func updateUIViewController(_ uiViewController: TabBarController, context: Context) { }
    }
}
