//
//  DateModel.swift
//  SelectorDateMVVM
//
//  Created by Edwin Ch on 7/3/22.
//

import Foundation

struct MobileUptake: Codable {

    var voiceCost: Double = 0

    var voiceMinute: Double = 0

    var voiceTotal: Int = 0

    var datosTotal: Int = 0

    var datosCost: Double = 0

    var datosMB: Double = 0

    var smsCost: Double = 0

    var smsCount: Int = 0

    var smsTotal: Int = 0

    var lastUpdate: String?

    var voiceUnlimited: Int = 1

    var guidMobile: String = ""

    

    enum CodingKeys: String, CodingKey {

        case voiceCost

        case voiceMinute

        case voiceTotal

        case datosTotal

        case datosCost

        case datosMB

        case smsCost

        case smsCount

        case lastUpdate

        case smsTotal

        case voiceUnlimited

    }



    var voiceUnlimitedBool: Bool {

        voiceUnlimited == 1

    }

    

    var datosTotalGB: Double {

        Double(datosTotal) / 1000

    }

    

    var datosGB: Double {

        Double(datosMB) / 1000

    }

}
