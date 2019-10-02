//
//  Triangle.swift
//  
//
//  Created by Sebastian Boettcher on 02.10.19.
//

import Foundation

public struct Triangle {
    let a: CGPoint
    let b: CGPoint
    let c: CGPoint

    func contains (point: CGPoint) -> Bool {
        let v0 = self.c - self.a
        let v1 = self.b - self.a
        let v2 = point - self.a

        let dot00 = v0.dot(v0)
        let dot01 = v0.dot(v1)
        let dot02 = v0.dot(v2)
        let dot11 = v1.dot(v1)
        let dot12 = v1.dot(v2)

        let d = 1 / (dot00 * dot11 - dot01 * dot01)
        let u = (dot11 * dot02 - dot01 * dot12) * d
        let v = (dot00 * dot12 - dot01 * dot02) * d

        return u > 0 && v > 0 && u + v < 1;
    }
}
