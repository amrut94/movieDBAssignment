
import Foundation
struct CastResponse : Codable {
	let id : Int?
	let cast : [Cast]?
	let crew : [Cast]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case cast = "cast"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		cast = try values.decodeIfPresent([Cast].self, forKey: .cast)
		crew = try values.decodeIfPresent([Cast].self, forKey: .cast)
	}

}
