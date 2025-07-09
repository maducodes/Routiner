import UIKit
import SnapKit
import Foundation

protocol OnboardingViewProtocol: OnboardingView {
    func setupView(viewModel: Onboarding.Model.ViewModel,
                   collectionViewDelegate: UICollectionViewDelegate,
                   collectionViewDataSource: UICollectionViewDataSource)
    func changeCurrentPage(newCurrentPage: Int)
}

protocol OnboardingViewDelegate {
    func didTapPageControl()
    func didTapContinue(type: LoginType)
}

final class OnboardingView: UIView, OnboardingViewProtocol {
    var delegate: OnboardingViewDelegate?
    
    private lazy var itemsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 500)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = Colors.Primary.Base.white
        pageControl.pageIndicatorTintColor = Colors.Primary.Blue.blue60
        pageControl.contentHorizontalAlignment = .left
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = Images.background
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var continueButton: Button = {
        let viewModel = ButtonViewModel(showIcon: true,
                                        icon: Images.login,
                                        weigth: .large,
                                        type: .secondary,
                                        isEnabled: true,
                                        title: OnboardingKeys.loginButtonName.string(OnboardingKeys.email.string()),
                                        accessibilityLabel: OnboardingKeys.loginAccessibilityButtonName.string(OnboardingKeys.email.string()))
        let button = Button(viewModel: viewModel)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var appleButton: Button = {
        let viewModel = ButtonViewModel(showIcon: true,
                                        icon: Images.apple,
                                        weigth: .large,
                                        type: .secondary,
                                        isEnabled: true,
                                        title: OnboardingKeys.apple.string(),
                                        accessibilityLabel: OnboardingKeys.loginAccessibilityButtonName.string(OnboardingKeys.apple.string()))
        let button = Button(viewModel: viewModel)
        return button
    }()
    
    private lazy var googleButton: Button = {
        let viewModel = ButtonViewModel(showIcon: true,
                                        icon: Images.google,
                                        weigth: .large,
                                        type: .secondary,
                                        isEnabled: true,
                                        title: OnboardingKeys.google.string(),
                                        accessibilityLabel: OnboardingKeys.loginAccessibilityButtonName.string(OnboardingKeys.google.string()))
        let button = Button(viewModel: viewModel)
        return button
    }()
    
    private lazy var facebookButton: Button = {
        let viewModel = ButtonViewModel(showIcon: true,
                                        icon: Images.facebook,
                                        weigth: .large,
                                        type: .secondary,
                                        isEnabled: true,
                                        title: OnboardingKeys.facebook.string(),
                                        accessibilityLabel: OnboardingKeys.loginAccessibilityButtonName.string(OnboardingKeys.facebook.string()))
        let button = Button(viewModel: viewModel)
        return button
    }()
    
    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.text = OnboardingKeys.termsTitle.string()
        label.textColor = Colors.Primary.Blue.blue40
        label.font = Typography.setTypography(using: .alternative)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(viewModel: Onboarding.Model.ViewModel,
                   collectionViewDelegate: UICollectionViewDelegate,
                   collectionViewDataSource: UICollectionViewDataSource) {
        itemsCollectionView.delegate = collectionViewDelegate
        itemsCollectionView.dataSource = collectionViewDataSource
        itemsCollectionView.register(OnboardingItemCell.self,
                                     forCellWithReuseIdentifier: OnboardingItemCell.identifier)
        
        itemsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")

        pageControl.currentPage = viewModel.currentPage
        pageControl.numberOfPages = viewModel.numberOfPages
        pageControl.accessibilityLabel = OnboardingKeys.pageAccessibility.string("\(viewModel.currentPage+1)", "\(viewModel.numberOfPages)")
    }
    
    func changeCurrentPage(newCurrentPage: Int) {
        pageControl.currentPage = newCurrentPage

        let indexPath = IndexPath(item: newCurrentPage, section: 0)
        itemsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setupUI() {
        backgroundColor = Colors.Primary.Blue.blue100
        setupViewHierarchy()
        setupConstraints()
        setupEvents()
    }
    
    func setupEvents() {
        googleButton.button.addTarget(self, action: #selector(handleTapGoogle), for: .touchUpInside)
        facebookButton.button.addTarget(self, action: #selector(handleTapFacebook), for: .touchUpInside)
        appleButton.button.addTarget(self, action: #selector(handleTapApple), for: .touchUpInside)
        continueButton.button.addTarget(self, action: #selector(handleTapEmail), for: .touchUpInside)
    }
    
    @objc
    private func handleTapGoogle() {
        delegate?.didTapContinue(type: .google)
    }
    
    @objc
    private func handleTapFacebook() {
        delegate?.didTapContinue(type: .facebook)
    }
    
    @objc
    private func handleTapApple() {
        delegate?.didTapContinue(type: .apple)
    }
    
    @objc
    private func handleTapEmail() {
        delegate?.didTapContinue(type: .email)
    }
    
    private func setupViewHierarchy() {
        addSubview(backgroundImage)
        addSubview(itemsCollectionView)
        addSubview(pageControl)
        addSubview(continueButton)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(appleButton)
        buttonStackView.addArrangedSubview(googleButton)
        buttonStackView.addArrangedSubview(facebookButton)
        addSubview(termsLabel)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        itemsCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(pageControl.snp.top)
        }
        
        pageControl.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(continueButton.snp.top).inset(-48)
        }
        
        continueButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
            $0.bottom.equalTo(buttonStackView.snp.top).inset(-12)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(termsLabel.snp.top).offset(-12)
        }
        
        termsLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
    }
}
