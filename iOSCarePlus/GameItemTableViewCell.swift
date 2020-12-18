//
//  GameItemTableViewCell.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2020/12/16.
//  Copyright © 2020 tngusmiso. All rights reserved.
//

import Kingfisher
import UIKit

class GameItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameTitleLabel: UILabel!
    @IBOutlet private weak var gameOriginPriceLabel: UILabel!
    @IBOutlet private weak var gameCurrentPriceLabel: UILabel!
    
    private var model: GameItemModel? {
        didSet {
            setUIFromModel()
        }
    }
    
    func setModel(model: GameItemModel) {
        self.model = model
    }
    
    func setUIFromModel() {
        guard let model = model else { return }
        
        let imageURL: URL? = URL(string: model.imageURL)
        gameImageView.kf.setImage(with: imageURL)
        gameImageView.layer.cornerRadius = 9
        gameImageView.layer.borderWidth = 1
        gameImageView.layer.borderColor = UIColor(red: 236 / 255, green: 236 / 255, blue: 236 / 255, alpha: 1).cgColor
        
        self.gameTitleLabel.text = model.gameTitle
        if let gameDiscountPrice: Int = model.gameDiscountPrice {
            self.gameOriginPriceLabel.isHidden = false
            self.gameOriginPriceLabel.text = "\(model.gameOriginPrice)"
            self.gameCurrentPriceLabel.text = "\(gameDiscountPrice)"
        } else {
            self.gameOriginPriceLabel.isHidden = true
            self.gameCurrentPriceLabel.text = "\(model.gameOriginPrice)"
        }
    }
}
