//
//  UserInfoView.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/15.
//

import UIKit

@IBDesignable class UserInfoView: UIView {

    // MARK: - Variables and Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notSetKokoidBadge: UIView!
    @IBOutlet weak var kokoidButton: UIButton!
    @IBOutlet weak var invitationsView: UIView!
    @IBOutlet weak var invitationsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var invitaionBottomConstraint: NSLayoutConstraint!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var friendBadge: UIView!
    @IBOutlet weak var friendBadgeLabel: UILabel!
    @IBOutlet weak var chatBadge: UIView!
    var invitationCardTopAnchor: [NSLayoutConstraint] = []
    var invitationCardLeadingAnchor: [NSLayoutConstraint] = []
    var invitationCardTrailingAnchor: [NSLayoutConstraint] = []
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
       super.awakeFromNib()
        customInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customInit()
    }
}

// MARK: - Setup
fileprivate extension UserInfoView {
    func customInit() {
        setupView()
        setupButton()
    }
    
    func setupView() {
        let view = Bundle(for: UserInfoView.self).loadNibNamed("\(UserInfoView.self)", owner: self, options: nil)!.first as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    func setupButton() {
        kokoidButton.configuration?.contentInsets = NSDirectionalEdgeInsets.zero
        buttons.forEach { button in
            button.configuration?.contentInsets = NSDirectionalEdgeInsets.zero
        }
    }
}

// MARK: - Action
extension UserInfoView {
    @IBAction func expandCollapseInvitationView(_ sender: UITapGestureRecognizer) {
        if invitationsViewHeight.constant == 80 {
            invitationsViewHeight.constant = CGFloat(80 * invitationCardTopAnchor.count)
            for index in 1..<invitationsView.subviews.count {
                invitationCardTopAnchor[index].constant = CGFloat(80 * index)
                invitationCardLeadingAnchor[index].constant = 0
                invitationCardTrailingAnchor[index].constant = 0
            }
        } else {
            invitationsViewHeight.constant = 80
            for index in 1..<invitationsView.subviews.count {
                invitationCardTopAnchor[index].constant = 10
                invitationCardLeadingAnchor[index].constant = 10
                invitationCardTrailingAnchor[index].constant = -10
            }
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.35, delay: 0) {
            self.superview?.layoutIfNeeded()
        }
    }
}

// MARK: - Public Method
extension UserInfoView {
    func updateUser(user: User) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.nameLabel.text = user.name
            if let kokoid = user.kokoid {
                self.kokoidButton.configuration?.title = "KOKO ID：\(kokoid)"
                self.notSetKokoidBadge.isHidden = true
            } else {
                self.notSetKokoidBadge.isHidden = false
            }
        }
    }
    
    func showInvitaion(friends: [Friend]) {
        invitationsViewHeight.constant = 80
        invitaionBottomConstraint.constant = 22
        for (index, friend) in friends.enumerated() {
            let friendInvitationView = FriendInvitationView(name: friend.name)
            if index == 0 {
                invitationsView.addSubview(friendInvitationView)
            } else {
                invitationsView.insertSubview(friendInvitationView, belowSubview: invitationsView.subviews[0])
            }
            friendInvitationView.translatesAutoresizingMaskIntoConstraints = false
            let topAnchor = friendInvitationView.topAnchor.constraint(equalTo: invitationsView.topAnchor, constant: index == 0 ? 0 : 10)
            topAnchor.isActive = true
            invitationCardTopAnchor.append(topAnchor)
            let leadingAnchor = friendInvitationView.leadingAnchor.constraint(equalTo: invitationsView.leadingAnchor, constant: index == 0 ? 0 : 10)
            leadingAnchor.isActive = true
            invitationCardLeadingAnchor.append(leadingAnchor)
            let trailingAnchor = friendInvitationView.trailingAnchor.constraint(equalTo: invitationsView.trailingAnchor, constant: index == 0 ? 0 : -10)
            trailingAnchor.isActive = true
            invitationCardTrailingAnchor.append(trailingAnchor)
        }
    }
    
    func updateBadge(friendBadgeNum: String?, chatBadgeNum: String?) {
        friendBadge.isHidden = friendBadgeNum == nil
        friendBadgeLabel.text = friendBadgeNum
        chatBadge.isHidden = chatBadgeNum == nil
    }
    
    func resetInvitationsView() {
        invitationsViewHeight.constant = 0
        invitaionBottomConstraint.constant = -5
        invitationsView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        invitationCardTopAnchor.removeAll()
        invitationCardLeadingAnchor.removeAll()
        invitationCardTrailingAnchor.removeAll()
    }
}
