//
//  File.swift
//  
//
//  Created by zy on 2021/2/23.
//

import Foundation
import SwiftyJSON

public struct PurchaseNetConfig {
    
    public  var launchShow: Bool = false
    public  var launchStyle: Int = 0
    public var foregroundShow: Bool = false
    public var maxCount: Int = 5
    
    public var singleItem = SubItemModel(id: PurchaseDefaultValue.weeId)
    public var mutliItems = [SubItemModel(id: PurchaseDefaultValue.weeId),SubItemModel(id: PurchaseDefaultValue.monId),SubItemModel(id: PurchaseDefaultValue.yeaId)]
    
    init(onlineData: Data) {
        if let json =  try? JSON(data: onlineData) {
            if let launchShow = json["launchShow"].bool {
                self.launchShow = launchShow
            }
            
            if let launchStyle = json["launchStyle"].int {
                self.launchStyle = launchStyle
            }
            
            if let maxCount = json["maxCount"].int {
                self.maxCount = maxCount
            }
            
            if let foregroundShow = json["foregroundShow"].bool {
                self.foregroundShow = foregroundShow
            }
            
            var singleM = SubItemModel()
            if let singleid = json["singleProduct"]["id"].string {
                singleM.id = singleid
            }
            
            self.singleItem = singleM
            
            let mults = json["mutliProducts"].arrayValue.map {
                return SubItemModel(id: $0["id"].stringValue)
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

public struct SubItemModel {
    public var id: String = ""
}
