//
//  CellDataModel.swift
//  travioapp
//
//  Created by Büşra Erim on 26.11.2023.
//

import Foundation


struct CellDataModel {
    let title: String
    let subTitle: String
    var isExpanded = false
    
    static let mockedData: [CellDataModel] = [
        CellDataModel(title: "How can I create a new account on Travio?", subTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
        CellDataModel(title: "How does Travio work?", subTitle: "Lorem Ipsuksmfkdlsmf sdlkfmsdlkfmsdkf sflksdmflksdmf lfkmsdlkfmsd fsdflkmsdflkdsmfklsmf sdlkfmsdlkfm m is simply dummy text of the printing and typesetting industry."),
        CellDataModel(title: "How does Travio work?", subTitle: " Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
        CellDataModel(title: "How does Travio work?", subTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
        CellDataModel(title: "How does Travio work?", subTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
        CellDataModel(title: "How does Travio work?", subTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
        CellDataModel(title: "How does Travio work?", subTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")]
    
}

