
import UIKit
import SnapKit
import TinyConstraints

class CustomCollectionCell: UICollectionViewCell {
    
    private lazy var item:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var image:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private lazy var lblVisitLocation:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 24)
        return lbl
    }()
    
    private lazy var lblPlace:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-Light", size: 16)
        return lbl
    }()
    
    func configure(object: HomePlaces) {
        image.image = UIImage(named: object.imageUrl!)
        lblPlace.text = object.place
        lblVisitLocation.text = object.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        self.contentView.addSubviews(image, lblPlace, lblVisitLocation)
        image.addSubview(item)
        
        //seeall aşağıdaki gibi dene
//        //aşağıdaki kod çizgi çekmek için
//        let separatorView = UIView()
//        separatorView.backgroundColor = .gray
//        self.contentView.addSubview(separatorView)
//        separatorView.snp.makeConstraints { (make) in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(1)
//        }
        setupLayout()
    }
    
    private func setupLayout(){
                
        image.frame = CGRect(x: 0, y: 0, width: 280, height: 178)
        
        lblVisitLocation.frame = CGRect(x: 16, y: 120, width: 280, height: 30)
        
        lblPlace.frame = CGRect(x: 31, y: 150, width: 280, height: 21)
        
        item.frame = CGRect(x: 16, y: 153, width: 9, height: 12)
        item.image = .locationItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
