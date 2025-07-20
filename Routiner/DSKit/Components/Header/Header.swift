
import Foundation
import SnapKit
import UIKit

public final class Header: UIView {
    let viewModel: HeaderViewModel
    var delegate: HeaderDelegate?
    
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    
    init(viewModel: HeaderViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0,
                                               left: 24,
                                               bottom: 16,
                                               right: 24)
        return stackView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var topContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var segmentControlStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var datePickerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    func setupUI() {
        backgroundColor = viewModel.background
        buildViewHierarchy()
        buildConstraints()
        setupSections()
    }
    
    private func setupSections() {
        setupInformation()
        setupTopContent()
        setupProfile()
        setupDatePicker()
        setupSegmentControl()
    }
    
    @objc
    func handleTapLeftButton() {
        delegate?.handleTapLeftButton()
        feedbackGenerator.notificationOccurred(.success)
    }
    
    @objc
    func handleTapRightButton() {
        delegate?.handleTapRightButton()
        feedbackGenerator.notificationOccurred(.success)
    }
    
    private func setupInformation() {
        if let leftIcon = viewModel.leftIcon {
            let button = UIButton()
            button.layer.borderWidth = 1
            button.layer.borderColor = Colors.Primary.Black.black10?.cgColor
            button.layer.cornerRadius = 16
            button.addTarget(self, action: #selector(handleTapLeftButton), for: .touchUpInside)
            button.backgroundColor = Colors.Primary.Base.white
            button.setImage(leftIcon, for: .normal)
            button.accessibilityLabel = viewModel.leftIconAccessibility
            
            infoStackView.addArrangedSubview(button)
            
            button.snp.makeConstraints {
                $0.width.equalTo(48)
                $0.height.equalTo(48)
            }
        }
        
        if let title = viewModel.title {
            let label = UILabel()
            label.text = title
            label.textColor = Colors.Primary.Black.black100
            label.font = Typography.setTypography(using: .headline5)
            infoStackView.addArrangedSubview(label)
        }
        
        if let rightIcon = viewModel.rightIcon {
            let button = UIButton()
            button.layer.borderWidth = 1
            button.layer.borderColor = Colors.Primary.Black.black10?.cgColor
            button.layer.cornerRadius = 16
            button.addTarget(self, action: #selector(handleTapRightButton), for: .touchUpInside)
            button.backgroundColor = Colors.Primary.Base.white
            
            button.setImage(rightIcon, for: .normal)
            button.accessibilityLabel = viewModel.rightIconAccessibility
            infoStackView.addArrangedSubview(button)
            
            button.snp.makeConstraints {
                $0.width.equalTo(48)
                $0.height.equalTo(48)
            }
        }
        
        if viewModel.rightIcon != nil || viewModel.title != nil || viewModel.leftIcon != nil {
            headerStackView.addArrangedSubview(infoStackView)
        }
    }
    
    private func setupTopContent() {
        if let topContent = viewModel.topContent {
            let containerStackView = UIStackView()
            containerStackView.axis = .vertical
            containerStackView.distribution = .fill
            
            let titleLabel = UILabel()
            titleLabel.text = topContent.title
            titleLabel.textColor = Colors.Primary.Black.black100
            titleLabel.font = Typography.setTypography(using: .title)
            
            let descriptionLabel = UILabel()
            descriptionLabel.text = topContent.description
            descriptionLabel.textColor = Colors.Primary.Black.black40
            descriptionLabel.font = Typography.setTypography(using: .paragraph1)
            
            containerStackView.addArrangedSubview(titleLabel)
            containerStackView.addArrangedSubview(descriptionLabel)
            
            let button = UIButton()
            button.layer.cornerRadius = 24
            button.backgroundColor = topContent.moodColor
            button.setImage(topContent.moodImage, for: .normal)
            
            topContentStackView.addArrangedSubview(containerStackView)
            topContentStackView.addArrangedSubview(button)
            
            button.snp.makeConstraints {
                $0.width.equalTo(48)
                $0.height.equalTo(48)
            }
            
            headerStackView.addArrangedSubview(topContentStackView)
        }
    }
    
    private func setupProfile() {
        if let profile = viewModel.profile {
            let button = UIButton()
            button.layer.cornerRadius = 28
            button.clipsToBounds = true
            button.setBackgroundImage(profile.image, for: .normal)
            
            let containerStackView = UIStackView()
            containerStackView.axis = .vertical
            containerStackView.distribution = .fill
            
            let nameLabel = UILabel()
            nameLabel.text = profile.name
            nameLabel.textColor = Colors.Primary.Black.black100
            nameLabel.font = Typography.setTypography(using: .title)
            
            //TODO: implements badge with user points
            let pointsBadge = UILabel()
            pointsBadge.text = profile.points
            pointsBadge.textColor = Colors.Primary.OrangeWarning.orange60
            pointsBadge.font = Typography.setTypography(using: .title)
            
            containerStackView.addArrangedSubview(nameLabel)
            containerStackView.addArrangedSubview(pointsBadge)
            
            profileStackView.addArrangedSubview(button)
            profileStackView.addArrangedSubview(containerStackView)
            
            button.snp.makeConstraints {
                $0.width.equalTo(56)
                $0.height.equalTo(56)
            }
            
            headerStackView.addArrangedSubview(profileStackView)
        }
    }
    
    private func setupSegmentControl() {
//        if let segmentControl = viewModel.segmentControl {
//            let items = segmentControl.tabs?.map({ $0.label }) ?? [""]
//            let segment = HMSegmentedControl(sectionTitles: items)
//
//            segment.selectedSegmentIndex = 0
//            segment.backgroundColor = Colors.Primary.Black.black10 ?? UIColor.clear
//            segment.selectionIndicatorColor = .blue
//            segment.selectionStyle = .fullWidthStripe
//            segment.selectionIndicatorLocation = .none
//
//            segment.layer.cornerRadius = 16
//            segment.clipsToBounds = true
//
//
//            segment.backgroundColor = Colors.Primary.Black.black10
//            segment.selectedSegmentIndex = segmentControl.selectedIndex
//            segmentControlStackView.addArrangedSubview(segment)
//
//            headerStackView.addArrangedSubview(segmentControlStackView)
//            segmentControlStackView.snp.makeConstraints {
//                $0.width.equalTo(infoStackView.snp.width)
//                $0.height.equalTo(48)
//            }
//
//            segment.clipsToBounds = true
//            segment.layer.cornerRadius = 16
//        }
    }
    
    private func setupDatePicker() {
        if let datePicker = viewModel.datePicker {
            let containerStackView = UIStackView()
            containerStackView.axis = .vertical
            containerStackView.distribution = .fill
            
            let titleLabel = UILabel()
            titleLabel.text = datePicker.title
            titleLabel.textColor = Colors.Primary.Black.black100
            titleLabel.font = Typography.setTypography(using: .title)
            
            let descriptionLabel = UILabel()
            descriptionLabel.text = datePicker.description
            descriptionLabel.textColor = Colors.Primary.Black.black60
            descriptionLabel.font = Typography.setTypography(using: .paragraph1)
            
            containerStackView.addArrangedSubview(titleLabel)
            containerStackView.addArrangedSubview(descriptionLabel)
            
            let leftButton = UIButton()
            leftButton.layer.borderWidth = 1
            leftButton.layer.borderColor = Colors.Primary.Black.black10?.cgColor
            leftButton.layer.cornerRadius = 16
            leftButton.backgroundColor = Colors.Primary.Base.white
            leftButton.setImage(Images.arrowLeft, for: .normal)
            leftButton.isHidden = !datePicker.hasLeftButton
            
            let rightButton = UIButton()
            rightButton.layer.borderWidth = 1
            rightButton.layer.borderColor = Colors.Primary.Black.black10?.cgColor
            rightButton.layer.cornerRadius = 16
            rightButton.backgroundColor = Colors.Primary.Base.white
            rightButton.setImage(Images.arrowRight, for: .normal)
            rightButton.isHidden = !datePicker.hasRightButton
            
            datePickerStackView.addArrangedSubview(containerStackView)
            datePickerStackView.addArrangedSubview(leftButton)
            datePickerStackView.addArrangedSubview(rightButton)
            
            headerStackView.addArrangedSubview(datePickerStackView)
            datePickerStackView.snp.makeConstraints {
                $0.width.equalTo(infoStackView.snp.width)
                $0.height.equalTo(48)
            }
            
            leftButton.snp.makeConstraints {
                $0.width.equalTo(48)
                $0.height.equalTo(48)
            }
            
            rightButton.snp.makeConstraints {
                $0.width.equalTo(48)
                $0.height.equalTo(48)
            }
        }
    }
    
    private func buildViewHierarchy() {
        addSubview(headerStackView)
    }
    
    private func buildConstraints() {
        if viewModel.hasBottomLine {
            headerStackView.layer.borderColor = Colors.Primary.Black.black10?.cgColor
            headerStackView.layer.borderWidth = 1
        }
        
        headerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
