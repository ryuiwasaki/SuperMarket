//
//  SuperMarket.swift
//  Pods
//
//  Created by Ryu Iwasaki on 2016/05/21.
//
//

import Foundation

public func findAppWithTerms(_ terms:[String]?, bundleId:String?, appId:String?, country:String?, offset:Int = 0, limit:Int = 0, progress:((Double) -> Void)?, completion:((Result) -> Void)?) {
    
    Store.defaultStore().findAppWithTerms(terms, bundleId:bundleId, appId:appId, country: country, offset: offset, limit: limit, progress: progress, completion: completion)
}

public func findAppWithName(_ name:String?, developer:String?, country:String?, offset:Int = 0, limit:Int = 0, progress:((Double) -> Void)?, completion:((Result) -> Void)?) {
    
    Store.defaultStore().findAppWithName(name, developer: developer, country: country, offset: offset, limit: limit, progress: progress, completion: completion)
}

public func findMusicWithTerms(_ terms:[String]?, country:String?, offset:Int = 0, limit:Int = 0, progress:((Double) -> Void)?, completion:((Result) -> Void)?) {
    
    Store.defaultStore().findMusicWithTerms(terms, country: country, offset: offset, limit: limit, progress: progress, completion: completion)
}
