
import Foundation

func distance (from point: CGPoint, to line: Line) -> (distance: CGFloat, hitPoint: CGPoint)? {
    let m: CGFloat = (line.a - line.b).magnitude
    let u: CGFloat = (((point.x - line.a.x) * (line.b.x - line.a.x)) +
                      ((point.y - line.a.y) * (line.b.y - line.a.y))) / (m * m)

    if (u < 0 || u > 1) {
        return nil
    }

    let hitPoint = CGPoint(x: line.a.x + u * (line.b.x - line.a.x),
                           y: line.a.y + u * (line.b.y - line.a.y))

    let distance = (hitPoint - point).magnitude

    return (distance, hitPoint)
}

func intersects (point: CGPoint, with line: Line) -> Bool {
    if let (distance, _) = distance(from: point, to: line) {
        if line.isInfinite || isInBounds(point, minimum: line.a, maximum: line.b) {
            return distance <= CGFloat.ulpOfOne
        }
    }
    return false
}

func isInBounds (_ test: CGPoint, minimum: CGPoint, maximum: CGPoint) -> Bool {
    return (test.y >= minimum.y && test.y <= maximum.y && test.x >= minimum.x && test.x <= maximum.x) ||
           (test.y >= maximum.y && test.y <= minimum.y && test.x >= maximum.x && test.x <= minimum.x) ||
           (test.y >= minimum.y && test.y <= maximum.y && test.x >= maximum.x && test.x <= minimum.x) ||
           (test.y >= maximum.y && test.y <= minimum.y && test.x >= minimum.x && test.x <= maximum.x)
}
