//
//  File.swift
//  
//
//  Created by zy on 2021/2/23.
//

//import Foundation
//import UIKit
//import ZYCommonUtil
//import Flurry_iOS_SDK

//extension UILabel {
//    class func label(str: String,color: UIColor, font: UIFont) -> UILabel {
//        let lbl = UILabel()
//        lbl.text = str
//        lbl.textColor = color
//        lbl.font = font
//        return lbl
//    }
//}
//
//class ItemBuyViewController: CustomNavViewController {
//
//    var isSingle: Bool = true
//    var singleLbl = UILabel(), singleBtn: UIButton = UIButton()
//
//    var weekLbl1: UILabel!, weekLbl2: UILabel!, weekLbl3: UILabel!
//    var monthLbl1: UILabel!, monthLbl2: UILabel!, monthLbl3: UILabel!
//    var yearLbl1: UILabel!, yearLbl2: UILabel! ,yearLbl3: UILabel!
//    var weekBtn: UIButton!, monthBtn: UIButton!, yearBtn: UIButton!
//    var clickBtn: UIButton!
//
//    var continueBtn: UIButton!, restoreBtn: UIButton!
//    let scrollView = UIScrollView()
//
//    var pageFrom: BuyPageFromSource = .unknow
//
//    var buyT: Timer!
//    var restoreT: Timer!
//
//    deinit {
//        if buyT != nil {
//            buyT.invalidate()
//            buyT = nil
//        }
//
//        if restoreT != nil {
//            restoreT.invalidate()
//            restoreT = nil
//        }
//        NotificationCenter.default.removeObserver(self)
//        print("xxxx-BuyViewController init")
//    }
//
//    override func clickNavBar(type: Int) {
//        if type == 1 {
//            self.restore()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.backgroundColor = UIColor(hexString: "#f2fbff")
//        self.navView?.backgroundColor = .clear
//        self.navView?.backBtn.setImage(UIImage(named: "设置_订阅_关闭_icon"), for: .normal)
//        self.navView?.line.isHidden = true
//        self.navView?.rightBtn.setTitle("sub_simple_restore".local, for: .normal)
//        self.navView?.rightBtn.setTitleColor(.white, for: .normal)
//
//        self.view.insertSubview(scrollView, belowSubview: navView!)
//        scrollView.snp.makeConstraints { (make) in
//            make.left.bottom.top.right.equalToSuperview()
//        }
//
//        if isSingle {
//            scrollView.contentSize = CGSize(width: 0, height: 730)
//        } else {
//            scrollView.contentSize = CGSize(width: 0, height: 770)
//        }
//
//        self.scrollView.contentOffset =  CGPoint(x: 0, y: 0)
//        self.scrollView.contentInsetAdjustmentBehavior = .never
//        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
//
//        topView()
//        bottomView()
//
//        if isSingle {
//            singleView()
//            updateSingleItem()
//        } else {
//            mulView()
//            self.clickBtn = weekBtn
//            self.clickBtn.layer.borderWidth = 1
//            self.clickBtn.layer.borderColor = UIColor(hexString: "#306CFF").cgColor
//
////            self.weekBtn.sendActions(for: .touchUpInside)
//             updateItemsInfo()
//        }
//
//        NotificationCenter.default.addObserver(forName: BuyMgr.BuyDefaultValue.productPriceNotification, object: nil, queue: nil) { [weak self] (n) in
//            if self?.isSingle == true {
//                self?.updateSingleItem()
//            } else {
//                self?.updateItemsInfo()
//            }
//        }
//
//        Flurry.logEvent("subscribe_show", withParameters: ["page": self.pageParam, "source": self.pageFrom.souParam])
//    }
//
//    func updateSingleItem() {
//        singleLbl.text = "sub_freeday_tip".local + "sub_then".local + ItemBuyProcessMgr.singlePrice + "/" + ItemBuyProcessMgr.singlePeriod
//
//        singleBtn.setTitle("sub_single_btn_title".local, for: .normal)
//
//        if ItemBuyProcessMgr.default.onlineConfig.launchStyle == 1 {
//            singleBtn.setTitle("sub_single_btn_title_nb".local, for: .normal)
//            singleLbl.isHidden = true
//            self.navView?.backBtn.isHidden = true
//        }
//    }
//
//    func updateItemsInfo() {
//        weekLbl1.text = "sub_week".local
//        weekLbl2.text = "sub_freeday_tip".local + "sub_then".local + ItemBuyProcessMgr.weekPrice + "/" + "sub_period_weekly".local
//        weekLbl3.text = ItemBuyProcessMgr.weekPrice
//
//        yearLbl1.text = "sub_year".local
//        yearLbl2.text = "sub_freeday_tip".local + "sub_then".local + ItemBuyProcessMgr.yearPrice + "/" + "sub_period_yearly".local
//        yearLbl3.text = ItemBuyProcessMgr.yearPrice
//    }
//
//    @objc func gotoPri() {
//        self.openUrl(content: AppCommonValue.pri)
//    }
//
//    @objc func gotoTer() {
//        self.openUrl(content: AppCommonValue.ser)
//    }
//
//    @objc func keepVersionAc() {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//
//}
