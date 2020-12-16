//
//  GameListViewController.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2020/12/16.
//  Copyright © 2020 tngusmiso. All rights reserved.
//
import Alamofire
import UIKit

class GameListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    let newGameListURL: String = "https://ec.nintendo.com/api/KR/ko/search/new?count=30&offset=0"
    var model: NewGameResponse? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callNewGameListAPI()
    }
    
    private func callNewGameListAPI() {
        // get, parameter 등이 없는 채로 통신 요청
        AF.request(newGameListURL).responseJSON { [weak self] response in
            // 통신 결과 response를 여기서 작업
            guard let data = response.data else { return }
    
            let decoder: JSONDecoder = JSONDecoder()
            let model = try? decoder.decode(NewGameResponse.self, from: data)
            self?.model = model
        }
    }
}

extension GameListViewController: UITableViewDelegate {
}

extension GameListViewController: UITableViewDataSource {
    // 한 섹션에 몇개의 열을 보여줄 것인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.contents.count ?? 0
    }
    
    // 해당 IndexPath(section, row)에 어떤 셀을 보여줄지!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let content = model?.contents[indexPath.row] else { return UITableViewCell() }
        let cell: GameItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GameItemTableViewCell", for: indexPath) as! GameItemTableViewCell
        let model: GameItemModel = GameItemModel(gameTitle: content.formalName, gameOriginPrice: 1_000, gameDiscountPrice: nil, imageURL: content.heroBannerURL)
        
        cell.setModel(model: model)        
        return cell
    }
}
