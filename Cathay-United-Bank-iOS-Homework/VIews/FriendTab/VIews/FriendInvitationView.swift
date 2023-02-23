//
//  FriendInvitationView.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/22.
//

import UIKit

class FriendInvitationView: UIView {
    
    // MARK: - Variables and Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Life Cycle
    init(name: String) {
        super.init(frame: CGRect())
        customInit()
        nameLabel.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
}

// MARK: - Setup
fileprivate extension FriendInvitationView {
    func customInit() {
        setupView()
    }
    
    func setupView() {
        let view = Bundle.main.loadNibNamed("\(FriendInvitationView.self)", owner: self, options: nil)!.first as! UIView
        view.frame = bounds
        addSubview(view)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    }
}
