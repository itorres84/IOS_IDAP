//
//  Payment.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 02/12/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import Foundation
import EVReflection

//MARK: - General
public class Payment:EVNetworkingObject {
    public var amount:NSNumber?
    public var amount_refunded:NSNumber?
    public var charges:[Charges]?
    public var created_at:NSNumber?
    public var currency:String?
    public var customer_info:[CustomerInfo]?
    public var dataFactura:[DataFactura]?
    public var id:String?
    public var line_items:[LineItems]?
    public var livemode:NSNumber? //Bool
    public var payment_status:String?
    public var updated_at:NSNumber?
    
    //Paypal var
    public var car:String?
    public var create_time:String?
    public var httpStatusCode:NSNumber?
    public var intent:String?
    public var links:[Links]?
    public var payer:Payer?
    public var state:String?
    public var transactions:[Transaction]?
    
}

//MARK: - PayPal Objs
public class Links: EVNetworkingObject{
    public var href: String?
    public var method: String?
    public var rel:String?
}

public class Payer: EVNetworkingObject{
    public var payer_info: Payer_info?
    public var payment_method: String?
    public var status:String?
}

public class Payer_info: EVNetworkingObject{
    public var country_code: String?
    public var email: String?
    public var first_name:String?
    public var last_name:String?
    public var payer_id:String?
    public var shipping_address:Shipping_address?
    
}

public class Shipping_address: EVNetworkingObject{
    public var city: String?
    public var country_code: String?
    public var line1:String?
    public var postal_code:String?
    public var recipient_name:String?
    public var state:String?
}

public class Transaction: EVNetworkingObject{
    public var amount:Amount?
    public var item_list:Item_list?
    
}

public class Amount: EVNetworkingObject{
    public var currency: String?
    public var total:String?
    
}

public class Item_list: EVNetworkingObject{
    public var items:[Item]?
    
}



public class Item:EVNetworkingObject{
    public var currency:String?
    public var name:String?
    public var price:String?
    public var quantity:NSNumber?
    public var sku:String?
    
}



//MARK: - Charges
public class Charges: EVNetworkingObject{
    public var data: [Data]?
    public var has_more: NSNumber? //Bool
    public var object: String?
    public var total: NSNumber?
}

public class Data: EVNetworkingObject{
    public var amount: NSNumber?
    public var created_at: NSNumber?
    public var currency: String?
    public var customer_id: String?
//    public var description: String?
    public var device_fingerprint: String?
    public var fee: NSNumber?
    public var id: String?
    public var livemode: NSNumber? //Bool
    public var object: String?
    public var order_id: String?
    public var paid_at: NSNumber?
    public var payment_method: [PaymentMethod]?
    public var status: String?
}

public class PaymentMethod: EVNetworkingObject{
    public var account_type: String?
    public var auth_code: String?
    public var brand: String?
    public var country: String?
    public var exp_month: String?
    public var exp_year: String?
    public var fraud_score: NSNumber?
    public var issuer: String?
    public var last4: String?
    public var name: String?
    public var object: String?
    public var type: String?
}


//MARK: - CustomerInfo
public class CustomerInfo: EVNetworkingObject{
    public var corporate: NSNumber? //Bool
    public var customer_id: String?
    public var email: String?
    public var name: String?
    public var object: String?
}


//MARK: - DataFactura
public class DataFactura: EVNetworkingObject{
    public var facturado: NSNumber? //Bool
    public var idFac: String?
    public var idProd: String?
}


//MARK: - LineItems
public class LineItems: EVNetworkingObject{
    public var data: [DataDos]?
    public var has_more: NSNumber? //Bool
    public var object: String?
    public var total: NSNumber?
}

public class DataDos: EVNetworkingObject{
    public var id: String?
    public var name: String?
    public var object: String?
    public var parent_id: String?
    public var quantity: NSNumber?
    public var unit_price: NSNumber?
}
