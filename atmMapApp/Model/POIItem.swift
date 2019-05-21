import Foundation

class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    var number: Int
    
    init(position: CLLocationCoordinate2D, name: String, number: Int) {
        self.position = position
        self.name = name
        self.number = number
    }
}
