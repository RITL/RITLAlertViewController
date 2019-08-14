//
//  QDAlertAction.swift
//  RITLAlertViewController
//
//  Created by YueWen on 2019/8/13.
//  Copyright © 2019 YueWen. All rights reserved.
//

import UIKit


final class RITLAlertAction: NSObject {
    
    enum ActionStyle {
        /// 自定义
        case custom(config: ((UIButton)->())?)
        /// 取消
        case cancle
        /// 警示
        case destructive
        /// 普通
        case normal
    }
    

    /// 标题
    var title = ""
    /// 点击事件
    var handler: (()->())?
    /// 类型
    var style = ActionStyle.normal 
    
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - title:  显示的文字
    ///   - style: 风格
    ///   - tapHander: 点击事件
    convenience init(title: String = "", style: RITLAlertAction.ActionStyle = .normal, tapHander: (()->())? = nil) {
        self.init()
        self.title = title
        self.style = style
        handler = tapHander
    }
}
