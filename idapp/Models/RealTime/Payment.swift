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
