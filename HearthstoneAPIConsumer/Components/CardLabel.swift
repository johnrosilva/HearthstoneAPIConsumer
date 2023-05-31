//
//  File.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 31/05/23.
//

import UIKit

class CardLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    private func setupLabel() {
        font = UIFont.systemFont(ofSize: 16)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        numberOfLines = 0
    }
}
