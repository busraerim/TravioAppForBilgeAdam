//
//  HelpSupportVC.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 9.11.2023.
//

import UIKit
import SnapKit

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HelpSupportVC_Preview: PreviewProvider {
    static var previews: some View{
         
        HelpSupportVC().showPreview()
    }
}
#endif


class HelpSupportVC: UIViewController {
    
    var cellModelArray = HelpSupportData.cellModelArray
    
    private var selectedIndexPath:IndexPath?
    private var isExpanded:Bool = false
    
    private lazy var collapsed:CGFloat = 70
    private lazy var expanded:CGFloat = 110

    private lazy var mainView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        view.clipsToBounds = true
        view.backgroundColor = .contentcolor
        return view
    }()
    
    private lazy var lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.text = "Help&Support"
        lbl.font = CustomFont.header2.font
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var backButton:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        btn.setImage(.backWard, for: .normal)
        return btn
    }()
    
    private lazy var lblFAQ:UILabel = {
        let lbl = UILabel()
        lbl.text = "FAQ"
        lbl.textColor = .background
        lbl.font = CustomFont.subHeader1.font
        return lbl
    }()
    
    private lazy var collectionView:UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.register(HelpSupportCell.self, forCellWithReuseIdentifier: HelpSupportCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
        
    }()
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .background
        self.view.addSubviews(mainView, backButton, lblTitle)
        mainView.addSubviews(lblFAQ, collectionView)
        navigationController?.navigationBar.isTranslucent = true
        let backButtonBar = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonBar
        self.navigationItem.titleView = lblTitle

        setupLayout()
    }
    
    private func setupLayout(){

        mainView.snp.makeConstraints({ make in
            make.height.equalToSuperview().multipliedBy(0.82)
            make.leading.trailing.bottom.equalToSuperview()
        })
        
        lblFAQ.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(45)
        })
        
        collectionView.snp.makeConstraints({ make in
            make.top.equalTo(lblFAQ.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        })
        
    }

}

extension HelpSupportVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectedIndexPath = (selectedIndexPath == indexPath) ? nil : indexPath
        collectionView.performBatchUpdates(nil, completion: nil)
    }
}

extension HelpSupportVC:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        isExpanded = selectedIndexPath == indexPath
        return CGSize(width: collectionView.bounds.width - 16, height: isExpanded ? expanded : collapsed)
             
    }
}

extension HelpSupportVC:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpSupportCell.identifier, for: indexPath) as! HelpSupportCell
        
        let data = cellModelArray[indexPath.item]
        cell.configure(data: data)
        
        return cell
    }
    
}
