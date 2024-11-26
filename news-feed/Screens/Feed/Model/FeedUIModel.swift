//
//  FeedUIModel.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/25/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//
import Foundation
 
struct FeedUIModel:Hashable {
    let id:Int
    let title:String
    let description:String
    let imageUrl:URL
}
