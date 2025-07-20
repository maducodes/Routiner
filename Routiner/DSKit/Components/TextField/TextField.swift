
import UIKit
import SnapKit

public final class TextField: UIView {
    private(set) var value: String = ""
    var onChangeTextField: ((String) -> ())?
    var tapButtonIcon: (() -> ())?
    
    var viewModel: TextFieldViewModel {
        didSet {
            setup()
        }
    }
    
    init(viewModel: TextFieldViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var holderLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.setTypography(using: .chip)
        label.textColor = Colors.Primary.Black.black100
        return label
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(handleChangeTextField), for: .editingChanged)
        textField.keyboardType = viewModel.keyboardType ?? .default
        return textField
    }()
    
    lazy var imageIcon: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        return view
    }()
    
    private func setup() {
        holderLabel.text = viewModel.label.uppercased()
        
        let attributedPaceholder = NSAttributedString(string: viewModel.placeholder,
                                                      attributes: [.font: Typography.setTypography(using: .title),
                                                        .foregroundColor: Colors.Primary.Black.black20 ?? UIColor()])
        textField.attributedPlaceholder = attributedPaceholder
        textField.textColor = Colors.Primary.Black.black100
        textField.font = Typography.setTypography(using: .title)
        textField.isSecureTextEntry = viewModel.isSecutiryTextEntry
        
        bottomLine.backgroundColor = viewModel.borderColor
        
        buildViewHierarchy()
        buildConstraints()
        
        if let image = viewModel.imageIcon {
            setImageIcon(image)
        }
    }
    
    @objc
    func handleChangeTextField() {
        self.value = textField.text ?? ""
        onChangeTextField?(textField.text ?? "")
    }
    
    @objc
    func handleTapButtonIcon() {
        tapButtonIcon?()
    }
    
    func changeVisibilityImage(isHidden: Bool) {
        imageIcon.isHidden = isHidden
    }
    
    private func setImageIcon(_ image: UIImage) {
        imageIcon.setImage(viewModel.imageIcon, for: .normal)
        imageIcon.addTarget(self, action: #selector(handleTapButtonIcon), for: .touchUpInside)
        imageIcon.isHidden = !viewModel.isVisibleImageIcon
        containerStackView.addArrangedSubview(imageIcon)
    }
    
    private func buildViewHierarchy() {
        addSubview(holderLabel)
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(textField)
        addSubview(bottomLine)
    }
    
    private func buildConstraints() {
        holderLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(holderLabel.snp.bottom).inset(-20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        bottomLine.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).inset(-12)
            $0.leading.equalTo(textField.snp.leading)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
}
