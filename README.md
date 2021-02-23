# YZYPurchaseKit


 
 1. 必须设置商品id，密钥，配置地址，默认配置
 ```swift
 
 PurchaseDefaultValue.purchaseSecret = "xxxx"
 PurchaseDefaultValue.weeId = "xxx"
 PurchaseDefaultValue.monId = "xxx"
 PurchaseDefaultValue.yeaId = "xx"
 PurchaseDefaultValue.configUrl = URL(string: "xxxxxx")!
 PurchaseDefaultValue.defaultConfigJson = ""
 PurchaseProductMgr.handleLauch()
 
 ```
 
 2. 适配多语
  默认使用多语的方法返回一些提示错误信息 ，适配一下
```

"unknow_err" = "Network error";
"cancel_err" = "Purchase cancelled";

"loading_tip_str" = "Loading";

"have_restore_product_error" = "Restore failed!";
"have_not_restore_product" = "You have no subscribed product";
"rest_suc" = "Restore Successfully";


"sub_week" = "1 Week";
"sub_month" = "1 Month";
"sub_year" = "1 Year";

"sub_freeday_tip_big" = "3 Days Free Trial";
"sub_freeday_tip" = "3 days free trial,";
"sub_then" = "then ";

"sub_period_weekly" = "Weekly";
"sub_period_monthly" = "Monthly";
"sub_period_yearly" = "Yearly";

```

3.  具体订阅界面代码逻辑 参考 `ItemBuyViewController` 代码， 包含界面代码， 购买，恢复和flurry 埋点，不要直接copy。




