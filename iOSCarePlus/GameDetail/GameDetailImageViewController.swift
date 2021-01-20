//
//  GameDetailImageViewController.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2021/01/20.
//  Copyright © 2021 tngusmiso. All rights reserved.
//

import Kingfisher
import UIKit

class GameDetailImageViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let stringURL = url else { return }
        let url: URL? = URL(string: stringURL)
        imageView.kf.setImage(with: url)
    }
}
