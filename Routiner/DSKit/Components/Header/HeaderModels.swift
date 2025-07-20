
import Foundation
import UIKit

struct HeaderViewModel {
    let leftIcon: UIImage?
    let leftIconAccessibility: String?
    let rightIcon: UIImage?
    let rightIconAccessibility: String?
    let title: String?
    let topContent: TopContent?
    let segmentControl: SegmentControl?
    let datePicker: DatePicker?
    let profile: Profile?
    let background: UIColor?
    let hasBottomLine: Bool
    
    init(leftIcon: UIImage? = Images.arrowLeft,
         leftIconAccessibility: String? = "Voltar",
         rightIcon: UIImage? = nil,
         rightIconAccessibility: String? = nil,
         title: String? = nil,
         topContent: TopContent? = nil,
         segmentControl: SegmentControl? = nil,
         datePicker: DatePicker? = nil,
         profile: Profile? = nil,
         background: UIColor? = Colors.Primary.Base.white,
         hasBottomLine: Bool = true) {
        self.leftIcon = leftIcon
        self.leftIconAccessibility = leftIconAccessibility
        self.rightIcon = rightIcon
        self.rightIconAccessibility = rightIconAccessibility
        self.title = title
        self.topContent = topContent
        self.segmentControl = segmentControl
        self.datePicker = datePicker
        self.profile = profile
        self.background = background
        self.hasBottomLine = hasBottomLine
    }
}

struct TopContent {
    let title: String
    let description: String
    let moodColor: UIColor?
    let moodImage: UIImage
}

struct Profile {
    let image: UIImage?
    let name: String
    let points: String
}

struct SegmentControl {
    let tabs: [SegmentControlItem]?
    let selectedIndex: Int
}

struct SegmentControlItem {
    let label: String
    let badgeTitle: String
}

struct DatePicker {
    let title: String
    let description: String
    let hasLeftButton: Bool
    let hasRightButton: Bool
}

protocol HeaderDelegate {
    func handleTapLeftButton()
    func handleTapRightButton()
}
