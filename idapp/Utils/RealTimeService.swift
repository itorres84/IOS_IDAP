//
//  RealTimeService.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 02/12/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import Foundation
import Firebase


public typealias CallbackResponseGetPayments = (_ response:[Payment]?, _ error: NSError?) -> ()

public class RealTimeService {
    
//    let urlUsers:String!
    
    public init() {
//        urlUsers = "https://odin-mx-users.firebaseio.com/"
        if Database.database().isPersistenceEnabled != true{
            Database.database().isPersistenceEnabled = true
        }
    }
    
    public func getPayments(uid:String,callback:@escaping CallbackResponseGetPayments){
        //        if Database.database().isPersistenceEnabled != true{
        //            Database.database().isPersistenceEnabled = true
        //        }
        let parentRef = Database.database().reference().child("users").child(uid).child("payments")
        parentRef.observeSingleEvent(of: .value, with:{
            snapshot in
                print("SNAPSHOOOOOT: ")
                print(snapshot)
                if ( snapshot.value is NSNull ){
                    print("Data was not found from server")
                    callback(nil, NSError(domain: "Data was not found from server", code: 0, userInfo: [:]))
                }else {
                    var arrayPayments:[Payment] = []
                    
                    for user_child in (snapshot.children){
                        let user_snap = user_child as! DataSnapshot
                        let dict = user_snap.value as! [String: Any?]
                        
                        arrayPayments.append(Payment(dictionary: dict as NSDictionary))
                    }
                    callback(arrayPayments,nil)
                }
        })
    }
    
}
