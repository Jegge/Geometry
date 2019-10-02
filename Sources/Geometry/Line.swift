//
//  Line.swift
//  
//
//  Created by Sebastian Boettcher on 02.10.19.
//

import Foundation

public struct Line {
    init (from a: CGPoint, to b: CGPoint, isInfinite: Bool = true) {
        self.a = a
        self.b = b
        self.isInfinite = isInfinite
    }

    let a: CGPoint
    let b: CGPoint
    let isInfinite: Bool

    func distance (to point: CGPoint) -> (distance: CGFloat, hitPoint: CGPoint)? {
        return Geometry.distance(from: point, to: self)
    }

    func intersects (point: CGPoint) -> Bool {
        return Geometry.intersects(point: point, with: self)
    }

    func intersects (line: Line) -> CGPoint? {

        if self.a.x == self.b.x {
            if line.a.x == line.b.x {
                return nil // parallel
            }
            let s = (line.b.y - line.a.y) / (line.b.x - line.a.x)
            let v = line.a.y - line.a.x * s
            let my = s * self.a.x + v
            let hitPoint = CGPoint(x: self.a.x, y: my)

            if !self.isInfinite && !isInBounds(hitPoint, minimum: self.a, maximum: self.b) {
                return nil
            }
            if !line.isInfinite && !isInBounds(hitPoint, minimum: line.a, maximum: line.b) {
                return nil
            }
            return hitPoint
        }

        if line.a.x == line.b.x {
            let s = (self.b.y - self.a.y) / (self.b.x - self.a.x)
            let v = self.a.y - self.a.x * s
            let my = line.a.x * s + v
            let hitPoint = CGPoint(x: self.a.x, y: my)

            if !self.isInfinite && !isInBounds(hitPoint, minimum: self.a, maximum: self.b) {
                return nil
            }
            if !line.isInfinite && !isInBounds(hitPoint, minimum: line.a, maximum: line.b) {
                return nil
            }
            return hitPoint
        }

        let stg1 = (self.b.y - self.a.y) / (self.b.x - self.a.x)
        let stg2 = (line.b.y - line.a.y) / (line.b.x - line.a.x)

        if stg1 == stg2 {
            return nil // all or no points intersect
        }

        let ver1 = self.a.y - self.a.x * stg1
        let ver2 = line.a.y - line.a.x * stg2

        let sx = (ver2 - ver1) / (stg1 - stg2)
        let sy = stg1 * sx + ver1

        let hitPoint = CGPoint(x: sx, y: sy)

        if !self.isInfinite && !isInBounds(hitPoint, minimum: self.a, maximum: self.b) {
            return nil
        }
        if !line.isInfinite && !isInBounds(hitPoint, minimum: line.a, maximum: line.b) {
            return nil
        }
        return hitPoint
    }
}
