//
//  ViewController.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2020/12/04.
//  Copyright © 2020 tngusmiso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var logoView: UIView!
    @IBOutlet private weak var logoViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var backgroundImageViewLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        logoView.layer.cornerRadius = 15
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationSettingDefault()
        apperLogoAnimation {[weak self] in
            self?.slideBackgroundImageAnimation()
            self?.blinkLogoAnimation()
        }
    }
    
    private func animationSettingDefault() {
        logoViewTopConstraint.constant = -200
        backgroundImageViewLeadingConstraint.constant = 0
        logoView.alpha = 1
        view.layoutIfNeeded()
    }
    
    private func apperLogoAnimation(completion: @escaping () -> Void) {
        let animationClouser = {[weak self] in
            self?.logoViewTopConstraint.constant = 17
            self?.view.layoutIfNeeded() // 제약조건을 업데이트 했으니 화면도 업데이트 하라는 코드
        }
        
        let after: (Bool) -> Void = { _ in
            completion()
        }
        
        UIView.animate(withDuration: 0.7,
                       delay: 1,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [],
                       animations: animationClouser,
                       completion: after)
    }
    
    private func slideBackgroundImageAnimation() {
        UIView.animate(withDuration: 10, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse]) { [weak self] in
                self?.backgroundImageViewLeadingConstraint.constant = -800
                self?.view.layoutIfNeeded()
        }
    }
    
    private func blinkLogoAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) { [weak self] in
            self?.logoView.alpha = 0
        }
    }
}

