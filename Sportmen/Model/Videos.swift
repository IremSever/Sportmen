//
//  Videos.swift
//  Sportmen
//
//  Created by IREM SEVER on 15.02.2024.
//

import Foundation
// MARK: - Videos
struct Videos: Codable {
    let meta: VideosMeta
    let data: VideosDataClass
}
// MARK: - VideoDataClass
struct VideosDataClass: Codable {
    let list: VideoList
}
// MARK: - VideoList
struct VideoList: Codable {
    let response: [VideoResponse]
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case status = "Status"
    }
}
// MARK: - Response
struct VideoResponse: Codable {
    let channelImages: ChannelImages?
    let channelTitle: ChannelTitle?
    let description: String?
    let images: Images?
    let playlists: [Playlist]?
    let publishDate: Date?
    let title: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case channelImages = "ChannelImages"
        case channelTitle = "ChannelTitle"
        case description = "Description"
        case images = "Images"
        case playlists = "Playlists"
        case publishDate = "PublishDate"
        case title = "Title"
        case url = "Url"
    }
}
// MARK: - ChannelImages
struct ChannelImages: Codable {
    let channelImagesDefault, high, medium: String

    enum CodingKeys: String, CodingKey {
        case channelImagesDefault = "default"
        case high, medium
    }
}
enum ChannelTitle: String, Codable {
    case futbolPlus = "FUTBOL PLUS"
}
// MARK: - Images
struct Images: Codable {
    let imagesDefault, high, maxres, medium: String
    let standard: String

    enum CodingKeys: String, CodingKey {
        case imagesDefault = "default"
        case high, maxres, medium, standard
    }
}
// MARK: - Playlist
struct Playlist: Codable {
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
    }
}
// MARK: - Meta
struct VideosMeta: Codable {
    let statusCode: Int
    let message, description, brand: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand
    }
}
