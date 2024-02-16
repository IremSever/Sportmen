//
//  News.swift
//  Sportmen
//
//  Created by IREM SEVER on 9.02.2024.
//
import Foundation

 // MARK: - News
 struct News: Codable {
     let meta: NewsMeta
     let data: [Datum]
 }

 // MARK: - Datum
 struct Datum: Codable {
     let id, reportID: Int?
     let reportUniqueID, title, spot: String?
     let url: String?
     let publishedDate, modifiedDate: String?
     let image: String?
     let category: Category?
     let altCategory: Category?
     let keywordList: [Category]?
     let source: Source?

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
 struct Category: Codable {
     let name, key: String

     enum CodingKeys: String, CodingKey {
         case name = "Name"
         case key = "Key"
     }
 }

 // MARK: - Source
 struct Source: Codable {
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

 enum Domain: String, Codable {
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

 enum Name: String, Codable {
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

 enum ShortName: String, Codable {
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
 struct NewsMeta: Codable {
     let statusCode: Int
     let message, description, brand: String

     enum CodingKeys: String, CodingKey {
         case statusCode = "status_code"
         case message, description, brand
     }
 }

