

import Foundation
struct Cast : Codable {
	let name : String?
	let original_name : String?
	let profile_path : String?

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case original_name = "original_name"
		case profile_path = "profile_path"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
		profile_path = try values.decodeIfPresent(String.self, forKey: .profile_path)
	}

}
