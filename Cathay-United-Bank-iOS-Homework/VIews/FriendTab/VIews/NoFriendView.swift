//
//  NoFriendView.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/19.
//

import UIKit

class NoFriendView: UIView {
    
    // MARK: - Variables and Properties
    @IBOutlet weak var addFriendButton: UIButton!
    
    // MARK: - Life Cycle
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
fileprivate extension NoFriendView {
    func customInit() {
        setupView()
        setupAddFriendButton()
    }
    
    func setupView() {
        let view = Bundle.main.loadNibNamed("\(NoFriendView.self)", owner: self, options: nil)!.first as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    func setupAddFriendButton() {
        // 漸層
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = addFriendButton.bounds
        gradientLayer.cornerRadius = 20
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = [UIColor.frogGreen.cgColor, UIColor.booger.cgColor]
        addFriendButton.layer.insertSublayer(gradientLayer, at: 1)
        // 陰影
        addFriendButton.layer.shadowColor = UIColor.appleGreen40.cgColor
        addFriendButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        addFriendButton.layer.shadowRadius = 8
    }
}
