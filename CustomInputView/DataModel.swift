import Foundation

class DataModel: Codable {
    // MARK: Properties
    private var entries: [Int]
    public var count: Int { return entries.count }
    
    // MARK: Methods
    init(entries: [Int]) {
        self.entries = entries
    }
    
    convenience init(numberOfEntries: Int) {
        self.init(entries: [Int](repeating: 0, count: numberOfEntries))
    }
    
    subscript(_ index: Int) -> Int {
        return entries[index]
    }
    
    enum CodingKeys: String, CodingKey {
        case entries = "entries"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.entries = try container.decode([Int].self, forKey: .entries)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(entries, forKey: .entries)
    }
}

extension DataModel: CustomInputCellDelegate {
    // MARK: Input Related Extensions
    func insertText(_ text: String, at indexPath: IndexPath, didFinishUpdate: ((Int) -> ())?) {
        if let number = Int(text), number < 10 {
            let newEntry = entries[indexPath.item] * 10 + number
            guard newEntry < 1000 else { return }
            entries[indexPath.item] = newEntry
            didFinishUpdate?(entries[indexPath.item])
        }
    }
    
    func deleteBackwards(at indexPath: IndexPath, didFinishUpdate: ((Int) -> ())?) {
        entries[indexPath.item] /= 10
        didFinishUpdate?(entries[indexPath.item])
    }
}
