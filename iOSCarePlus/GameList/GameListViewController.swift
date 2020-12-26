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
    private var newGameListURL: String { // ComputedProperty - getter만 있고, 한줄로 표현 가능한 형태
        "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    private let newCount: Int = 10
    private var newOffset: Int = 0
    private var isEnd: Bool = false
    private var model: NewGameResponse? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView.register(GameItemCodeTableViewCell.self, forCellReuseIdentifier: "GameItemCodeTableViewCell")
        callNewGameListAPI()
    }
    
    private func isIndicatorCell(_ indexPath: IndexPath) -> Bool {
        indexPath.row == model?.contents.count
    }
    
    private func callNewGameListAPI() {
        // get, parameter 등이 없는 채로 통신 요청
        AF.request(newGameListURL).responseJSON { [weak self] response in
            // 통신 결과 response를 여기서 작업
            guard let data = response.data else { return }
            
            // response 안에 들어있는 data 디코딩
            let decoder: JSONDecoder = JSONDecoder()
            guard let model: NewGameResponse = try? decoder.decode(NewGameResponse.self, from: data) else {
                return
            }
            
            if self?.model == nil {
                self?.model = model
            } else {
                if model.contents.isEmpty {
                    self?.isEnd = true
                }
                self?.model?.contents.append(contentsOf: model.contents)
            }
        }
    }
}

extension GameListViewController: UITableViewDelegate {
}

extension GameListViewController: UITableViewDataSource {
    // 한 섹션에 몇개의 열을 보여줄 것인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEnd { return model?.contents.count ?? 0 }
        return (model?.contents.count ?? 0) + 1
    }
    
    // 해당 IndexPath의 Cell이 보여지기 직전에 호출됨
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == model?.contents.count {
            newOffset += 10
            callNewGameListAPI()
        }
    }
    
    // 해당 IndexPath의 Cell이 그려지기 직전에 호출됨
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell: GameItemCodeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GameItemCodeTableViewCell", for: indexPath) as! GameItemCodeTableViewCell
        
        // 마지막 셀일 때 인디케이터가 포함된 셀을 보여준다
        if isIndicatorCell(indexPath) {
            guard let indicatorCell: IndicatorCell = tableView.dequeueReusableCell(withIdentifier: "IndicatorCell", for: indexPath) as? IndicatorCell else { return UITableViewCell() }
            indicatorCell.animateIndicator()
            return indicatorCell
        }
        
        guard let cell: GameItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell,
            let content = model?.contents[indexPath.row] else { return UITableViewCell() }
        let screenshotURLs: [String] = content.screenshots.reduce(into: []) { $0.append(contentsOf: $1.images.map { $0.url }) }
        let model: GameItemModel = GameItemModel(gameTitle: content.formalName,
                                                 gameOriginPrice: 10_000,
                                                 gameDiscountPrice: nil,
                                                 imageURL: content.heroBannerURL,
                                                 screenshotURLs: screenshotURLs)
        cell.setModel(model: model)
        return cell
    }
}
