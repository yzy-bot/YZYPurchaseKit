//
//  BuyModel.swift
//  photoremove
//
//  Created by edz on 2021/2/3.
//

import Foundation
import SwiftyJSON

struct PurchaseNetConfig {
    
    var launchShow: Bool = false
    var launchStyle: Int = 0
    var foregroundShow: Bool = false
    
    var singleItem = BuyItemModel(id: PurchaseDefaultValue.weeId)
    var mutliItems = [BuyItemModel(id: PurchaseDefaultValue.weeId),BuyItemModel(id: PurchaseDefaultValue.monId),BuyItemModel(id: PurchaseDefaultValue.yeaId)]
    
    init(onlineData: Data) {
        if let json =  try? JSON(data: onlineData) {
            if let launchShow = json["launchShow"].bool {
                self.launchShow = launchShow
            }
            
            if let launchStyle = json["launchStyle"].int {
                self.launchStyle = launchStyle
            }
            
            if let foregroundShow = json["foregroundShow"].bool {
                self.foregroundShow = foregroundShow
            }
            
            var singleM = BuyItemModel()
            if let singleid = json["singleProduct"]["id"].string {
                singleM.id = singleid
            }
            
            self.singleItem = singleM
            
            let mults = json["mutliProducts"].arrayValue.map {
                return BuyItemModel(id: $0["id"].stringValue)
            }
            self.mutliItems = mults
        }
    }
    
    static func defaultConfig() -> PurchaseNetConfig {
        if let d = PurchaseDefaultValue.defaultConfigJson.data(using: .utf8) {
            return PurchaseNetConfig(onlineData: d)
        } else {
            return PurchaseNetConfig(onlineData: Data())
        }
    }
}

struct BuyItemModel {
    var id: String = ""
}
