import UIKit

class TableViewController: UITableViewController {

    let cellId = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAtms {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        navigationController?.navigationBar.barTintColor = UIColor(r: 26, g: 186, b: 78)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Банкоматы"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atms?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        guard let atms = atms else { return cell }
        let atm = atms[indexPath.row]
        cell.textLabel?.text = atm.street + " " + atm.nameOfStreet + ", " + atm.numberOfHouse + (atm.building != nil ? "к\(atm.building!)" : "")
        cell.detailTextLabel?.textColor = .lightGray
        cell.detailTextLabel?.text = atm.type + " ● " + atm.workingTime
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapViewController = MapViewController()
        guard let atms = atms else { return }
        mapViewController.cameraCoordinates = Coordinates(latitude: Float(atms[indexPath.row].latitude), longitude: Float(atms[indexPath.row].longitude))
        navigationController?.pushViewController(mapViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
