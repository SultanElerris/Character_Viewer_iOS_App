
import Foundation

struct CharactersDictionary: Decodable {
    var releatedTopics: [Character]
    
    enum CodingKeys: String, CodingKey {
        case releatedTopics = "RelatedTopics"
    }
}

struct Character: Decodable {
    let text: String
    let icon: Icon?
    let name: String?
    let imageURLString: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case icon = "Icon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        icon = try container.decode(Icon.self, forKey: .icon)
        name = text.components(separatedBy: " - ").first
        imageURLString = icon?.urlString
    }
}

struct Icon: Decodable {
    let urlString: String
    
    enum CodingKeys: String, CodingKey {
        case urlString = "URL"
    }
}
