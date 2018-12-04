//
//  Structures.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 18/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import Foundation
import UIKit

struct Pago {
    var concepto : String
    var fechaPago : String
    var monto : String
    var facturado : Bool
    var metodoPago : String
    var horaPago : String
}

struct DatosFactura {
    var razonSocial : String
    var rfc : String
    var direccion : String
}
