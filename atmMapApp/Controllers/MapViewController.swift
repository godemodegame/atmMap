import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, GMUClusterManagerDelegate {
    
    var cameraCoordinates: Coordinates?
    var clusterManager: GMUClusterManager!
    let locationManager = CLLocationManager()
    
    let mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(55.75370903771494), longitude: CLLocationDegrees(37.61981338262558), zoom: 14)
        let map = GMSMapView.map(withFrame: .zero, camera: camera)
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(r: 26, g: 186, b: 78)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        if let cameraCoordinates = cameraCoordinates {
            let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(cameraCoordinates.latitude), longitude: CLLocationDegrees(cameraCoordinates.longitude), zoom: 14)
            mapView.animate(to: camera)
            navigationItem.title = "На карте"
        } else {
            navigationItem.title = "Карта"
        }
        
        mapView.delegate = self
        view = mapView
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        

        // Cluster
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        generateClusterItems()
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if cameraCoordinates == nil {
            let location = locations.last
            let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom: 14)
            mapView.animate(to: camera)
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    
    private func generateClusterItems() {
        guard let atms = atms else { return }
        for index in 0...atms.count - 1 {
            let lat = atms[index].latitude
            let lng = atms[index].longitude
            let name = "Item \(atms[index].number)"
            let item = POIItem(position: CLLocationCoordinate2DMake(lat, lng), name: name, number: index)
            clusterManager.add(item)
        }
    }
    
    private func clusterManager(clusterManager: GMUClusterManager, didTapCluster cluster: GMUCluster) {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position, zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? POIItem {
            let index = poiItem.number
            guard let atms = atms else { return false }
            let atm = atms[index]
            marker.title = atm.type
            marker.snippet = atm.street + " " + atm.nameOfStreet + ", " + atm.numberOfHouse + (atm.building != nil ? "к\(atm.building!)" : "")
        } else {
            mapView.animate(toZoom: mapView.camera.zoom + 1)
        }
        return false
    }
}
