//
//  Constants.swift
//  desafio
//
//  Created by Andre Dias on 16/07/23.
//
import Foundation

struct Constants {
    // MARK: API
    static let schema = "https"
    static let baseURL = "gateway.marvel.com"
    static let marvelComicsPath = "/v1/public/comics"
    static let method = "GET"
    
    
    //MARK: Errors
    static let invalidURL = NSLocalizedString("invalid_URL", comment: "")
    static let decodeError = NSLocalizedString("decode_Error", comment: "")
    static let noInternet = NSLocalizedString("no_Internet", comment: "")
    static let unexpectedError = NSLocalizedString("unexpected_Error", comment: "")
    
    // MARK: App Strings
    static let homeTitle = NSLocalizedString("home_Title", comment: "")
    static let errorViewTitle = NSLocalizedString("error_View_Title", comment: "")
    static let errorViewBtntitle = NSLocalizedString("error_View_Btn_title", comment: "")
}
