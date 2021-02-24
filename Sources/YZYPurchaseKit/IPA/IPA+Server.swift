//
//  File.swift
//  
//
//  Created by zy on 2021/2/24.
//

import Foundation
import Alamofire

extension PurchaseProductMgr {
    static func serverValid(fromRestore: Bool, completion: @escaping (_ restor: Bool, _ purchase: Bool, _ productid: String?) -> Void) {
        print("aaa- valid bengin")
        let serverUrl: String = PurchaseDefaultValue.validServerUrl
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

                    debugPrint("-server验证结果\(String(describing: r.result?.subString))")

                    if r.isValidate {
                        debugPrint("\(String(describing: r.result?.getLatest()))")
                        if let id = r.result?.getLatest().0, let time = r.result?.getLatest().1 {
                            PurchaseProductMgr.addPurchasedProduct(date: time)
                            completion(fromRestore, !time.isEarlierNow, id)
                            return
                        }
                    } else {
                        debugPrint("server 不合法")
                    }
                    completion(fromRestore, false, nil)
                }
            } catch {
                print("Couldn't read receipt data with error: " + error.localizedDescription)
                completion(fromRestore, false, nil)
            }
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
