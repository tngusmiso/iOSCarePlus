//
//  GameListViewController.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2020/12/16.
//  Copyright © 2020 tngusmiso. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension GameListViewController: UITableViewDelegate {
}

extension GameListViewController: UITableViewDataSource {
    // 한 섹션에 몇개의 열을 보여줄 것인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    // 해당 IndexPath(section, row)에 어떤 셀을 보여줄지!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GameItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GameItemTableViewCell", for: indexPath) as! GameItemTableViewCell
//        cell.setModel(model: model)
        return cell
    }
}
