//
//  WaxDates.swift
//  WaxUtilities
//
//  Created by Bill Weatherwax on 2/8/20.
//  Copyright © 2020 waxcruz. All rights reserved.
//

import Foundation

public class WaxDates : NSObject
{
    static public func year() -> String
    {
        // get current year as yyyy
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate    }
}


