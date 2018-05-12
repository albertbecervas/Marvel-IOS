import Foundation
import Alamofire
import CommonCrypto
import SwiftyJSON

enum ErrorTypes {
    case noInternetConnection
    case serverError
    case unexpected
    case cantNotConvertToJson
}

class ApiManager {
    
    static let sharedApiManager: ApiManager = {
        let apiManager = ApiManager()
        return apiManager
    }()
    
    let privateKey = "5d5d27cea75b3d274f36f0eb37a4028aa1a16918"
    let publicKey = "18a05e186f19983f7c7b493437f782ab"
    let baseURL = "https://gateway.marvel.com/v1/public/"
    
    init() {
        
    }
    
    func getHeroesJSON( success:@escaping (_ result: JSON) -> Void, error:@escaping (_ errorCode: ErrorTypes) -> Void ) {
        
        var json: JSON?
        
        Alamofire.request(getUrlAllCharacters(), method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    json = JSON(value)
                    if let json = json {
                        success(json)
                    }else {
                        error(.cantNotConvertToJson)
                    }
                } else {
                    error(.unexpected)
                }
                
            case .failure(let alError):
                if alError._code == NSURLErrorNotConnectedToInternet {
                    error(.noInternetConnection)
                } else {
                    error(.unexpected)
                }
            }
            
        }
        
    }
    
    
    private func getUrlAllCharacters() -> String {
        let ts = String(Int(Date().timeIntervalSince1970))
        
        let hash = hashGenerator(ts: ts)
        
        let fullUrl = baseURL + "characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        return fullUrl
    }
    
    func getPaginateHeroesJSON(offset: Int, limit: Int , success:@escaping (_ result: JSON) -> Void, error:@escaping (_ errorCode: ErrorTypes) -> Void ) {
        
        var json: JSON?
        
        Alamofire.request(getUrlPaginateAllCharacters(offset: offset, limit: limit ), method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    json = JSON(value)
                    if let json = json {
                        success(json)
                    }else {
                        error(.cantNotConvertToJson)
                    }
                } else {
                    error(.unexpected)
                }
                
            case .failure(let alError):
                if alError._code == NSURLErrorNotConnectedToInternet {
                    error(.noInternetConnection)
                } else {
                    error(.unexpected)
                }
            }
            
        }
        
    }
    
    
    private func getUrlPaginateAllCharacters(offset: Int, limit: Int) -> String {
        let ts = String(Int(Date().timeIntervalSince1970))
        
        let hash = hashGenerator(ts: ts)
        
        let fullUrl = baseURL + "characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&offset=\(offset)&limit=\(limit)"
        print(fullUrl)
        return fullUrl
    }
    
    func getPaginateAndFilteredHeroesJSON(offset: Int, limit: Int, filterName: String , success:@escaping (_ result: JSON) -> Void, error:@escaping (_ errorCode: ErrorTypes) -> Void ) {
        
        var json: JSON?
        
        Alamofire.request(getUrlPaginateAndFilteredAllCharacters(offset: offset, limit: limit, filterName: filterName ), method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    json = JSON(value)
                    if let json = json {
                        success(json)
                    }else {
                        error(.cantNotConvertToJson)
                    }
                } else {
                    error(.unexpected)
                }
                
            case .failure(let alError):
                if alError._code == NSURLErrorNotConnectedToInternet {
                    error(.noInternetConnection)
                } else {
                    error(.unexpected)
                }
            }
            
        }
        
    }
    
    
    private func getUrlPaginateAndFilteredAllCharacters(offset: Int, limit: Int, filterName: String) -> String {
        let ts = String(Int(Date().timeIntervalSince1970))
        
        let hash = hashGenerator(ts: ts)
        
        var fullUrl = ""
        
        if offset == 0 {
            fullUrl = baseURL + "characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&limit=\(limit)&nameStartsWith=\(filterName)"
        } else {
            fullUrl = baseURL + "characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&offset=\(offset)&limit=\(limit)&nameStartsWith=\(filterName)"
        }
        
        
        return fullUrl
    }
    
    func getHeroJSON(heroId: String, success:@escaping (_ result: JSON) -> Void, error:@escaping (_ errorCode: ErrorTypes) -> Void ) {
        
        var json: JSON?
        
        Alamofire.request(getUrlHero(heroId: heroId), method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    json = JSON(value)
                    if let json = json {
                        success(json)
                    }else {
                        error(.cantNotConvertToJson)
                    }
                } else {
                    error(.unexpected)
                }
                
            case .failure(let alError):
                if alError._code == NSURLErrorNotConnectedToInternet {
                    error(.noInternetConnection)
                } else {
                    error(.unexpected)
                }
            }
            
        }
        
    }
    
    
    private func getUrlHero(heroId: String) -> String {
        let ts = String(Int(Date().timeIntervalSince1970))
        
        let hash = hashGenerator(ts: ts)
        
        let fullUrl = baseURL + "characters/\(heroId)?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        return fullUrl
    }
    
    
    
    
    func getComicsByHeroJSON(heroId: String, success:@escaping (_ result: JSON) -> Void, error:@escaping (_ errorCode: ErrorTypes) -> Void ) {
        
        var json: JSON?
        
        Alamofire.request(getUrlComicsByHero(heroId: heroId), method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    json = JSON(value)
                    if let json = json {
                        success(json)
                    }else {
                        error(.cantNotConvertToJson)
                    }
                } else {
                    error(.unexpected)
                }
                
            case .failure(let alError):
                if alError._code == NSURLErrorNotConnectedToInternet {
                    error(.noInternetConnection)
                } else {
                    error(.unexpected)
                }
            }
            
        }
        
    }
    
    
    
    
    private func getUrlComicsByHero(heroId: String) -> String {
        let ts = String(Int(Date().timeIntervalSince1970))
        
        let hash = hashGenerator(ts: ts)
        
        let fullUrl = baseURL + "characters/\(heroId)/comics?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        return fullUrl
    }
    
    func getEventsByHeroJSON(heroId: String, success:@escaping (_ result: JSON) -> Void, error:@escaping (_ errorCode: ErrorTypes) -> Void ) {
        
        var json: JSON?
        
        Alamofire.request(getUrlEventsByHero(heroId: heroId), method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    json = JSON(value)
                    if let json = json {
                        success(json)
                    }else {
                        error(.cantNotConvertToJson)
                    }
                } else {
                    error(.unexpected)
                }
                
            case .failure(let alError):
                if alError._code == NSURLErrorNotConnectedToInternet {
                    error(.noInternetConnection)
                } else {
                    error(.unexpected)
                }
            }
            
        }
        
    }
    
    
    private func getUrlEventsByHero(heroId: String) -> String {
        let ts = String(Int(Date().timeIntervalSince1970))
        
        let hash = hashGenerator(ts: ts)
        
        let fullUrl = baseURL + "characters/\(heroId)/events?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        return fullUrl
    }
    
    private func hashGenerator(ts: String) -> String {
        
        let hashString = ts + privateKey + publicKey
        
        let md5Data = MD5(string: hashString)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        
        return md5Hex
    }
    
    
    
    func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
    
    
    
}


