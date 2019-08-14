//
//  QDAlertGroupView.swift
//  RITLAlertViewController
//
//  Created by YueWen on 2019/8/13.
//  Copyright © 2019 YueWen. All rights reserved.
//

import UIKit

//全局变量

/// 间距
private let ritl_alert_padding = CGFloat(15.0)
/// 弹窗的总宽度
private let ritl_alert_alertWidth = CGFloat(260.0)
/// 内容宽度
private let ritl_alert_containerWidth = ritl_alert_alertWidth - 2 * ritl_alert_padding
/// 按钮高度
private let ritl_alert_buttonHeight = CGFloat(46.0)


final class RITLAlertView: UIView {
    
    /// 用来保存当前的视图控制器，用于dismiss
    weak var viewController: UIViewController?
    /// 保存事件的数组
    private var actions = [RITLAlertAction]()
    /// 保存按钮的数组
    private var buttons = [UIButton]()
    /// scrollView 外层容器视图
    private let containerView = UIView()
    /// 滚动视图
    private let scrollView = UIScrollView()
    /// 标题
    private let titleLabel = UILabel()
    /// 消息
    private let messageLabel = UILabel()
    
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /// 创建一个RITLAlertView
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 消息
    ///   - titleConfig: 标题的标签设置
    ///   - messageConfig: 消息的标签设置
    convenience init(title: String = "",
                     message: String = "",
                     titleConfig: ((UILabel)->())? = nil,
                     messageConfig:  ((UILabel)->())? = nil) {
        self.init(frame: .zero)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        //add subviews
        addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(messageLabel)
        
        containerView.backgroundColor = .white
        
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = ALFont.medium.al_font(size: 16)
        titleLabel.textColor = #colorLiteral(red: 0.2980392157, green: 0.3019607843, blue: 0.2980392157, alpha: 1)
        titleConfig?(titleLabel)
        
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = ALFont.regular.al_font(size: 14)
        messageLabel.textColor = #colorLiteral(red: 0.3450980392, green: 0.3490196078, blue: 0.3490196078, alpha: 1)
        messageConfig?(messageLabel)
        
        //添加约束
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(ritl_alert_containerWidth)
            make.left.top.right.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.width.equalTo(ritl_alert_containerWidth)
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        //计算高度
        let scrollViewHeight = titleLabel.sizeThatFits(CGSize(width: ritl_alert_containerWidth, height: 0)).height + messageLabel.sizeThatFits(CGSize(width: ritl_alert_containerWidth, height: 0)).height + 12/*title和message间距*/ + ritl_alert_padding
        
        scrollView.snp.makeConstraints { (make) in
            make.width.equalTo(ritl_alert_containerWidth)
            make.height.equalTo(scrollViewHeight).priority(.low)
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
        
        let maxHeight = UIScreen.main.bounds.height - 100.0
        containerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
        }
        
        //自己的约束
        snp.makeConstraints { (make) in
            make.height.lessThanOrEqualTo(maxHeight)
        }
    }
    
    
    /// 添加一个action
    func addAction(action: RITLAlertAction){
        // 添加数据
        actions.append(action)
        //创建button
        let actionButton = UIButton(type: .custom)
        actionButton.tag = actions.count - 1
        actionButton.setTitle(action.title, for: .normal)
        actionButton.setTitleColor(#colorLiteral(red: 0.3490196078, green: 0.3490196078, blue: 0.3490196078, alpha: 1), for: .normal)
        actionButton.titleLabel?.font = ALFont.regular.al_font(size: 16)
        actionButton.setBackgroundImage(RITLAlertImage.default_normal.image(), for: .normal)
        actionButton.setBackgroundImage(RITLAlertImage.default_select.image(), for: .highlighted)
        actionButton.addTarget(self, action: #selector(actionButtonDidTap(sender:)), for: .touchUpInside)
        switch action.style {
        case .destructive:
            actionButton.setTitleColor(.red, for: .normal)
        case .cancle:
            actionButton.titleLabel?.font = ALFont.bold.al_font(size: 15)
        case .custom(let config):
            config?(actionButton)
        default: break
        }
        
        //添加到父视图
        addSubview(actionButton)
        //添加到button组
        buttons.append(actionButton)
        //因为可能添加多个 button，所以只要标记为需要更新，这样即使添加了多次也只会更新一次
        setNeedsUpdateConstraints()
    }

    /// 按钮的点击时间
    @objc func actionButtonDidTap(sender: UIButton){
        //根据tag获得hander
        guard sender.tag < actions.count else { return }
        actions[sender.tag].handler?()
        //点击button自动dismiss
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    override func updateConstraints() {
        
        // 根据当前button的数量来布局
        switch buttons.count {
        case 2: layoutButtonsHorizontal()
        default: layoutButtonsVertica()
        }
        
        super.updateConstraints()
    }
    
    /// 两个按钮的水平布局
    private func layoutButtonsHorizontal() {
        guard buttons.count >= 2, let leftButton = buttons.first else { return }
        let rightButton = buttons[1]
        
        //按钮进行布局
        leftButton.snp.makeConstraints { (make) in
            make.height.equalTo(ritl_alert_buttonHeight)
            make.left.equalToSuperview()
            make.top.equalTo(containerView.snp.bottom)
            make.right.equalTo(rightButton.snp.left)
            make.width.equalTo(rightButton)
        }
        
        rightButton.snp.makeConstraints { (make) in
            make.height.equalTo(ritl_alert_buttonHeight)
            make.right.equalToSuperview()
            make.top.equalTo(containerView.snp.bottom)
        }
        
        snp.makeConstraints { (make) in
            make.bottom.equalTo(rightButton.snp.bottom)
        }
    }
    
    /// 多个按钮的垂直布局
    private func layoutButtonsVertica() {
        
        var lastView = containerView
        for button in buttons {
            //进行布局
            button.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(lastView.snp.bottom)
                make.height.equalTo(ritl_alert_buttonHeight)
            }
            
            lastView = button
        }
        
        snp.makeConstraints { (make) in
            make.bottom.equalTo(lastView.snp.bottom)
        }
    }
    
    override class var requiresConstraintBasedLayout: Bool { return true }

}



//MARK: Font

/// 字体
fileprivate enum ALFont: String {
    
    case regular = "PingFangSC-Regular"
    case medium = "PingFangSC-Medium"
    case bold = "PingFangSC-Bold"
    case light = "PingFangSC-Light"
    case semibold = "PingFangSC-Semibold"
}


fileprivate extension ALFont {
    func al_font(size: CGFloat) -> UIFont {
        return UIFont.alSafe_font(name: self.rawValue, size: size)
    }
}


fileprivate extension UIFont {
    
    /// 根据字体名字获取font对象，如果不存在，返回系统默认字体
    ///
    /// - Parameters:
    ///   - name: 字体类型
    ///   - size: 字体大小
    class func alSafe_font(name: String, size: CGFloat) -> UIFont{
        if let font = UIFont(name: name, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
}
