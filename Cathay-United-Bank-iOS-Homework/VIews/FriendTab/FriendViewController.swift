//
//  FriendViewController.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/13.
//

import UIKit

class FriendViewController: UIViewController {

    // MARK: - Constants
    let userViewModel = UserViewModel()
    let friendViewModel = FriendViewModel()
    
    // MARK: - Variables and Properties
    @IBOutlet weak var userInfoView: UserInfoView!
    var userInfoViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSelectApiActionSheet()
    }
}

// MARK: - Setup
fileprivate extension FriendViewController {
    func showSelectApiActionSheet() {
        let controller = UIAlertController(title: "Choose Situation", message: nil, preferredStyle: .actionSheet)
        FriendSituation.allCases.forEach { situation in
            let action = UIAlertAction(title: situation.description, style: .default) { _ in
                self.friendViewModel.situation = situation
                self.fetchFriendData()
            }
            controller.addAction(action)
        }
        present(controller, animated: true)
    }
    
    func setupFriendView() {
        userInfoView.resetInvitationsView()
        if friendViewModel.friends.isEmpty {
            userInfoView.updateBadge(friendBadgeNum: nil, chatBadgeNum: nil)
            showNoFriendView()
        } else {
            let invitaions = friendViewModel.friends.filter { $0.status == 2 }
            if !invitaions.isEmpty {
                userInfoView.showInvitaion(friends: invitaions)
                userInfoView.updateBadge(friendBadgeNum: "\(invitaions.count)", chatBadgeNum: "99+")
            } else {
                userInfoView.updateBadge(friendBadgeNum: nil, chatBadgeNum: "99+")
            }
            showFriendTableView()
        }
    }
}

// MARK: - UITableViewDelegate
extension FriendViewController: FriendTableViewDelegate {
    func searchBarTextDidBeginEditing(_ controller: FriendTableView) {
        let blankOnTap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(blankOnTap)
        userInfoViewHeightConstraint = userInfoView.heightAnchor.constraint(equalToConstant: 0)
        userInfoViewHeightConstraint?.isActive = true
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.35, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBarTextDidEndEditing(_ controller: FriendTableView) {
        view.gestureRecognizers?.removeAll()
        userInfoViewHeightConstraint?.isActive = false
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.35, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Private Method
private extension FriendViewController {
    func fetchUserData() {
        userViewModel.fetchUserData { result in
            switch result {
            case .success(let user):
                self.userInfoView.updateUser(user: user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchFriendData() {
        friendViewModel.fetchFriendsFromMultipleAPIs { result in
            switch result {
            case .success():
                self.setupFriendView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showNoFriendView() {
        let noFriendView = NoFriendView()
        noFriendView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noFriendView)
        NSLayoutConstraint.activate([
            noFriendView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            noFriendView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noFriendView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noFriendView.bottomAnchor.constraint(equalTo: tabBarController!.tabBar.topAnchor)
        ])
    }
    
    func showFriendTableView() {
        let friendTableView = FriendTableView(friendViewModel: friendViewModel)
        friendTableView.delegate = self
        friendTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(friendTableView)
        NSLayoutConstraint.activate([
            friendTableView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            friendTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            friendTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            friendTableView.bottomAnchor.constraint(equalTo: tabBarController!.tabBar.topAnchor)
        ])
    }
}
