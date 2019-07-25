import Foundation

public enum FluentError: Error, LocalizedError, CustomStringConvertible {
    case idRequired
    case missingField(name: String)
    case missingEagerLoad(name: String)

    public var description: String {
        switch self {
        case .idRequired:
            return "ID required"
        case .missingField(let name):
            return "field missing: \(name)"
        case .missingEagerLoad(let name):
            return "eager load missing: \(name)"
        }
    }

    public var errorDescription: String? {
        return self.description
    }
}
