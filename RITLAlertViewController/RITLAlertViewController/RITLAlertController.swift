//
//  RITLAlertController.swift
//  RITLAlertViewController
//
//  Created by YueWen on 2019/8/13.
//  Copyright © 2019 YueWen. All rights reserved.
//

import UIKit
import SnapKit

/// 青岛地铁 - 专用AlertController (style = .alert)
final class RITLAlertController: UIViewController {
    
    /// 默认的背景透明度
    static let defaultBackgrondAlpha = 0.5
    
    /// 半透明背景
    var backgroundView = UIView()
    /// alert的视图
    var alertView = UIView()
    /// 设置alertView的圆角
    func setAlertViewController(cornerRadisu: CGFloat){
        alertView.layer.cornerRadius = cornerRadisu
    }
    
    /// 添加action
    func addAction(action: RITLAlertAction) {
        guard let alertView = alertView as? RITLAlertView else { return }
        alertView.addAction(action: action)
    }
    
    
    /// 添加一个数组的action
    func addActions(actions: [RITLAlertAction]) {
        guard let alertView = alertView as? RITLAlertView else { return }
        for action in actions {
            alertView.addAction(action: action)
        }
    }
    
    
    
    /// 获得一个默认的RITLAlertController
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 消息
    ///   - titleConfig: 标题的配置
    ///   - messageConfig: 消息的配置
    convenience init(title: String = "",
                     message: String = "",
                     titleConfig: ((UILabel)->())? = nil,
                     messageConfig:  ((UILabel)->())? = nil) {
        
        self.init(nibName: nil, bundle: nil)
        
        let defaultAlertView = RITLAlertView(title: title, message: message, titleConfig: titleConfig, messageConfig: messageConfig)
        defaultAlertView.viewController = self
        alertView = defaultAlertView
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        transitioningDelegate = self //自己为转场代理
        modalPresentationStyle = .custom //自定义转场
        
        backgroundView.backgroundColor = .black
        backgroundView.alpha = CGFloat(RITLAlertController.defaultBackgrondAlpha)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .clear
        view.addSubview(backgroundView)
        view.addSubview(alertView)
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

extension RITLAlertController: UIViewControllerTransitioningDelegate {
    
    // present 的 动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RITLAlertPresentAnimator()
    }
    
    // dismiss 的 动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RITLAlertDismissAnimator()
    }
}
