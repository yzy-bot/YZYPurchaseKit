//
//  Purchase+Info.swift
//  pkit
//
//  Created by zy on 2021/2/22.
//

import Foundation

public extension PurchaseProductMgr {
    
    static var singlePageProductPrice: String {
        let sid  =  PurchaseProductMgr.default.onlineConfig.singleItem.id
        if sid == PurchaseDefaultValue.weeId {
            return self.weekPrice
        } else if sid == PurchaseDefaultValue.monId {
            return self.monthPrice
        } else if sid == PurchaseDefaultValue.yeaId {
            return self.yearPrice
        }
        return self.weekPrice
    }
    
    static var singlePageProductId: String {
        let sid  =  PurchaseProductMgr.default.onlineConfig.singleItem.id
        return sid
    }
    
    static var singlePageProductPeriod: String {
        let sid  =  PurchaseProductMgr.default.onlineConfig.singleItem.id
        if sid == PurchaseDefaultValue.weeId {
            return "sub_period_weekly".zyz_localStr
        } else if sid == PurchaseDefaultValue.monId {
            return "sub_period_monthly".zyz_localStr
        } else if sid == PurchaseDefaultValue.yeaId {
            return "sub_period_yearly".zyz_localStr
        }
        return "sub_period_weekly".zyz_localStr
    }
    
    static var isPremiumMember: Bool {
        if let d = UserDefaults.standard.value(forKey: PurchaseDefaultValue.lastedExpiredDateKey) as? Date {
            if d.timeIntervalSinceNow <= 0 {
                print("sd== 已过期")
                return false
            }
            return true
        }
        return false
    }

    static var expiredDateDesc: String {
        if let d = UserDefaults.standard.value(forKey: PurchaseDefaultValue.lastedExpiredDateKey) as? Date {
            #if DEBUG
                return d.zyz_secString
            #endif
            return d.zyz_dayString
        } else {
            return ""
        }
    }

    static var isEverPurchased: Bool {
        let d = UserDefaults.standard.bool(forKey: PurchaseDefaultValue.havedPurchaseOrRestoreKey)
        return d
    }

    static var weekPrice: String {
        return UserDefaults.standard.string(forKey: PurchaseDefaultValue.weeId) ?? "--"
    }

    static var monthPrice: String {
        return UserDefaults.standard.string(forKey: PurchaseDefaultValue.monId) ?? "--"
    }

    static var yearPrice: String {
        return UserDefaults.standard.string(forKey: PurchaseDefaultValue.yeaId) ?? "--"
    }

    
}
