//
//  Cell.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 27/05/23.
//

import Foundation
import UIKit

class CardListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CardListTableViewCell"
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(cardImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        
        NSLayoutConstraint.activate([
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardImageView.widthAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            typeLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 16),
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with card: Card) {
        cardImageView.image = UIImage(named: "default_card")
        nameLabel.text = card.name
        typeLabel.text = card.type
    }
}

