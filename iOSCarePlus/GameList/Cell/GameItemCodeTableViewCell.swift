//
//  GameItemCodeTableViewCell.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2020/12/23.
//  Copyright © 2020 tngusmiso. All rights reserved.
//

import UIKit

class GameItemCodeTableViewCell: UITableViewCell {
    var gameImageView: UIImageView
    var titleLabel: UILabel
    var priceLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        gameImageView = UIImageView()
        titleLabel = UILabel()
        priceLabel = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gameImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            gameImageView.widthAnchor.constraint(equalToConstant: 122),
            gameImageView.heightAnchor.constraint(equalToConstant: 69)
        ])
        
        gameImageView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 15)
        ])
        
        titleLabel.text = "test"
    }
}

