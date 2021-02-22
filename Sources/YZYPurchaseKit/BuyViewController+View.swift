////
////  BuyViewController+View.swift
////  photoremove
////
////  Created by edz on 2021/2/4.
////
//
//import Foundation
//
//extension ItemBuyViewController {
//    
//    func bottomView() {
//        let line = UIView()
//        line.backgroundColor = UIColor(hexString: "#67728E")
//        self.scrollView.addSubview(line)
//        line.frame = CGRect(x: Double(UIScreen.width / 2), y: Double(self.scrollView.contentSize.height - 20), width: 1, height: 16)
//        
//        let btn = UIButton(type: .custom)
//        btn.addTarget(self, action: #selector(gotoPri), for: .touchUpInside)
//        btn.setTitle("set_privite_policy".local, for: .normal)
//        btn.setTitleColor(UIColor(hexString: "#67728E"), for: .normal)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        scrollView.addSubview(btn)
//        btn.snp.makeConstraints { (make) in
//            make.centerY.equalTo(line)
//            make.right.equalTo(line.snp.left).offset(-20)
//        }
//        
//        let btn2 = UIButton(type: .custom)
//        btn2.setTitle("set_term_use".local, for: .normal)
//        btn2.addTarget(self, action: #selector(gotoTer), for: .touchUpInside)
//        btn2.setTitleColor(UIColor(hexString: "#67728E"), for: .normal)
//        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        scrollView.addSubview(btn2)
//        btn2.snp.makeConstraints { (make) in
//            make.centerY.equalTo(line)
//            make.left.equalTo(line.snp.right).offset(20)
//        }
//        
//        let tips = UITextView()
//        tips.isEditable = false
//        tips.backgroundColor = .clear
//        self.scrollView.addSubview(tips)
//        tips.text = "sub_simple_info".local
//        tips.textColor = UIColor(hexString: "#B3B8C6")
//        tips.font = UIFont.systemFont(ofSize: 11)
//        tips.snp.makeConstraints { (make) in
//            make.bottom.equalTo(line.snp.top).offset(-20)
//            make.centerX.equalTo(line)
//            make.width.equalTo(UIScreen.width - 40)
//            make.height.equalTo(120)
//        }
////
////        let b1 = UIButton(type: .custom)
////        b1.addTarget(self, action: #selector(keepVersionAc), for: .touchUpInside)
////        b1.setTitle("sub_simple_continue".local , for: .normal)
////        b1.setTitleColor(UIColor(hexString: "#316CFF"), for: .normal)
////        b1.titleLabel?.font = UIFont.systemFont(ofSize: 13)
////        self.scrollView.addSubview(b1)
////        b1.snp.makeConstraints { (make) in
////            make.right.equalTo(line.snp.right).offset(-15)
////            make.bottom.equalTo(tips.snp.top).offset(-25)
////        }
////
////        self.continueBtn = b1
//        
//        let b2 = UIButton(type: .custom)
//        b2.isHidden = true
////        b2.addTarget(self, action: #selector(restore), for: .touchUpInside)
//        b2.setTitle("sub_simple_restore".local, for: .normal)
//        b2.setTitleColor(UIColor(hexString: "#316CFF"), for: .normal)
//        b2.titleLabel?.font = UIFont.systemFont(ofSize: 13)
//        self.scrollView.addSubview(b2)
//        b2.snp.makeConstraints { (make) in
//            make.left.equalTo(line.snp.right).offset(30)
//            make.bottom.equalTo(tips.snp.top).offset(-25)
//        }
//        self.restoreBtn = b2
//    }
//    
//    func topView() {
//        let imgv = UIImageView(image: UIImage(named: "订阅_背景"))
//        scrollView.addSubview(imgv)
//        imgv.frame = CGRect(x: 0, y: 0, width: Double(UIScreen.width), height: Double(UIScreen.width) * 0.8)
//        let lbl = UILabel.label(str: "高级智能清理", color: UIColor.white, font: UIFont(name: "PingFangSC-Semibold", size: 26)!)
//        imgv.addSubview(lbl)
//        lbl.snp.makeConstraints { (make) in
//            make.left.equalTo(20)
//            make.centerY.equalToSuperview().offset(-70)
//        }
//        
//        var im = UIImageView(image: UIImage(named: "订阅_背景_清理无用照片"))
//        imgv.addSubview(im)
//        im.snp.makeConstraints { (make) in
//            make.left.equalTo(20)
//            make.top.equalTo(lbl.snp.bottom).offset(20)
//            make.width.height.equalTo(20)
//        }
//        
//        let lbl2 = UILabel.label(str: "清理无用照片", color: UIColor.white, font: UIFont.systemFont(ofSize: 16))
//        imgv.addSubview(lbl2)
//        lbl2.snp.makeConstraints { (make) in
//            make.left.equalTo(im.snp.right).offset(10)
//            make.centerY.equalTo(im)
//        }
//        
//        im = UIImageView(image: UIImage(named: "订阅_背景_祛除图片位置"))
//        imgv.addSubview(im)
//        im.snp.makeConstraints { (make) in
//            make.left.equalTo(20)
//            make.top.equalTo(lbl2.snp.bottom).offset(20)
//            make.width.height.equalTo(20)
//        }
//        
//        let lbl3 = UILabel.label(str: "清理无用照片", color: UIColor.white, font: UIFont.systemFont(ofSize: 16))
//        imgv.addSubview(lbl3)
//        lbl3.snp.makeConstraints { (make) in
//            make.left.equalTo(im.snp.right).offset(10)
//            make.centerY.equalTo(im)
//        }
//        
//        im = UIImageView(image: UIImage(named: "订阅_背景_OCR"))
//        imgv.addSubview(im)
//        im.snp.makeConstraints { (make) in
//            make.left.equalTo(20)
//            make.top.equalTo(lbl3.snp.bottom).offset(20)
//            make.width.height.equalTo(20)
//        }
//        
//        let lbl4 = UILabel.label(str: "清理无用照片", color: UIColor.white, font: UIFont.systemFont(ofSize: 16))
//        imgv.addSubview(lbl4)
//        lbl4.snp.makeConstraints { (make) in
//            make.left.equalTo(im.snp.right).offset(10)
//            make.centerY.equalTo(im)
//        }
//        
//        im = UIImageView(image: UIImage(named: "订阅_背景_无广告"))
//        imgv.addSubview(im)
//        im.snp.makeConstraints { (make) in
//            make.left.equalTo(20)
//            make.top.equalTo(lbl4.snp.bottom).offset(20)
//            make.width.height.equalTo(20)
//        }
//        
//        let lbl5 = UILabel.label(str: "清理无用照片", color: UIColor.white, font: UIFont.systemFont(ofSize: 16))
//        imgv.addSubview(lbl5)
//        lbl5.snp.makeConstraints { (make) in
//            make.left.equalTo(im.snp.right).offset(10)
//            make.centerY.equalTo(im)
//        }
//        
//        lbl.text = "TRY PRO";
//        lbl2.text = "sub_simple_icon_lab3".local
//        lbl3.text = "sub_simple_icon_lab2".local
//        lbl4.text = "sub_simple_icon_lab1".local
//        lbl5.text = "sub_simple_icon_lab4".local
//    }
//    
//    func itemView() -> (btn: UIButton, timeLbl: UILabel, desLbl: UILabel, priceLbl: UILabel) {
//        let btn = UIButton(type: .custom)
//        btn.backgroundColor = .white
//        btn.layer.shadowColor = UIColor(hexString: "#000000", alpha: 0.06).cgColor
//        btn.layer.shadowOffset = CGSize(width: 0, height: 15)
//        btn.layer.shadowRadius = 30
//        btn.layer.shadowOpacity = 1
//        btn.layer.cornerRadius = 8
//        btn.setImage(UIImage(named: "订阅_订阅三条目_未选择_icon"), for: .normal)
//        btn.setImage(UIImage(named: "订阅_订阅三条目_选择_icon"), for: .selected)
//        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(-(UIScreen.width - 30 - 40)), bottom: 0, right: 0)
//        btn.addTarget(self, action: #selector(buyBtnClick(btn:)), for: .touchUpInside)
//        
//        let lbl = UILabel.label(str: "1月", color: UIColor(hexString: "#121829"), font: UIFont.systemFont(ofSize: 20))
//        btn.addSubview(lbl)
//        lbl.snp.makeConstraints { (make) in
//            make.left.equalTo(50)
//            make.top.equalTo(12)
//        }
//        
//        let lbl2 = UILabel.label(str: "免费3天试用，之后¥0.99/周", color: UIColor(hexString: "#67728E"), font: UIFont.systemFont(ofSize: 11))
//        btn.addSubview(lbl2)
//        lbl2.snp.makeConstraints { (make) in
//            make.left.equalTo(50)
//            make.bottom.equalTo(-12)
//        }
//        
//        let lbl3 = UILabel.label(str: "¥0.99", color: UIColor(hexString: "#FFA800"), font: UIFont.boldSystemFont(ofSize: 24))
//        btn.addSubview(lbl3)
//        lbl3.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.right.equalTo(-15)
//        }
//        return (btn, lbl, lbl2, lbl3)
//    }
//    
//    func singleView() {
//        self.scrollView.addSubview(self.singleLbl)
//        self.scrollView.addSubview(self.singleBtn)
//        self.singleBtn.addTarget(self, action: #selector(buyBtnClick(btn:)), for: .touchUpInside)
//        self.singleBtn.setTitle("免费试用和订阅", for: .normal)
//        self.singleBtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 21)
//        self.singleBtn.setTitleColor(.white, for: .normal)
//        self.singleBtn.backgroundColor = UIColor(hexString: "#3997ff")
//        self.singleBtn.layer.cornerRadius = 8
//        self.singleBtn.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.width.equalTo(UIScreen.width - 40)
//            make.height.equalTo(55)
//            make.bottom.equalTo(self.restoreBtn.snp.top)
//        }
//        self.singleLbl.font = UIFont(name: "PingFangSC-Medium", size: 16)
//        self.singleLbl.textColor = UIColor(hexString: "#67728E")
//        self.singleLbl.text = "免费3天试用 之后¥0.99/周"
//        self.singleLbl.textAlignment = .center
//        self.singleLbl.numberOfLines = 0
//        self.singleLbl.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.width.equalTo(UIScreen.width - 40)
//            make.bottom.equalTo(self.singleBtn.snp.top).offset(-30)
//        }
//    }
//    
//    func mulView() {
//        (weekBtn, weekLbl1,weekLbl2,weekLbl3) = itemView()
////        (monthBtn,monthLbl1,monthLbl2,monthLbl3) = itemView()
//        (yearBtn, yearLbl1, yearLbl2, yearLbl3) = itemView()
//        
//        self.scrollView.addSubview(weekBtn)
////        self.scrollView.addSubview(monthBtn)
//        self.scrollView.addSubview(yearBtn)
//        
//        yearBtn.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.width.equalTo(UIScreen.width - 30)
//            make.height.equalTo(70)
//            make.bottom.equalTo(self.restoreBtn.snp.top)
//        }
////
////        monthBtn.snp.makeConstraints { (make) in
////            make.centerX.equalToSuperview()
////            make.width.equalTo(UIScreen.width - 30)
////            make.height.equalTo(70)
////            make.bottom.equalTo(self.yearBtn.snp.top).offset(-25)
////        }
//        
//        weekBtn.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.width.equalTo(UIScreen.width - 30)
//            make.height.equalTo(70)
//            make.bottom.equalTo(self.yearBtn.snp.top).offset(-25)
//        }
//    }
//}
