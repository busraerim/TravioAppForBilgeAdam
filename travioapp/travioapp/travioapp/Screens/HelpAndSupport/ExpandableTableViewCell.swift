//
//  ExpandableTableViewCell.swift
//  travioapp
//
//  Created by Büşra Erim on 26.11.2023.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {


    static let reuseIdentifier = "ExpandableTableViewCell"
    
    private lazy var backView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        return stackView
    }()

    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = #colorLiteral(red: 0.1404079861, green: 0.1404079861, blue: 0.1404079861, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = CustomFont.title1.font
        label.textColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
        label.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let expandableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        return view
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = CustomFont.subTitle4.font
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        contentView.addSubview(backView)
        contentView.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        backView.addSubview(stackView)
        stackView.addArrangedSubview(mainStackView)
        stackView.addArrangedSubview(expandableView)
        mainStackView.addArrangedSubview(iconImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(chevronImageView)
        expandableView.addSubview(descriptionLabel)
        setConstraints()
    }

    func setConstraints() {
        backView.top(to: contentView, offset:10)
        backView.bottom(to: contentView)
        backView.leading(to: contentView, offset:16)
        backView.trailing(to: contentView, offset:-15)
        
        stackView.edgesToSuperview()
        chevronImageView.size(CGSize(width: 18, height: 18))
        titleLabel.topToSuperview(offset:8)
        titleLabel.bottomToSuperview(offset:-8)
        titleLabel.leadingToSuperview(offset:12)
        titleLabel.trailingToLeading(of: chevronImageView, offset:12)
     
        descriptionLabel.edges(to: expandableView, insets: UIEdgeInsets(top: 8, left: 0, bottom: 10, right: -16))

    }

    func set(_ model: CellDataModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.subTitle
        expandableView.isHidden = !model.isExpanded
        chevronImageView.image = (model.isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"))?.withRenderingMode(.alwaysTemplate)
    }
}


