//
//  WaxNumberFormatting.swift
//  WaxUtilities
//
//  Created by Bill Weatherwax on 3/15/20.
//  Copyright © 2020 waxcruz. All rights reserved.
//

import Foundation
public class WaxNumberFormatting : NSObject
{
    static public func doubleWithSeparator(myNumber : Double) -> String
    {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.maximumFractionDigits = 0
        let formattedNumber = format.string(from: NSNumber(value: myNumber))
        return formattedNumber ?? ""
    }
}
