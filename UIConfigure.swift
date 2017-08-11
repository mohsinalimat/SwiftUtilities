//
//  UIConfigure.swift
//  MedicalApp
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import Foundation
import UIKit

let appName: String = "Medical App"

enum AppColor {

    case theme

    case themeHover

    case menuBackground

    case menuBackgroundHover

    case flag

    case general

    case facebook

    case google

    case notVerifiedAccount

    //    general button color : #3ed7e9      rgb(62,215, 233)

    //    facebook button color : #3b5999     rgb(59,89, 153)

    //    google button color : #dd4c39     rgb(221,76, 57)

    //    verified account--no--background : #bd1802       rgb(189, 24, 2)

    //
    var color: UIColor {
        switch self {
        case .theme: return UIColor.hexStr(hexStr: "#15b4c7", alpha: 1)

        case .themeHover: return UIColor.white

        case .menuBackground: return UIColor.hexStr(hexStr: "#43c6d6", alpha: 1)

        case .menuBackgroundHover: return UIColor.white

        case .flag: return UIColor.green

        case .general: return UIColor.hexStr(hexStr: "#3ed7e9", alpha: 1)

        case .facebook: return UIColor.hexStr(hexStr: "#3b5999", alpha: 1)

        case .google: return UIColor.hexStr(hexStr: "#dd4c39", alpha: 1)

        case .notVerifiedAccount: return UIColor.hexStr(hexStr: "#bd1802", alpha: 1)

        }
    }

}
