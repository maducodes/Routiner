import Foundation
import SnapKit
import UIKit

protocol ContinueWithEmailViewDelegate {
    func onChangeTextField(_ value: String, _ textFieldType: ContinueWithEmailTextFieldType)
    func didTapButtonTextField(_ textFieldType: ContinueWithEmailTextFieldType)
    func didTapLeftIcon()
    func didTapForgotPassword()
    func didTapLogin()
    func didTapCreateAccount()
}

protocol ContinueWithEmailViewProtocol: UIView {
    var delegate: ContinueWithEmailViewDelegate? { get set }
    func showScreen(viewModel: ContinueWithEmail.Model.ViewModel)
    func clear(_ textFieldType: ContinueWithEmailTextFieldType)
    func changeVisibilityImageTextField(isVisible: Bool, _ textFieldType: ContinueWithEmailTextFieldType)
}

final class ContinueWithEmailView: UIView, ContinueWithEmailViewProtocol {
    var delegate: ContinueWithEmailViewDelegate?
    private var buttonBottomConstraint: Constraint?
    
    lazy var header: Header = {
        // TODO: Refactor header component
        let viewModel = HeaderViewModel(leftIcon: Images.arrowLeft,
                                        leftIconAccessibility: ContinueWithEmailKeys.headerButtonAcessibility.string(),
                                        title: ContinueWithEmailKeys.headerTitle.string(),
                                        background: Colors.Primary.Base.white,
                                        hasBottomLine: true)
        let header = Header(viewModel: viewModel)
        return header
    }()
    
    lazy var emailTextField: TextField = {
        let textField = TextField()
        return textField
    }()
    
    lazy var passwordTextField: TextField = {
        let textField = TextField()
        return textField
    }()
    
    lazy var forgotPasswordLabel: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleTapForgotPassword), for: .touchUpInside)
        return button
    }()
    
    lazy var createAccountLabel: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleTapCreateAccount), for: .touchUpInside)
        return button
    }()
    
    lazy var buttoncontinue: Button = {
        // TODO: Refactor Button component
        let viewModel = ButtonViewModel(showIcon: true,
                                        iconTint: Colors.Primary.Blue.blue100,
                                        weigth: .large,
                                        type: .primary,
                                        isEnabled: true,
                                        title:  ContinueWithEmailKeys.next.string(),
                                        accessibilityLabel: ContinueWithEmailKeys.nextAccessibility.string())
        let button = Button(viewModel: viewModel)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = Colors.Primary.Base.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        header.delegate = self
        setupViewHierarchy()
        setupConstraints()
        setupEvents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            buttonBottomConstraint?.update(inset: keyboardHeight + 20)
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        buttonBottomConstraint?.update(inset: 40)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    private func setupEvents() {
        emailTextField.onChangeTextField = { value in
            self.delegate?.onChangeTextField(value, .email)
        }
        
        passwordTextField.onChangeTextField = { value in
            self.delegate?.onChangeTextField(value, .password)
        }
        
        emailTextField.didTapButtonIcon = {
            self.delegate?.didTapButtonTextField(.email)
        }

        passwordTextField.didTapButtonIcon = {
            self.delegate?.didTapButtonTextField(.password)
        }
        
        buttoncontinue.didTapButton = {
            self.delegate?.didTapLogin()
        }
    }
    
    @objc
    private func handleTapForgotPassword() {
        delegate?.didTapForgotPassword()
    }
    
    @objc
    private func handleTapCreateAccount() {
        delegate?.didTapCreateAccount()
    }
    
    func clear(_ textFieldType: ContinueWithEmailTextFieldType) {
        switch textFieldType {
        case .email:
            emailTextField.clearValue()
        case .password:
            passwordTextField.clearValue()
        }
    }
    
    func showScreen(viewModel: ContinueWithEmail.Model.ViewModel) {
        emailTextField.viewModel = viewModel.emailTextField
        passwordTextField.viewModel = viewModel.passwordTextField
        forgotPasswordLabel.setAttributedTitle(viewModel.forgotPasswordTitle, for: .normal)
        forgotPasswordLabel.setTitleColor(viewModel.forgotPasswordTitleColor, for: .normal)
        createAccountLabel.setAttributedTitle(viewModel.createAccountTitle, for: .normal)
        createAccountLabel.setTitleColor(viewModel.createAccountTitleColor, for: .normal)
    }
    
    func changeVisibilityImageTextField(isVisible: Bool, _ textFieldType: ContinueWithEmailTextFieldType) {
        switch textFieldType {
        case .email:
            emailTextField.changeVisibilityImage(isHidden: !isVisible)
        case .password:
            passwordTextField.changeVisibilityImage(isHidden: !isVisible)
        }
    }
    
    private func setupViewHierarchy() {
        addSubview(header)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(forgotPasswordLabel)
        addSubview(createAccountLabel)
        addSubview(buttoncontinue)
    }
    
    private func setupConstraints() {
        header.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(72)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(72)
        }
        
        forgotPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).inset(-16)
            $0.leading.equalToSuperview().inset(24)
        }
        
        createAccountLabel.snp.makeConstraints {
            $0.bottom.equalTo(buttoncontinue.snp.top).inset(-24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        buttoncontinue.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
            buttonBottomConstraint = $0.bottom.equalToSuperview().inset(40).constraint
        }
    }
}

extension ContinueWithEmailView: HeaderDelegate {
    func handleTapLeftButton() {
        delegate?.didTapLeftIcon()
    }
    
    func handleTapRightButton() {}
}
