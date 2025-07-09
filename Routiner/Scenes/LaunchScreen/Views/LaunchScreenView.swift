import UIKit
import SnapKit
import Foundation

protocol LaunchScreenViewProtocol: UIView {}

final class LaunchScreenView: UIView, LaunchScreenViewProtocol {
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: Images.background)
        return image
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: Images.logoWhite)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        addSubview(backgroundImage)
        addSubview(logoImage)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints {
            $0.width.equalTo(240)
            $0.centerX.equalTo(backgroundImage.snp.centerX)
            $0.centerY.equalTo(backgroundImage.snp.centerY)
        }
    }
}
