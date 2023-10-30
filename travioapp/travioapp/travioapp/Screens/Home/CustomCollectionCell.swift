
import UIKit
import SnapKit
import TinyConstraints

class CustomCollectionCell: UICollectionViewCell {
    
    
    private lazy var image:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "travio-logo 1")
        return image
    }()
    
    private lazy var image2:UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "travio")
       return image
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        self.contentView.addSubview(image)

        //aşağıdaki kod çizgi çekmek için
        let separatorView = UIView()
        separatorView.backgroundColor = .gray
        self.contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        image.leadingToSuperview(offset:50)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
