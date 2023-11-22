
import UIKit
import SnapKit
import TinyConstraints
import Kingfisher

class CustomCollectionCell: UICollectionViewCell {
    
    public lazy var placeView:UIView = {
        let view = UIView()
//        view.backgroundColor = .black
        return view
    }()
    
    private lazy var icon:UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Vector")
        return icon
    }()
    
    public lazy var image:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
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
    
    private lazy var gradient:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Rectangle 12")
        return iv
    }()
    
    func configure(object: PlaceItem) {
        let url = URL(string: object.coverImageUrl)
        image.kf.setImage(with: url)
//        image.image = UIImage(named: object.cover_image_url)
        lblPlace.text = object.place
        lblVisitLocation.text = object.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        self.contentView.addSubview(placeView)
        placeView.addSubviews(image,lblPlace,lblVisitLocation)
        image.addSubviews(gradient)
        image.addSubview(icon)
        setupLayout()
    }
    
    private func setupLayout(){        
        self.contentView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        self.contentView.layer.shadowRadius = 20
        self.contentView.layer.shadowOpacity = 0.20

        placeView.edgesToSuperview()
        image.edges(to: placeView)
        gradient.bottomToSuperview()
        gradient.leadingToSuperview()
        gradient.trailingToSuperview()
        lblVisitLocation.leading(to: placeView, offset: 16)
        lblVisitLocation.bottom(to: placeView, offset: -26)
        lblPlace.bottom(to: placeView, offset: -5)
        lblPlace.leading(to: placeView, offset: 31)
        icon.leading(to: placeView, offset: 16)
        icon.bottom(to: placeView, offset: -11)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
