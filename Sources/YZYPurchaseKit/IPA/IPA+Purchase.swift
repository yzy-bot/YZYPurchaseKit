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
import ZYCommonUtil

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

    
    /// 订阅校验
    /// - Parameters:
    ///   - fromRestore: 是否是恢复校验
    ///   - completion: 是否是恢复  ， 是否是订阅用户，商品id
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
    
    struct ValidatePara: Encodable {
        var receipt: String?
        var pkg: String?
        var appsflyerId: String?
        var idfa: String?
    }
    
    struct ValidateResponse: Codable {
        struct Result: Codable {
            var cleaner_week_premium: TimeInterval?
            var cleaner_month_premium: TimeInterval?
            var cleaner_year_premium: TimeInterval?

            var subString: String {
                var s = ""
                if cleaner_week_premium != nil {
                    s = s + "周到期" + Date(timeIntervalSince1970: cleaner_week_premium! / 1000).secondsString
                }

                if cleaner_month_premium != nil {
                    s = s + "月到期" + Date(timeIntervalSince1970: cleaner_month_premium! / 1000).secondsString
                }

                if cleaner_year_premium != nil {
                    s = s + "年到期" + Date(timeIntervalSince1970: cleaner_year_premium! / 1000).secondsString
                }
                return s
            }

            /// 获取最新的订阅商品
            /// - Returns: description
            func getLatest() -> (String, Date) {
                var idTimes: [String: TimeInterval] = [:]

                if cleaner_week_premium != nil {
                    idTimes[PurchaseDefaultValue.weeId] = cleaner_week_premium
                }

                if cleaner_month_premium != nil {
                    idTimes[PurchaseDefaultValue.monId] = cleaner_month_premium
                }

                if cleaner_year_premium != nil {
                    idTimes[PurchaseDefaultValue.yeaId] = cleaner_year_premium
                }

                var t: TimeInterval = 0
                var tmpId: String = ""
                for (_, id) in idTimes.keys.enumerated() {
                    if let time = idTimes[id] {
                        if time > t {
                            t = time
                            tmpId = id
                        }
                    }
                }
                let second: TimeInterval = (idTimes[tmpId]! / 1000.0)
                return (tmpId, Date(timeIntervalSince1970: second))
            }

            var isLatestDataExperied: Bool {
                return getLatest().1.isEarlierNow
            }
        }

        struct Message: Codable {
            var code: Int?
            var messageInfo: String?
            var serverTime: TimeInterval?
        }

        var result: Result?
        var message: Message?

        static func decodeJson(data: Data) -> ValidateResponse? {
            var returnValue: ValidateResponse?
            do {
                returnValue = try JSONDecoder().decode(ValidateResponse.self, from: data)
            } catch {
                print("Error took place: \(error.localizedDescription).")
            }
            return returnValue
        }

        /// 验证是否合法
        var isValidate: Bool {
            guard message != nil, message?.code != nil else {
                return false
            }

            if message!.code == 200 {
                return true
            }
            return false
        }
    }
    
    static func serverValid(fromRestore: Bool, completion: @escaping (_ restor: Bool, _ purchase: Bool, _ productid: String?) -> Void) {
        print("aaa- valid bengin")
        
        let serverUrl: String = "https://api.treegrammar.com/pay/checkAppleSubscribeReceipt"
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
//                print(receiptData)
                let receiptString = receiptData.base64EncodedString(options: [])
                // Read receiptData
                let para = ValidatePara(receipt: receiptString, pkg: PurchaseDefaultValue.pkg, appsflyerId: PurchaseDefaultValue.appsflyerId , idfa: PurchaseDefaultValue.idfa)
                AF.request(serverUrl,
                           method: .post,
                           parameters: para).response
                { response in
                    guard let d = response.data
                    else {
                        completion(fromRestore, false, nil)
                        return
                    }
                    guard let r = ValidateResponse.decodeJson(data: d)
                    else {
                        completion(fromRestore, false, nil)
                        return
                    }

                    debugPrint("sub-server验证结果\(String(describing: r.result?.subString))")

                    if r.isValidate {
                        debugPrint("\(String(describing: r.result?.getLatest()))")
                        if let id = r.result?.getLatest().0, let time = r.result?.getLatest().1 {
//                            SubscriptionConfig.default.refreshLatesrInfo(id: id, time: time)
                            PurchaseProductMgr.addPurchasedProduct(date: time)
//                            finishBlock!(restore, !time.isEarlierNow)
                            completion(fromRestore, !time.isEarlierNow, id)
                            return
                        }
                    } else {
                        debugPrint("sub-server 不合法")
                    }
                            
                    // 服务器验证失败，改用苹果验证
//                    GrammerTreeSubsription.checkSubscription(is: restore, finishBlock: finishBlock)
                }
            } catch {
                print("Couldn't read receipt data with error: " + error.localizedDescription)
                completion(fromRestore, false, nil)
                // 服务器验证失败，改用苹果验证
//                GrammerTreeSubsription.checkSubscription(is: restore, finishBlock: finishBlock)
            }
        }
        
        
//
//        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: PurchaseDefaultValue.purchaseSecret)
//        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
//            switch result {
//            case let .success(receipt):
//                let subScriptionsIds: Set<String> = Set(self.proIds)
//                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: subScriptionsIds, inReceipt: receipt)
//                switch purchaseResult {
//                case let .purchased(expiryDate, items):
//                    PurchaseProductMgr.addPurchasedProduct(date: expiryDate)
//                    completion(fromRestore, true, items.first?.productId)
//                    print("aa-合法到 until \(expiryDate)--\(items.first?.productId)")
//                case let .expired(expiryDate, items):
//                    PurchaseProductMgr.addPurchasedProduct(date: expiryDate)
//                    completion(fromRestore, false,items.first?.productId)
//                    print("aa- 过期了到 since \(expiryDate)---\(items.first?.productId)")
//                case .notPurchased:
//                    print("The user has never purchased \(subScriptionsIds)")
//                    completion(fromRestore, false, nil)
//                }
//            case let .error(error):
//                print("Receipt verification failed: \(error)")
//                completion(fromRestore, false, nil)
//            }
//        }
    }


    
    /// 购买
    /// - Parameters:
    ///   - id: id
    ///   - completion: 是否购买成功， 商品id， 错误信息
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

    
    /// 恢复购买
    /// - Parameter completion: 是否购买成功， 商品id， 错误信息
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
