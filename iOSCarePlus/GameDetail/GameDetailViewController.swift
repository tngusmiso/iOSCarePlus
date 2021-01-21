//
//  GameDetailViewController.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2021/01/20.
//  Copyright © 2021 tngusmiso. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    @IBOutlet private weak var containerViewController: UIView!
    
    var model: NewGameContents?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? GameDetailPageViewController)?.model = model
    }
}
