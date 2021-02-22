//
//  Purchase+Config.swift
//  pkit
//
//  Created by zy on 2021/2/22.
//

import Foundation
import Alamofire

// config
public extension PurchaseProductMgr {
    
    static func requestNetConfig() {
        if let localData =  UserDefaults.standard.data(forKey:  PurchaseDefaultValue.onlineConfigDataKey) {
            PurchaseProductMgr.default.onlineConfig = PurchaseNetConfig(onlineData: localData)
        }
        
        // 添加网络状态监听，如果一开始没有网络，获取不到商品数据，等网络恢复后就去请求商品信息
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { s in
            switch s {
            case .reachable:
                PurchaseProductMgr.requestConfig()
                PurchaseProductMgr.requestItemsInfo(ids: self.proIds)
                if PurchaseProductMgr.isEverPurchased {
                    PurchaseProductMgr.valid(fromRestore: true) { _, purchase, id in
//                        print("xxx")
                    }
                }
            default:
                print("")
            }
        })
    }
    
    static func requestConfig() {
        URLSession.shared.dataTask(with: PurchaseDefaultValue.configUrl) { (data, response, error) in
            guard data != nil else {
                return
            }
            
            if let d = data {
                UserDefaults.standard.setValue(d, forKey: PurchaseDefaultValue.onlineConfigDataKey)
                let onlineConfig = PurchaseNetConfig(onlineData: d)
                let lastShow = PurchaseProductMgr.default.onlineConfig.launchShow
                PurchaseProductMgr.default.onlineConfig = onlineConfig
                if  lastShow == false && PurchaseProductMgr.default.onlineConfig.launchShow == true {
//                    PurchaseProductMgr.showSingle(from: .launch)
                }
                print("xxx- config 更新成功")
                
                NotificationCenter.default.post(name: PurchaseDefaultValue.receivedNetConfigNotification, object: nil)
            }
        }.resume()
    }
}
