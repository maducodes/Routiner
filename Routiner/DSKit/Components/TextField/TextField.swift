
import UIKit
import SnapKit

public final class TextField: UIView {
    var onChangeTextField: ((String) -> ())?
    var didTapButtonIcon: (() -> ())?
    
    var viewModel: TextFieldViewModel? {
        didSet {
            setup()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var holderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
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
        holderLabel.attributedText = viewModel?.label
        textField.isSecureTextEntry = viewModel?.isSecutiryTextEntry ?? false
        textField.keyboardType = viewModel?.keyboardType ?? .default
        textField.attributedPlaceholder = viewModel?.placeholder
        textField.addTarget(self, action: #selector(handleChangeTextField), for: .editingChanged)
        bottomLine.backgroundColor = viewModel?.borderColor
        
        buildViewHierarchy()
        buildConstraints()
        setupImageIcon()
    }
    
    @objc func handleChangeTextField() {
        onChangeTextField?(textField.text ?? "")
    }
    
    @objc func handleTapButtonIcon() {
        didTapButtonIcon?()
    }
    
    func changeVisibilityImage(isHidden: Bool) {
        imageIcon.isHidden = isHidden
    }
    
    func clearValue() {
        textField.text = ""
    }
    
    private func setupImageIcon() {
        guard let image = viewModel?.imageIcon else { return }
        imageIcon.setImage(viewModel?.imageIcon, for: .normal)
        imageIcon.addTarget(self, action: #selector(handleTapButtonIcon), for: .touchUpInside)
        imageIcon.isHidden = !(viewModel?.isVisibleImageIcon ?? false)
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
