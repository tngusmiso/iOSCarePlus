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
    @IBOutlet private weak var newButton: SelectableButton!
    @IBOutlet private weak var saleButton: SelectableButton!
    @IBOutlet private weak var selectedLineConstraints: NSLayoutConstraint!
    
    @IBAction private func touchUpNewButton(_ sender: Any) {
        newButton.isSelected = true
        saleButton.isSelected = false
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.selectedLineConstraints.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    @IBAction private func touchUpSaleButton(_ sender: Any) {
        newButton.isSelected = false
        saleButton.isSelected = true
        
        let constant: CGFloat = saleButton.center.x - newButton.center.x
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.selectedLineConstraints.constant = constant
            self?.view.layoutIfNeeded()
        }
    }
    
    private var newGameListURL: String { // ComputedProperty - getter만 있고, 한줄로 표현 가능한 형태
        "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    private let newCount: Int = 10
    private var newOffset: Int = 0
    private var isEndOfData: Bool = false
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
            guard let data = response.data else { return }
            let decoder: JSONDecoder = JSONDecoder()
            guard let responseModel: NewGameResponse = try? decoder.decode(NewGameResponse.self, from: data) else {
                return
            }
            
            if self?.model == nil {
                self?.model = responseModel
            } else {
                if responseModel.contents.isEmpty {
                    self?.isEndOfData = true
                }
                self?.model?.contents.append(contentsOf: responseModel.contents)
            }
        }
    }
}

// MARK: - TableView Delegate
extension GameListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailPageViewController") as? GameDetailPageViewController else { return }
        
        pageViewController.model = model?.contents[indexPath.row]
        navigationController?.pushViewController(pageViewController, animated: true)
    }
}

// MARK: - TableView DataSource
extension GameListViewController: UITableViewDataSource {
    // 한 섹션에 몇개의 열을 보여줄 것인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 응답을 받기 전에
        guard let model = model else {
            return 0
        }
        // 더이상 데이터가 없을 때
        if isEndOfData {
            return model.contents.count
        }
        // 데이터가 남아있을 때
        return model.contents.count + 1
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
        
        // IndicatorCell을 보여주는 경우
        if isIndicatorCell(indexPath) {
            guard let indicatorCell: IndicatorCell = tableView.dequeueReusableCell(withIdentifier: "IndicatorCell", for: indexPath) as? IndicatorCell else {
                return UITableViewCell()
            }
            indicatorCell.animateIndicator()
            return indicatorCell
        }
        
        // GameItemTableViewCell을 보여주는 경우
        guard let cell: GameItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell,
              let content = model?.contents[indexPath.row] else {
            return UITableViewCell()
        }
        
        let screenshotURLs: [String] = content.screenshots.reduce(into: []) {
            $0.append(contentsOf: $1.images.map {
                        $0.url
            })
        }
        let model: GameItemModel = GameItemModel(gameTitle: content.formalName,
                                                 gameOriginPrice: 10_000,
                                                 gameDiscountPrice: nil,
                                                 imageURL: content.heroBannerURL,
                                                 screenshotURLs: screenshotURLs)
        cell.setModel(model: model)
        return cell
    }
}
