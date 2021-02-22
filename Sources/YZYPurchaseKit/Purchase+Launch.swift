//
//  Purchase+Launch.swift
//  pkit
//
//  Created by zy on 2021/2/22.
//

import Foundation

public extension PurchaseProductMgr {
    
    /// 获取ids
    static var proIds: [String] {
        var ids: [String] = []
        if !PurchaseDefaultValue.weeId.isEmpty {
            ids.append(PurchaseDefaultValue.weeId)
        }
        
        if !PurchaseDefaultValue.monId.isEmpty {
            ids.append(PurchaseDefaultValue.monId)
        }
        
        if !PurchaseDefaultValue.yeaId.isEmpty {
            ids.append(PurchaseDefaultValue.yeaId)
        }
        return ids
    }
    
    /// 启动处理逻辑
    static func handleLauch(){
        PurchaseProductMgr.launchAddObserver()
        if PurchaseDefaultValue.purchaseSecret.isEmpty {
            fatalError("没有secret")
        }
        
        if PurchaseDefaultValue.weeId.isEmpty && PurchaseDefaultValue.monId.isEmpty && PurchaseDefaultValue.yeaId.isEmpty {
            fatalError("没有商品信息")
        }
        
        PurchaseProductMgr.requestItemsInfo(ids: self.proIds)
        
        PurchaseProductMgr.requestNetConfig()
        if PurchaseProductMgr.isEverPurchased {
            PurchaseProductMgr.valid(fromRestore: true) { _, purchase, id in
                print("xxx")
            }
        }
    }
}
