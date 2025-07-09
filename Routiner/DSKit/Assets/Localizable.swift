import Foundation

protocol Localizable {
    var tableName: String { get }
    
    func string(_ arguments: [CVarArg]) -> String
    func string(_ arguments: CVarArg...) -> String
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    func string(_ arguments: [CVarArg]) -> String {
        let localizedString = NSLocalizedString(self.rawValue, tableName: tableName, bundle: .main, value: "", comment: "")
        return String(format: localizedString, arguments: arguments)
    }

    func string(_ arguments: CVarArg...) -> String {
        return string(arguments)
    }
}
