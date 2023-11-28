//
//  ExpandableTableViewCell.swift
//  travioapp
//
//  Created by Büşra Erim on 26.11.2023.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {


    static let reuseIdentifier = "ExpandableTableViewCell"

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 12, bottom: 15, trailing: 18)
        stackView.layer.cornerRadius = 16
        stackView.backgroundColor = .white
        stackView.layer.shadowRadius = 20
        stackView.layer.shadowOpacity = 0.12
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.masksToBounds = false
        return stackView
    }()

    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }()

    let labelQuestion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = CustomFont.subHeader3.font
        label.textColor = .black
        label.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .background
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let expandableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = .white
        return view
    }()

    let labelanswer: UILabel = {
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
        contentView.addSubview(stackView)
        contentView.backgroundColor = .contentcolor
//        backView.addSubview(stackView)
        stackView.addArrangedSubviews(mainStackView, expandableView)
        mainStackView.addArrangedSubviews(labelQuestion,chevronImageView)
        expandableView.addSubview(labelanswer)
        setConstraints()
    }

    func setConstraints() {
        stackView.top(to: contentView, offset:16)
        stackView.bottom(to: contentView)
        stackView.leading(to: contentView, offset:24)
        stackView.trailing(to: contentView, offset:-24)
        
        chevronImageView.size(CGSize(width: 18, height: 18))
        
        labelanswer.edges(to: expandableView, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))

    }

    func set(_ model: CellDataModel) {
        labelQuestion.text = model.title
        labelanswer.text = model.subTitle
        expandableView.isHidden = !model.isExpanded
        chevronImageView.image = (model.isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"))?.withRenderingMode(.alwaysTemplate)
    }
}


