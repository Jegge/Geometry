//
//  File.swift
//  
//
//  Created by Sebastian Boettcher on 31.10.19.
//

import Foundation


enum ClipType {
    case intersection
    case union
    case difference
    case xor
}

enum PolygonType {
    case subject
    case clip
}

enum FillType {
    case evenOdd
    case nonZero
    case positive
    case negative
}

enum JoinType {
    case square
    case round
    case miter
}

enum EndType {
    case closedPolygon
    case closedLine
    case openButt
    case openSquare
    case openRound
}

struct IntPoint: Equatable, Hashable {
    let x: Int
    let y: Int

    init (x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    init (point: IntPoint) {
        self.x = point.x
        self.y = point.y
    }
}

enum ContainsResult: Int {
    case yes = 1
    case no = 0
    case onBoundary = -1
}

public struct Polygon {

    let points: [CGPoint]

    init (points: [CGPoint]) {
        self.points = points
    }

    var area: CGFloat {
        if self.points.count < 3 {
            return 0
        }

        var result: CGFloat = 0
        var j = self.points.count - 1

        for i in 0..<self.points.count {
            result += (self.points[j].x + self.points[i].x) * (self.points[j].y * self.points[i].y)
            j = i
        }

        return -result * 0.5;
    }

    func contains (point: CGPoint) -> ContainsResult {
        if self.points.count < 3 {
            return .no
        }

        var result: ContainsResult = .no
        var current = self.points[0]
        for i in 1...self.points.count {
            let next = i == self.points.count ? self.points[0] : self.points[i]

            if next.y == point.y &&
                (next.x == point.x || (current.y == point.y && ((next.x > point.x) == (current.x < point.x)))) {
                return .onBoundary
            }

            if (current.y < point.y) != (next.y < point.y) {
                if current.x >= point.x {
                    if next.x > point.x {
                        result = ContainsResult(rawValue: 1 - result.rawValue)!
                    } else {
                        let distance = (current.x - point.x) * (next.y - point.y) - (next.x - point.x) * (current.y - point.y)
                        if distance == 0 {
                            return .onBoundary
                        }
                        if distance > 0 && next.y > current.y {
                            result = ContainsResult(rawValue: 1 - result.rawValue)!
                        }
                    }
                } else if next.x > point.x {
                    let distance = (current.x - point.x) * (next.y - point.y) - (next.x - point.x) * (current.y - point.y)
                    if distance == 0 {
                        return .onBoundary
                    }
                    if distance > 0 && next.y > current.y {
                        result = ContainsResult(rawValue: 1 - result.rawValue)!
                    }
                }
            }

            current = next
        }

        return result
    }

}
