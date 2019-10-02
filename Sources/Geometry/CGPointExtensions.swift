//
//  CGPointExtensions.swift
//  
//
//  Created by Sebastian Boettcher on 02.10.19.
//

import Foundation

public extension CGPoint {

    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs * rhs.x, y: lhs * rhs.y)
    }
    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    static func *= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    static func /= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    var magnitude: CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }

    var normalized: CGPoint {
        return CGPoint(x: self.x / self.magnitude, y: self.y / self.magnitude)
    }

    func dot (_ point: CGPoint) -> CGFloat {
        return self.x * point.x + self.y * point.y
    }

    func distance (to point: CGPoint) -> CGFloat {
        return (self - point).magnitude
    }

    func distance (to line: Line) -> (distance: CGFloat, hitPoint: CGPoint)? {
        return Geometry.distance(from: self, to: line)
    }

    func intersects (point: CGPoint) -> Bool {
        return self.distance(to: point) <= CGFloat.ulpOfOne
    }

    func intersects (line: Line) -> Bool {
        return Geometry.intersects(point: self, with: line)
    }
}

public func abs (point: CGPoint) -> CGPoint {
    return CGPoint(x: abs(point.x), y: abs(point.y))
}



/*

 public static double AngleInBetween (PointD a, PointD b) {
     return (Math.Atan2(b.Y, b.X) - Math.Atan2(a.Y, a.X)) * 180.0 / Math.PI;
 }
 public static double AngleInBetween2 (PointD a, PointD b) {
     double w = AngleInBetween(a, b);
     if ((w <= 180.0f) && (w >= -180.0f))
         return Math.Truncate(w);

     return Math.Truncate(w - 360.0f);
 }
 public static PointD RotateAround (PointD p, PointD center, double angle) {
     double r = angle * Math.PI / 180.0;
     double x = center.X + (Math.Cos(r) * (p.X - center.X) - Math.Sin(r) * (p.Y - center.Y));
     double y = center.Y + (Math.Sin(r) * (p.X - center.X) + Math.Cos(r) * (p.Y - center.Y));
     return new PointD(x, y);
 }
 /// <summary>
 /// Checks wether points p1 and p2 lie on the same side of (a->b) or not
 /// </summary>
 /// <param name="p1">first point</param>
 /// <param name="p2">second point</param>
 /// <param name="a">Line start</param>
 /// <param name="b">Line end</param>
 /// <returns>True if they are on the same side</returns>
 public static bool PointsInHalfPlane (PointD p1, PointD p2, PointD a, PointD b) {
     // are both points p1 and p2 on the same side of a->islast?
     // TODO: PM.PointsInHalfPlane
     PointD normal = NormalVector(a, b);
     double x = Dot(normal, p1);
     double y = Dot(normal, p2);
     return ((x * y) > 0.0f);
 }
 */
