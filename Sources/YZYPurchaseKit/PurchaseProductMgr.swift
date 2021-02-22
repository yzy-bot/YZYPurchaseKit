//
//  BuyMgr.swift
//  photoremove
//
//  Created by edz on 2021/2/2.
//

import Foundation
import SwiftyStoreKit
import StoreKit
import Alamofire

public struct PurchaseDefaultValue {
    public static var purchaseSecret: String = ""
    public static var weeId = "", monId = "", yeaId = ""
    public static var configUrl: URL = URL(string: "www.apple.com")!
    public static var defaultConfigJson = ""
    
    public static let receivedPricesNotification = Notification.Name("receivedPricesNotification")
    public static let purchaseProductNotification = Notification.Name("purchaseProductNotification")
    public static let receivedNetConfigNotification = Notification.Name("receivedNetConfigNotification")

    static let lastedExpiredDateKey = "lateastExpiredDateKey"
    static let havedPurchaseOrRestoreKey = "havedPurchaseOrRestoreKey"
    static let onlineConfigDataKey = "onlineConfigDataKey"
}

public class PurchaseProductMgr {
    static let `default` = PurchaseProductMgr()
    var onlineConfig: PurchaseNetConfig = PurchaseNetConfig(onlineData: Data())
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
    
    enum ShowBuyPage {
        case ocr, location, photo, video, launch, forground
    }
    
    
    static func useOcr() {
        UserDefaults.standard.setValue(true, forKey: "has_use_ocr")
    }
    
    static var hasUseOCR: Bool {
        return UserDefaults.standard.bool(forKey: "has_use_ocr")
    }
    
    static func useRemoveLocation() {
        UserDefaults.standard.setValue(true, forKey: "has_remove_location")
    }
    
    static var hasRemoveLocation: Bool {
        return UserDefaults.standard.bool(forKey: "has_remove_location")
    }
    
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
