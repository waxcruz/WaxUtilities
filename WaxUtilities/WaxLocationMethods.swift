//
//  WaxLocationMethods.swift
//  WaxUtilities
//
//  Created by Bill Weatherwax on 2/11/20.
//  Copyright © 2020 waxcruz. All rights reserved.
//

import Foundation
import CoreLocation

public class WaxLocationMethods : NSObject
{
    public var latitude : Double
    public var longitude : Double
    public var altitude : Double

    public override init() {
        latitude = 0.0
        longitude = 0.0
        altitude = 0.0
        super.init()
    }
  
    public func bearing(destinationLat : Double, destinationLon : Double) -> Double {
        // using current latitude and longitude, calculate bearing to a coordinate
        let rad = Double.pi/180.0
        let deltaLats = (destinationLon - longitude)
        let X = cos(destinationLat*rad) * sin(deltaLats*rad)
        let Y = cos(latitude*rad) * sin(destinationLat*rad) - sin(latitude*rad) * cos(destinationLat*rad) * cos(deltaLats*rad)
        let beta = atan2(X, Y)
        let ans = beta*(1/rad)
        return (ans < 0 ? 360.0 + ans : ans)
    }
    
    public func isInFieldOfView(facingDirection : String, toleranceInDegrees : Double, meLat : Double, meLon : Double, locationLat : Double, locationLon : Double)-> Bool {
        var leftLat : Double = meLat
        var leftLon : Double = meLon
        var rightLat : Double = meLat
        var rightLon : Double = meLon
        // calculate triangle
        switch facingDirection {
        case "N":
            leftLon -= toleranceInDegrees
            rightLon += toleranceInDegrees
            leftLat += toleranceInDegrees
            rightLat += toleranceInDegrees
            break
        case "E":
            leftLon += toleranceInDegrees
            rightLon += toleranceInDegrees
            leftLat += toleranceInDegrees
            rightLat -= toleranceInDegrees
            break
        case "S":
            leftLon += toleranceInDegrees
            rightLon -= toleranceInDegrees
            leftLat -= toleranceInDegrees
            rightLat -= toleranceInDegrees
            break
        case "W":
            leftLon -= toleranceInDegrees
            rightLon -= toleranceInDegrees
            leftLat -= toleranceInDegrees
            rightLat += toleranceInDegrees
            break
        case "NE":
            leftLat += toleranceInDegrees
            rightLon += toleranceInDegrees
            break
        case "SE":
            leftLon += toleranceInDegrees
            rightLat -= toleranceInDegrees
            break
        case "SW":
            leftLat -= toleranceInDegrees
            rightLon -= toleranceInDegrees
            break
        case "NW":
            leftLon -= toleranceInDegrees
            rightLat += toleranceInDegrees
            break
        default:
            print("Error in facingDirection")
        }
        // debugging print statements
//        print("Filtering for facing direction %@", facingDirection)
//        print("My position:   %0.3f %0.3f",meLat, meLon)
//        print("Left position: %0.3f %0.3f", leftLat, leftLon)
//        print("Right position:%0.3f %0.3f", rightLat, rightLon)
        return IsLocationInFieldOfView(x1: meLat, y1: meLon, x2: leftLat, y2: leftLon, x3: rightLat, y3: rightLon, x: locationLat, y: locationLon)
    }
    
    
    
    /* A utility function to calculate area of triangle
       formed by (x1, y1) (x2, y2) and (x3, y3) */
    func area(x1 : Double, y1 : Double, x2 : Double, y2 : Double, x3: Double, y3 : Double ) -> Double
    {
       return fabs((x1*(y2-y3) + x2*(y3-y1)+x3*(y1-y2))/2.0)
    }
       
    /* A function to check whether point P(x, y) lies
       inside the triangle formed by A(x1, y1),
       B(x2, y2) and C(x3, y3) */
    func IsLocationInFieldOfView(x1 : Double, y1 : Double, x2 : Double, y2 : Double, x3: Double, y3 : Double, x : Double, y : Double) -> Bool
    {
       /* Calculate area of triangle ABC */
        let A = area(x1:x1, y1:y1, x2:x2, y2:y2, x3:x3, y3:y3)
       
       /* Calculate area of triangle PBC */
        let A1 = area (x1:x, y1:y, x2:x2, y2:y2, x3:x3, y3:y3);
       
       /* Calculate area of triangle PAC */
        let A2 = area (x1:x1, y1:y1, x2:x, y2:y, x3:x3, y3:y3);
       
       /* Calculate area of triangle PAB */
        let A3 = area (x1:x1, y1:y1, x2:x2, y2:y2, x3:x, y3:y);
         
       /* Check if sum of A1, A2 and A3 is same as A */
        return fabs((A - (A1 + A2 + A3))) < 0.00001 ? true : false;
    }

    
    public func calculateDistance(originLat : Double, originLon : Double, destinationLat : Double, destinationLon : Double)->Double {
        
        let run : Double  = pow((destinationLat - originLat),2)
        let rise : Double = pow((destinationLon - originLon), 2)
        return sqrt(run + rise)
        
    }
}
