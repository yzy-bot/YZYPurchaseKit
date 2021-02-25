//
//  File.swift
//  
//
//  Created by zy on 2021/2/23.
//

import Foundation
import SwiftyStoreKit
import StoreKit
import Alamofire

public struct PurchaseDefaultValue {
    
    /// 订阅解码密钥
    public static var purchaseSecret: String = ""
    
    /// 商品id
    public static var weeId = "", monId = "", yeaId = ""
    
    /// 线上配置
    public static var configUrl: URL = URL(string: "www.apple.com")!
    
    /// 默认线上配置
    public static var defaultConfigJson = ""
    
    /// 是否使用服务器校验
    public static var useServerValid: Bool = false
    public static var validServerUrl: String = ""
    public static var appsflyerId: String = ""
    public static var idfa: String = ""
    public static var pkg: String = ""
    
    
    /// 获取到商品价格通知
    public static let receivedPricesNotification = Notification.Name("receivedPricesNotification")
    
    /// 订阅成功，或者订阅过期通知
    public static let purchaseProductNotification = Notification.Name("purchaseProductNotification")
    
    
    /// 获取到线上配置信息通知
    public static let receivedNetConfigNotification = Notification.Name("receivedNetConfigNotification")

    static let lastedExpiredDateKey = "lateastExpiredDateKey"
    static let havedPurchaseOrRestoreKey = "havedPurchaseOrRestoreKey"
    static let onlineConfigDataKey = "onlineConfigDataKey"
}

public class PurchaseProductMgr {
    public static let `default` = PurchaseProductMgr()
    
    public var onlineConfig: PurchaseNetConfig = PurchaseNetConfig.defaultConfig()
}

// info
extension PurchaseProductMgr {
//    static func  showSingle(from: BuyPageFromSource) {
//        DispatchQueue.main.async {
//            if PurchaseProductMgr.isVip {
//                return
//            }
//            let vc = ItemBuyViewController()
//            vc.isSingle = true
//            vc.pageFrom = from
//            if let topvc = UIApplication.getTopViewController() {
//                if topvc is ItemBuyViewController {
//                    return
//                }
//                topvc.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//    }
    
//    static func canShowBuy(page: ShowBuyPage) -> Bool {
//        if PurchaseProductMgr.isVip {
//            return false
//        }
//
//        switch page {
//        case .ocr:
//            return self.hasUseOCR
//        case .location:
//            return self.hasRemoveLocation
//        case .photo:
//            return true
//        case .video:
//            return false
//        case .launch:
//            return  PurchaseProductMgr.default.onlineConfig?.launchShow
//        case .forground:
//            return PurchaseProductMgr.default.onlineConfig?.foregroundShow
//        }
//    }
}
