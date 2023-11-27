//
//  
//  HelpAndSupportVC.swift
//  travioapp
//
//  Created by Büşra Erim on 26.11.2023.
//
//

import UIKit
import TinyConstraints

class HelpAndSupportVC: UIViewController {
    
    
    var dataSource = CellDataModel.mockedData

    
    private lazy var backView:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        return backView
    }()
    
    private lazy var lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.text = "Help&Support"
        lbl.font = CustomFont.header2.font
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var lblFAQ:UILabel = {
        let lbl = UILabel()
        lbl.text = "FAQ"
        lbl.textColor = .background
        lbl.font = CustomFont.subHeader1.font
        return lbl
    }()
    

    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(ExpandableTableViewCell.self, forCellReuseIdentifier: ExpandableTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
        setupViews()
    }

    func setupViews() {
        self.view.addSubviews(backView)
        backView.addSubviews(tableView)
        tableView.addSubviews(lblFAQ)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let leftButtonImage = UIImage(named:"backWard")
        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor(hex: "FFFFFF")
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.titleView = lblTitle
        setupLayout()
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupLayout() {
        backView.edgesToSuperview(excluding: .top)
        backView.heightToSuperview(multiplier: 0.82)
        backView.layoutIfNeeded()
        backView.roundCorners(corners: .topLeft, radius: 80)
        
        lblFAQ.leadingToSuperview(offset: 24)
        lblFAQ.topToSuperview(offset: 40)
        lblFAQ.trailingToSuperview(offset: 12)
        
        tableView.topToSuperview()
        tableView.leadingToSuperview()
        tableView.trailingToSuperview()
        tableView.bottomToSuperview(offset:-10)
    }
  
}

extension HelpAndSupportVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableTableViewCell.reuseIdentifier, for: indexPath) as? ExpandableTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.set(dataSource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.lblFAQ
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

}

extension HelpAndSupportVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HelpAndSupportVC_Preview: PreviewProvider {
    static var previews: some View{
         
        HelpAndSupportVC().showPreview()
    }
}
#endif
