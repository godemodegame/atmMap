import Foundation

struct Atm: Decodable {
    let number: String
    let locality: String
    let nameOfLocality: String
    let street: String
    let nameOfStreet: String
    let house: String?
    let numberOfHouse: String
    let building: Int?
    let latitude: Double
    let longitude: Double
    let instalationLocation: String
    let workingTime: String
    let type: String
    let isCashInModule: Bool
    let isCashToCard: Bool
    let isCashToPay: Bool
    let accessibility: String
    let isCurrencyExchengeModule: Bool
    let postIndex: Int
    let subjectOfFederation: String?
    let nameSubjectOfFederation: String?
    let region: String?
    let nameOfRegion: String?
    let isSelfCollection: Bool
    let isLov: Bool
}

var atms: [Atm]? {
    guard let data = try? Data(contentsOf: urlToData),
        let atms = try? JSONDecoder().decode([Atm].self, from: data) else { return nil }
    return atms
}
