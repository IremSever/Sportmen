//
//  Explore.swift
//  Sportmen
//
//  Created by İrem Sever on 3.03.2024.
//

import Foundation
// MARK: - Explore
struct Explore: Codable {
    let meta: ExploreMeta
    let data: [ExploreDataClass]
}

// MARK: - ExploreDataClass
struct ExploreDataClass: Codable {
    let id, reportID: Int?
    let reportUniqueID, title, spot: String?
    let url: String?
    let publishedDate, modifiedDate: String?
    let image: String?
    let category: ExploreCategory?
    let altCategory: ExploreCategory?
    let keywordList: [ExploreCategory]?
    let source: ExploreSource?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case reportID = "ReportId"
        case reportUniqueID = "ReportUniqueId"
        case title = "Title"
        case spot = "Spot"
        case url = "Url"
        case publishedDate = "PublishedDate"
        case modifiedDate = "ModifiedDate"
        case image = "Image"
        case category = "Category"
        case altCategory = "AltCategory"
        case keywordList = "KeywordList"
        case source = "Source"
    }
}

// MARK: - Category
struct ExploreCategory: Codable {
    let name, key: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case key = "Key"
    }
}

// MARK: - Source
struct ExploreSource: Codable {
    let name: Name
    let domain: Domain
    let id: Int
    let shortName: ShortName
    let favicon: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case domain = "Domain"
        case id = "Id"
        case shortName = "ShortName"
        case favicon = "Favicon"
    }
}

enum ExploreDomain: String, Codable {
    case asporCOMTr = "aspor.com.tr"
    case fanatikCOMTr = "fanatik.com.tr"
    case fotomacCOMTr = "fotomac.com.tr"
    case haberturkCOM = "haberturk.com"
    case hurriyetCOMTr = "hurriyet.com.tr"
    case milliyetCOMTr = "milliyet.com.tr"
    case ntvsporNet = "ntvspor.net"
    case sabahCOMTr = "sabah.com.tr"
    case sporxCOM = "sporx.com"
    case takvimCOMTr = "takvim.com.tr"
    case trtsporCOMTr = "trtspor.com.tr"
    case yenisafakCOM = "yenisafak.com"
}

enum ExploreName: String, Codable {
    case aSpor = "ASpor"
    case fanatik = "Fanatik"
    case fotomaç = "Fotomaç"
    case htSpor = "HT Spor"
    case ntvSpor = "NTV Spor"
    case sabahSpor = "Sabah Spor"
    case skorer = "Skorer"
    case sporArena = "Spor Arena"
    case sporX = "SporX"
    case takvimSpor = "Takvim Spor"
    case trtSpor = "TRT Spor"
    case yeniŞafakSpor = "Yeni Şafak Spor"
}

enum ExploreShortName: String, Codable {
    case aspr = "ASPR"
    case fntk = "FNTK"
    case ftm = "FTM"
    case ht = "HT"
    case hür = "HÜR"
    case mi̇l = "MİL"
    case ntvs = "NTVS"
    case sbh = "SBH"
    case sprx = "SPRX"
    case tkv = "TKV"
    case trtspr = "TRTSPR"
    case ysfk = "YSFK"
}

// MARK: - Meta
struct ExploreMeta: Codable {
    let statusCode: Int
    let message, description, brand: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand
    }
}

