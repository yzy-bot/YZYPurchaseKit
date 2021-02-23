//
//  File.swift
//  
//
//  Created by zy on 2021/2/23.
//

//import Foundation
//import MBProgressHUD
//import Flurry_iOS_SDK
//import StoreKit
//
//extension ItemBuyViewController {
//    func restore() {
//        MBProgressHUD.show("")
//
//        if SKPaymentQueue.default().transactions.isEmpty {
//            proceeRestore()
//        } else {
//            ItemBuyProcessMgr.finishTrans()
//            restoreT = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (t) in
//                print("waiting for pay queue  \(SKPaymentQueue.default().transactions.count)")
//                if SKPaymentQueue.default().transactions.isEmpty {
//                    if self?.restoreT != nil {
//                        self?.restoreT.invalidate()
//                        self?.restoreT = nil
//                    }
//                    self?.proceeRestore()
//                }
//            })
//        }
//    }
//
//    func proceeRestore() {
//        ItemBuyProcessMgr.retore {  [weak self] (res, err)  in
//            DispatchQueue.main.async {
//                MBProgressHUD.hide()
//                if res == true {
//                    Flurry.logEvent("restore_success", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "restore"])
//                    MBProgressHUD.showToast("rest_suc".local)
//                    self?.navigationController?.popViewController(animated: true)
//                } else {
//                    MBProgressHUD.showToast("have_not_restore_product".local)
//                    Flurry.logEvent("restore_fail", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "restore", "reason": err ?? ""])
//                    Flurry.logEvent("restore_verify_fail", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "restore", "reason": err ?? "", "type": "vertify"])
//
//                }
//            }
//        }
//    }
//
//    @objc func buyBtnClick(btn: UIButton) {
//        MBProgressHUD.show("")
//        if btn == self.singleBtn {
//
//        } else {
//            self.clickBtn.isSelected = false
//            self.clickBtn.layer.borderWidth = 0
//            btn.isSelected = true
//            self.clickBtn = btn
//
//            btn.layer.borderWidth = 1
//            btn.layer.borderColor = UIColor(hexString: "#306CFF").cgColor
//        }
//
//
//        if SKPaymentQueue.default().transactions.isEmpty {
//            processBuy(btn: btn)
//        } else {
//            ItemBuyProcessMgr.finishTrans()
//            buyT = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (t) in
//                print("waiting for pay queue  \(SKPaymentQueue.default().transactions.count)")
//                if SKPaymentQueue.default().transactions.isEmpty {
//                    if self?.buyT != nil {
//                        self?.buyT.invalidate()
//                        self?.buyT = nil
//                    }
//                    self?.processBuy(btn: btn)
//                }
//            })
//        }
//    }
//
//    func processBuy(btn: UIButton) {
//
//        var pid = ""
//        if btn == self.singleBtn {
//            pid = ItemBuyProcessMgr.singleProId
//            ItemBuyProcessMgr.buy(id: ItemBuyProcessMgr.singleProId) {  [weak self] (p, err) in
//                MBProgressHUD.hide()
//                if p {
//                    Flurry.logEvent("subscribe_success", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "buy", "product_id": pid])
//                    self?.navigationController?.popViewController(animated: true)
//                } else {
//                    MBProgressHUD.showToast(err)
//                    Flurry.logEvent("subscribe_fail", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "buy", "product_id": pid, "reason": err])
//                    Flurry.logEvent("pay_verify_fail", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "restore","product_id": pid, "reason": err , "type": "vertify"])
//                }
//            }
//            return
//        }
//
//        if btn == weekBtn {
//            pid = ItemBuyProcessMgr.BuyItemType.week.itemId
//            ItemBuyProcessMgr.buy(id: ItemBuyProcessMgr.BuyItemType.week.itemId) { [weak self] (p, err) in
//                MBProgressHUD.hide()
//                if p {
//                    Flurry.logEvent("subscribe_success", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "buy", "product_id": pid])
//                    self?.navigationController?.popViewController(animated: true)
//                } else {
//                    MBProgressHUD.showToast(err)
//                    Flurry.logEvent("subscribe_fail", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "buy", "product_id": pid, "reason": err])
//                    Flurry.logEvent("pay_verify_fail", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "restore","product_id": pid, "reason": err , "type": "vertify"])
//                }
//            }
//        } else if btn == yearBtn {
//            pid = ItemBuyProcessMgr.BuyItemType.year.itemId
//            ItemBuyProcessMgr.buy(id: ItemBuyProcessMgr.BuyItemType.year.itemId) { [weak self] (p, err) in
//                MBProgressHUD.hide()
//                if p {
//                    Flurry.logEvent("subscribe_success", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "buy", "product_id": pid])
//                    self?.navigationController?.popViewController(animated: true)
//                } else {
//                    MBProgressHUD.showToast(err)
//                    Flurry.logEvent("subscribe_fail", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "buy", "product_id": pid, "reason": err])
//                    Flurry.logEvent("pay_verify_fail", withParameters: ["page": self?.pageParam ?? "", "source": self?.pageFrom.souParam ?? "", "action": "restore","product_id": pid, "reason": err , "type": "vertify"])
//                }
//            }
//        }
//
//        if ItemBuyProcessMgr.weekPrice == "--" {
//            Flurry.logEvent("product_status", withParameters: ["page": self.pageParam, "result": "fail"])
//        } else {
//            Flurry.logEvent("product_status", withParameters: ["page": self.pageParam, "result": "success"])
//        }
//
//        Flurry.logEvent("subscribe_show", withParameters: ["page": self.pageParam, "source": self.pageFrom.souParam, "btn": "pay_btn", "product_id": pid])
//    }
//}
