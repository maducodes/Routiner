import Foundation
import UIKit

enum Onboarding {
    enum Model {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let items: [SliderItem]
            let currentPage: Int
            let numberOfPages: Int
        }
    }
    
    struct SliderItem {
        let image: UIImage?
        let title: String
        let description: String
    }
}

enum LoginType {
    case google
    case facebook
    case apple
    case email
}
