//
//  IndicatorCell.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2020/12/23.
//  Copyright © 2020 tngusmiso. All rights reserved.
//

import UIKit

class IndicatorCell: UITableViewCell {
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    func animateIndicator() {
        indicator.startAnimating()
    }
}
