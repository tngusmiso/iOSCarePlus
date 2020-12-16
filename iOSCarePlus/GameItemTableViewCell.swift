//
//  GameItemTableViewCell.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2020/12/16.
//  Copyright © 2020 tngusmiso. All rights reserved.
//

import UIKit

class GameItemTableViewCell: UITableViewCell {
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameOriginPriceLabel: UILabel!
    @IBOutlet weak var gameCurrentPriceLabel: UILabel!
    
    private var model: GameItemModel?
    
    func setModel(model: GameItemModel){
        self.model = model
    }
    
    func setUIFromModel() {
        guard let model = model else { return }
        
        self.gameTitleLabel.text = model.gameTitle
        
        if let gameDiscountPrice = model.gameDiscountPrice {
            self.gameOriginPriceLabel.text = "\(model.gameOriginPrice)"
            self.gameCurrentPriceLabel.text = "\(gameDiscountPrice)"
        } else {
            self.gameCurrentPriceLabel.text = "\(model.gameOriginPrice)"
        }
    }
}
