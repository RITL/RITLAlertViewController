//
//  RITLAlertBundle.swift
//  RITLAlertViewController
//
//  Created by YueWen on 2019/8/14.
//  Copyright © 2019 YueWen. All rights reserved.
//

import Foundation
import UIKit

fileprivate extension Bundle {
    
    /// RITLAlertBundle 的主 Bundle
    static func alert_MainBunle() -> Bundle {
        return Bundle(for: RITLAlertController.self)
    }
}



fileprivate extension Bundle {
    
    ///RITLAlertBundle的bundle
    static func alert_bundle() -> Bundle? {
        
        guard let bundlePath = Bundle.alert_MainBunle().path(forResource: "RITLAlertController", ofType: "bundle") else {
            return nil
        }
        return Bundle(path: bundlePath)
    }
}


fileprivate extension String {
    
    func alert_bundleImage() -> UIImage? {
        /// 获得本地资源bundle路径
        guard let path = Bundle.alert_bundle()?.resourcePath else { return nil }
        return UIImage(contentsOfFile: "\(path)/\(self)")
    }
}


/// RITLAlertViewController 使用的图片
enum RITLAlertImage: String {
    
    /// 默认的正常背景
    case default_normal = "ritl_alert_white.png"
    /// 默认的选中背景
    case default_select = "ritl_alert_gray.png"

}

extension RITLAlertImage {
    
    /// RITLAlertViewController
    func image() -> UIImage? {
        return self.rawValue.alert_bundleImage()
    }
}
