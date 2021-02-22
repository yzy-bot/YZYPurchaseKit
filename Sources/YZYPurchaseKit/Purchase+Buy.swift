//
//  Purchase+Buy.swift
//  pkit
//
//  Created by zy on 2021/2/22.
//

import Foundation
import SwiftyStoreKit
import StoreKit

public extension PurchaseProductMgr {
    static func requestItemsInfo(ids: [String]) {
        if ids.count == 0 {
            return
        }
        
        let idset = Set(ids)
        SwiftyStoreKit.retrieveProductsInfo(idset) { result in
            if result.retrievedProducts.count <= 0 {
            }
            print("aaaa-请求到最新商品信息-\(result.retrievedProducts)---invalidids=\(result.invalidProductIDs)")
            for p in result.retrievedProducts {
                UserDefaults.standard.setValue(p.localizedPrice, forKey: p.productIdentifier)
            }
            NotificationCenter.default.post(name: PurchaseDefaultValue.receivedPricesNotification, object: nil)
        }
    }

    static func valid(fromRestore: Bool, completion: @escaping (_ restor: Bool, _ purchase: Bool, _ productid: String?) -> Void) {
        print("aaa- valid bengin")
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: PurchaseDefaultValue.purchaseSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case let .success(receipt):
                let subScriptionsIds: Set<String> = Set(self.proIds)
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: subScriptionsIds, inReceipt: receipt)
                switch purchaseResult {
                case let .purchased(expiryDate, items):
                    PurchaseProductMgr.addPurchasedProduct(date: expiryDate)
                    completion(fromRestore, true, items.first?.productId)
                    print("aa-合法到 until \(expiryDate)--\(items.first?.productId)")
                case let .expired(expiryDate, items):
                    PurchaseProductMgr.addPurchasedProduct(date: expiryDate)
                    completion(fromRestore, false,items.first?.productId)
                    print("aa- 过期了到 since \(expiryDate)---\(items.first?.productId)")
                case .notPurchased:
                    print("The user has never purchased \(subScriptionsIds)")
                    completion(fromRestore, false, nil)
                }
            case let .error(error):
                print("Receipt verification failed: \(error)")
                completion(fromRestore, false, nil)
            }
        }
    }

    static func purchaseItem(id: String, completion: @escaping (_ purchase: Bool, _ productid: String? ,_ errMsg: String) -> Void) {
        SwiftyStoreKit.purchaseProduct(id, quantity: 1, atomically: true) { result in
            switch result {
            case .success(_):
                PurchaseProductMgr.purchaseOrRestoreSuccess()
                PurchaseProductMgr.valid(fromRestore: false) { _, purchased, id in
                    completion(purchased, id ,"")
                }
            case let .error(error):
                var errMsg = ""
                switch error.code {
                case .unknown, .clientInvalid, .paymentInvalid, .paymentNotAllowed, .storeProductNotAvailable, .cloudServicePermissionDenied, .cloudServiceNetworkConnectionFailed, .cloudServiceRevoked:
                    errMsg = "unknow_err".zyz_localStr
                    print("xxx- buy local err=\((error as NSError).localizedDescription)")
                case .paymentCancelled:
                    errMsg = "cancel_err".zyz_localStr
                default:
                    print((error as NSError).localizedDescription)
                    errMsg = (error as NSError).localizedDescription
                }
                completion(false, nil,errMsg)
            }
        }
    }

    static func retore(completion: @escaping (Bool, _ productid: String? ,_ err: String?) -> Void) {
        SwiftyStoreKit.restorePurchases { result in
            if result.restoredPurchases.count > 0 {
                PurchaseProductMgr.purchaseOrRestoreSuccess()
                PurchaseProductMgr.valid(fromRestore: true) { _, purchase, id in
                    if purchase {
                        completion(purchase, id ,nil)
                    } else {
                        completion(purchase, nil ,"have_not_restore_product".zyz_localStr)
                    }
                }
            } else if result.restoreFailedPurchases.count > 0 {
                completion(false, nil ,"have_restore_product_error".zyz_localStr)
            } else {
                completion(false, nil ,"have_not_restore_product".zyz_localStr)
            }
        }
    }

    static func launchAddObserver() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for p in purchases {
                switch p.transaction.transactionState {
                case .purchased, .restored:
                    if p.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(p.transaction)
                    }
                case .failed, .purchasing, .deferred:
                    break
                default:
                    print("")
                }
            }
        }
    }

    static func finishTrans() {
        for t in SKPaymentQueue.default().transactions {
            SKPaymentQueue.default().finishTransaction(t)
        }
    }
    
    static func purchaseOrRestoreSuccess() {
        UserDefaults.standard.setValue(true, forKey: PurchaseDefaultValue.havedPurchaseOrRestoreKey)
    }
    
    static func addPurchasedProduct(date: Date) {
        UserDefaults.standard.setValue(date, forKey: PurchaseDefaultValue.lastedExpiredDateKey)
        NotificationCenter.default.post(name:  PurchaseDefaultValue.purchaseProductNotification , object: nil)
    }
}
