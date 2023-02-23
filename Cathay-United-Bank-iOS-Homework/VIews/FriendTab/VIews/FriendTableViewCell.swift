//
//  FriendTableViewCell.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/21.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var transferButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Public Method
extension FriendTableViewCell {
    func updateUI(friend: Friend) {
        self.starIcon.isHidden = friend.isTop == "0"
        self.nameLabel.text = friend.name
        self.transferButton.layer.borderColor = UIColor.accentColor.cgColor
    }
}
