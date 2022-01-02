//
//  APIResponseModel.swift
//  URL-Shortener
//
//  Created by Dmitriy Maslennikov on 02/01/2022.
//  Copyright © 2022 Dmitriy Maslennikov. All rights reserved.
//

import Foundation

struct APIResponse: Codable {
    let url: APIResponseURL
}

struct APIResponseURL: Codable {
    let status: Int
    let fullLink: String
    let date: String
    let shortLink: String
    let title: String
}
