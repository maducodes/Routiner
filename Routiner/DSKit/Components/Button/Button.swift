import Foundation
import SnapKit
import UIKit

public final class Button: UIView {
    var viewModel: ButtonViewModel
    private var buttonConfig = UIButton.Configuration.filled()
    
    var didTapButton: (() -> ())?
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    init(viewModel: ButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let attributedTitle = NSAttributedString(string: viewModel.title,
                                                 attributes: [.font: Typography.setTypography(using: .paragraph2)])
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.isEnabled = viewModel.isEnabled
        
        buttonConfig.imagePadding = 8
        buttonConfig.imagePlacement = .leading
        
        if let icon = viewModel.icon {
            var image = icon
            
            if let tintColor = viewModel.iconTint {
                image = icon.withTintColor(tintColor, renderingMode: .alwaysTemplate)
            }
            
            button.setImage(image, for: .normal)
        }
        
        buildLayoutColors()
        button.configuration = buttonConfig
        
        buildAccessibility()
        buildViewHierarchy()
        buildConstraints()

        button.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        button.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc private func buttonPressed() {
        didTapButton?()
        buildLayoutColorsWhenPressed()
        UIImpactFeedbackGenerator().impactOccurred()
    }
    
    @objc private func buttonReleased() {
        buildLayoutColors()
    }
    
    private func buildLayoutColors() {
        switch viewModel.type {
        case .primary:
            buttonConfig.baseBackgroundColor = Colors.Primary.Blue.blue100
            buttonConfig.baseForegroundColor = Colors.Primary.Base.white
        case .secondary:
            buttonConfig.baseBackgroundColor = Colors.Primary.Base.white
            buttonConfig.baseForegroundColor = Colors.Primary.Black.black100
        case .outline:
            buttonConfig.baseBackgroundColor = Colors.Primary.Base.white
            buttonConfig.baseForegroundColor = Colors.Primary.Base.white
            button.layer.borderColor = Colors.Primary.Black.black10?.cgColor
            button.layer.borderWidth = 1
        }
    }
    
    private func buildLayoutColorsWhenPressed() {
        switch viewModel.type {
        case .primary:
            button.backgroundColor = Colors.Primary.Blue.blue80
        case .secondary:
            button.backgroundColor = Colors.Primary.Black.black20
        case .outline:
            button.backgroundColor = Colors.Primary.Base.white
        }
    }
    
    private func buildAccessibility() {
        button.isAccessibilityElement = true
        button.accessibilityTraits = .button
        button.accessibilityLabel = viewModel.accessibilityLabel
        button.accessibilityHint = viewModel.accessibilityHint
        button.accessibilityValue = viewModel.accessibilityValue
    }
    
    private func buildViewHierarchy() {
        addSubview(button)
    }
    
    private func buildConstraints() {
        switch viewModel.weigth {
        case .small:
            button.heightAnchor.constraint(equalToConstant: 36).isActive = true
            button.layer.cornerRadius = 36 / 2
            button.clipsToBounds = true
            break
        case .medium:
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.layer.cornerRadius = 44 / 2
            button.clipsToBounds = true
            break
        case .large:
            button.heightAnchor.constraint(equalToConstant: 52).isActive = true
            button.layer.cornerRadius = 52 / 2
            button.clipsToBounds = true
            break
        }
                
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension UIImage {
    static func imageWithColor(tintColor: UIColor?) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        tintColor?.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
