//
//  MyVisitsTableView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 27.10.2023.
//

import UIKit


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MyVisitsTableView_Preview: PreviewProvider {
    static var previews: some View{
         
        MyVisitsTableView().showPreview()
    }
}
#endif

class MyVisitsTableView: UIViewController {

    var places:[MyVisits] = [
        MyVisits(place: "İstanbul", title: "Süleymaniye", imageUrl: "suleymaniye"),
        MyVisits(place: "Rome", title: "Colleseum", imageUrl: "colleseum")]
    
    private lazy var lblTitle:UILabel = {
        var view = UILabel()
        view.textColor = .white
        view.font = UIFont(name: "Poppins-SemiBold", size: 36)
        view.text = "My Visits"
        return view
    }()
    
    private lazy var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(MyVisitsCell.self, forCellReuseIdentifier: "visitCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .background
        self.view.addSubviews(lblTitle, backgroundView)
        backgroundView.addSubview(tableView)
        
        setupLayout()
    }

    private func setupLayout(){
        tableView.edgesToSuperview(usingSafeArea: true)
        tableView.leadingToSuperview(offset:24)
        tableView.topToSuperview(offset:20)
     
        backgroundView.edgesToSuperview(excluding: .top)
        backgroundView.topToSuperview(offset: 128)
        backgroundView.layoutIfNeeded()
        backgroundView.roundCorners(corners: .topLeft, radius: 80)
        
        lblTitle.topToSuperview(offset:46)
        lblTitle.leadingToSuperview(offset:24)
    }
    
}

extension MyVisitsTableView:UITableViewDelegate {
    
    // cell seçildikten sonra?????
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension MyVisitsTableView:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "visitCell", for: indexPath) as! MyVisitsCell
        let object = places[indexPath.row]
        cell.configure(object: object)
        return cell
    }
    
    
}
