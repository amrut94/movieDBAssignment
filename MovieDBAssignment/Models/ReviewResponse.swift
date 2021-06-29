

import Foundation
struct ReviewResponse : Codable {
	let id : Int?
	let page : Int?
	let reviews : [Review]?
	let total_pages : Int?
	let total_results : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case page = "page"
		case reviews = "results"
		case total_pages = "total_pages"
		case total_results = "total_results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		reviews = try values.decodeIfPresent([Review].self, forKey: .reviews)
		total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
		total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
	}

}
