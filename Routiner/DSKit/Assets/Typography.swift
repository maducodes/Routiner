import Foundation
import UIKit

public enum FontType {
    case headline1
    case headline2
    case headline3
    case headline4
    case headline5
    case headline6
    case title
    case paragraph1
    case paragraph2
    case alternative
    case chip
}

public struct Typography {
    static let airbnbCerealBold = "airbnb-cereal-app-bold"
    static let airbnbCerealMedium = "airbnb-cereal-app-medium"
    static let airbnbCerealBook = "airbnb-cereal-app-book"
    
    static func setTypography(using fontType: FontType) -> UIFont {
        switch fontType {
        case .headline1:
            return UIFont(name: self.airbnbCerealBold, size: 48) ?? UIFont.systemFont(ofSize: 48, weight: .bold)
        case .headline2:
            return UIFont(name: self.airbnbCerealBold, size: 40) ?? UIFont.systemFont(ofSize: 40, weight: .bold)
        case .headline3:
            return UIFont(name: self.airbnbCerealBold, size: 36) ?? UIFont.systemFont(ofSize: 36, weight: .bold)
        case .headline4:
            return UIFont(name: self.airbnbCerealBold, size: 32) ?? UIFont.systemFont(ofSize: 32, weight: .bold)
        case .headline5:
            return UIFont(name: self.airbnbCerealBold, size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
        case .headline6:
            return UIFont(name: self.airbnbCerealMedium, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
        case .title:
            return UIFont(name: self.airbnbCerealMedium, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .medium)
        case .paragraph1:
            return UIFont(name: self.airbnbCerealBook, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .light)
        case .paragraph2:
            return UIFont(name: self.airbnbCerealMedium, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
        case .alternative:
            return UIFont(name: self.airbnbCerealBook, size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .light)
        case .chip:
            return UIFont(name: self.airbnbCerealBold, size: 10) ?? UIFont.systemFont(ofSize: 10, weight: .bold)
        }
    }
}
