//
//  SelectableButton.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2021/01/20.
//  Copyright © 2021 tngusmiso. All rights reserved.
//

import UIKit

class SelectableButton: UIButton {
    // view가 메모리가 로드 된 다음 호출되는 함수
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitleColor(UIColor(named: "black"), for: .selected)
        setTitleColor(UIColor(named: "veryLightPink"), for: .normal)
        tintColor = .clear
    }

//    func select(_ selected: Bool) {
//        if selected {
//            setTitleColor(.black, for: .normal)
//        } else {
//            setTitleColor(UIColor.init(named: "veryLightPink"), for: .normal)
//        }
}
