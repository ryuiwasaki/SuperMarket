//
//  Store.swift
//  TunesStore
//
//  Created by Ryu Iwasaki on 2016/05/19.
//  Copyright © 2016年 Ryu Iwasaki. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case Lookup, Search
    
    var URLString : String {
        
        switch self {
        case .Lookup :
            return "https://itunes.apple.com/lookup"
        case .Search :
            return "https://itunes.apple.com/search"
        }
    }
}

enum Entity : String {
    
    case
    AllArtist,
    AllTrack,
    MovieArtist,
    Movie,
    PodcastAuthor,
    Podcast,
    MusicArtist,
    MusicTrack,
    Album,
    MusicVideo,
    Mix,
    Song,
    AudiobookAuthor,
    Audiobook,
    ShortFilmArtist,
    ShortFilm,
    TvEpisode,
    TvSeason,
    Software,
    iPadSoftware,
    MacSoftware,
    Ebook
    
    var value : String {
        let value : String
        
        switch  self {
        case .AllArtist:
            value = "allArtist"
        case .AllTrack:
            value = "allTrack"
        case .MovieArtist:
            value = "movieArtist"
        case .Movie:
            value = "movie"
        case .PodcastAuthor:
            value = "podcastAuthor"
        case .Podcast:
            value = "podcast"
        case .MusicArtist:
            value = "musicArtist"
        case .MusicTrack:
            value = "musicTrack"
        case .Album:
            value = "album"
        case .MusicVideo:
            value = "musicVideo"
        case .Song:
            value = "song"
        case .Mix:
            value = "mix"
        case .AudiobookAuthor:
            value = "audiobookAuthor"
        case .Audiobook:
            value = "audiobook"
        case .ShortFilmArtist:
            value = "shortFilmArtist"
        case .ShortFilm:
            value = "shortFilm"
        case .TvEpisode:
            value = "tvEpisode"
        case .TvSeason:
            value = "tvSeason"
        case .Software:
            value = "software"
        case .iPadSoftware:
            value = "iPadSoftware"
        case .MacSoftware:
            value = "macSoftware"
        case .Ebook:
            value = "ebook"
        }
        
        return value
    }
}

enum MediaType : String {
    case
    All,
    Movie,
    Podcast,
    Music,
    MusicVideo,
    Audiobook,
    ShortFilm,
    TvShow,
    Software,
    Ebook
    
    var value : String {
        let value : String
        
        switch  self {
        case .All:
            value = ""
        case .Movie:
            value = "movie"
        case .Podcast:
            value = "podcast"
        case .Music:
            value = "music"
        case .MusicVideo:
            value = "musicVideo"
        case .Audiobook:
            value = "audiobook"
        case .ShortFilm:
            value = "shortFilm"
        case .TvShow:
            value = "tvShow"
        case .Software:
            value = "software"
        case .Ebook:
            value = "ebook"
        }
        
        return value
    }
}

enum MediaAttribute : String {
   
    case
    All,
    ActorTerm,
    LanguageTerm,
    AllArtistTerm,
    TvEpisodeTerm,
    ShortFilmTerm,
    DirectorTerm,
    ReleaseYearTerm,
    TitleTerm,
    FeatureFilmTerm,
    RatingIndex,
    KeywordsTerm,
    DescriptionTerm,
    AuthorTerm,
    GenreIndex,
    MixTerm,
    AllTrackTerm,
    ArtistTerm,
    ComposerTerm,
    TvSeasonTerm,
    ProducerTerm,
    RatingTerm,
    SongTerm,
    MovieArtistTerm,
    ShowTerm,
    MovieTerm,
    AlbumTerm
    
    var value : String {
        let value : String
        
        switch  self {
        case .All:
            value = ""
        case .ActorTerm:
            value = "actorTerm"
        case .LanguageTerm:
            value = "languageTerm"
        case .AllArtistTerm:
            value = "allArtistTerm"
        case .TvEpisodeTerm:
            value = "tvEpisodeTerm"
        case .ShortFilmTerm:
            value = "shortFilmTerm"
        case .DirectorTerm:
            value = "directorTerm"
        case .ReleaseYearTerm:
            value = "releaseYearTerm"
        case .TitleTerm:
            value = "titleTerm"
        case .FeatureFilmTerm:
            value = "featureFilmTerm"
        case .RatingIndex:
            value = "ratingIndex"
        case .KeywordsTerm:
            value = "keywordsTerm"
        case .DescriptionTerm:
            value = "descriptionTerm"
        case .AuthorTerm:
            value = "authorTerm"
        case .GenreIndex:
            value = "genreIndex"
        case .MixTerm:
            value = "mixTerm"
        case .AllTrackTerm :
            value = "allTrackTerm"
        case .ArtistTerm:
            value = "artistTerm"
        case .ComposerTerm:
            value = "composerTerm"
        case .TvSeasonTerm:
            value = "tvSeasonTerm"
        case .ProducerTerm:
            value = "producerTerm"
        case .RatingTerm:
            value = "ratingTerm"
        case .SongTerm:
            value = "songTerm"
        case .MovieArtistTerm:
            value = "movieArtistTerm"
        case .ShowTerm:
            value = "showTerm"
        case .MovieTerm:
            value = "movieTerm"
        case .AlbumTerm:
            value = "albumTerm"
        }
        
        return value
    }
}

class Store {
    
    var fetchQueue : NSOperationQueue = {
        let op = NSOperationQueue()
        op.maxConcurrentOperationCount = 1
        return op
    }()
    
    static let sharedInstance = Store()
    static func defaultStore() -> Store {
        return sharedInstance
    }
    
    func paramsWithTerms(terms:[String]?, bundleId:String?, itemId:String?, country:String?, offset:Int = 0, limit:Int = 0, entity:Entity, mediaType:MediaType, mediaAttribute:MediaAttribute) -> [String:String] {
        
        var params = [String:String]()
        
        if let terms = terms {
            params["term"] = terms.joinWithSeparator("+")
        }
        
        if let bundleId = bundleId {
            params["bundleId"] = bundleId
        }
        
        if let itemId = itemId {
            params["id"] = itemId
        }
        
        var countryStr = "us"
        if let country = country {
            countryStr = country
        }
        
        params["country"] = countryStr
        params["entity"] = entity.value
        params["media"] = mediaType.value
        params["attribute"] = mediaAttribute.value
        params["offset"] = String(offset) ?? "0"
        params["limit"] = String(limit) ?? "0"
        
        return params
        
    }
    
    func findEndpoint(endpoint:Endpoint, params:[String:String]?, progress:((Double) -> Void)?, completion:((Result) -> Void)?) {
        
        let op = FetchOperation(endPoint: endpoint, params: params)
        op.resultBlock = completion
        fetchQueue.addOperation(op)
    }
    
    func findWithItemId(itemId:String, country:String, offset:Int = 0, limit:Int = 0, entity:Entity, mediaType:MediaType, mediaAttribute:MediaAttribute, progress:((Double) -> Void)?, completion:((Result) -> Void)?) {
        
        findWithTerms(nil, bundleId: nil, itemId: itemId, country: country, offset: offset, limit: limit, entity: entity, mediaType: mediaType, mediaAttribute: mediaAttribute, progress: progress, completion: completion)
    }
    
    func findWithTerms(terms:[String]?, bundleId:String?, itemId:String?, country:String?, offset:Int = 0, limit:Int = 0, entity:Entity, mediaType:MediaType, mediaAttribute:MediaAttribute, progress:((Double) -> Void)?, completion:((Result) -> Void)?) {
        
        let params = paramsWithTerms(terms, bundleId: bundleId, itemId: itemId, country: country, offset: offset, limit: limit, entity: entity, mediaType: mediaType, mediaAttribute: mediaAttribute)
        
        var endPoint = Endpoint.Search
        if bundleId != nil {
            endPoint = .Lookup
        }
        findEndpoint(endPoint, params: params, progress: progress, completion: completion)
    }
    
    func findAppWithName(name:String?, developer:String?, country:String?, offset:Int = 0, limit:Int = 0, progress:((Double) -> Void)?, completion:((Result) -> Void)?) {
        
        var terms = [String]()
        if let name = name {
            terms.append(name)
        }
        
        if let developer = developer {
            terms.append(developer)
        }
        
        findAppWithTerms(terms, bundleId:nil, country: country, progress: progress, completion: completion)
    }
    
    func findAppWithTerms(terms:[String]?, bundleId:String?, country:String?, offset:Int = 0, limit:Int = 0, progress:((Double) -> Void)?, completion:((Result) -> Void)?) {
        
        findWithTerms(terms, bundleId: bundleId, itemId: nil, country: country, offset: offset, limit: limit, entity: Entity.Software, mediaType: MediaType.Software, mediaAttribute: MediaAttribute.All, progress: progress, completion: completion)
    }
    
    func findMusicWithTerms(terms:[String]?, country:String?, offset:Int = 0, limit:Int = 0, progress:((Double) -> Void)?, completion:((Result) -> Void)?) {

        findWithTerms(terms, bundleId: nil, itemId: nil, country: country, offset: offset, limit: limit, entity: Entity.MusicTrack, mediaType: MediaType.Music, mediaAttribute: MediaAttribute.All, progress: progress, completion: completion)
    }
}

public enum Result {
    case Success(items:[StoreItem]), Failure(error:NSError)
}

class FetchOperation : NSOperation {
    
    var endPoint : Endpoint
    var params : [String:String]?
    var resultBlock : ((Result) -> Void)?
    
    var _ready = true
    var _finished = false
    var _executing = false
    var _cancelled = false
    
    init(endPoint:Endpoint, params:[String:String]?) {
        
        self.endPoint = endPoint
        self.params = params
        super.init()
    }
    
    func URLForEndpint(endpoint:Endpoint, params:[String:String]?) -> NSURL? {
        
        let query = params?
        .reduce([String](), combine: { (list, param:(String, String)) -> [String] in
            var list = list
            list.append(param.0 + "=" + param.1)
            
            return list
        })
        .reduce("", combine: { (request, paramStr) -> String in
            return request + "&" + paramStr
        })
        
        var urlString = endpoint.URLString
        if let query = query {
            urlString += "?" + query
        }
        
        return NSURL(string: urlString)
    }
    
    func downloadDataFromAPI(endpoint:Endpoint, params:[String:String]?) {
        
        guard let URL = URLForEndpint(endpoint, params: params) else { return }
        let request = NSURLRequest(URL: URL)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let donwloadTask = session.downloadTaskWithRequest(request) { (location, response, error) in
            
            if let error = error {
                self.resultBlock?(Result.Failure(error: error))
                self.finish()
                return
            }
            
            guard let location = location, let data = NSData(contentsOfURL: location) else {
                self.finish()
                return
            }
            
            if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String:AnyObject] {
                
                if (json?["resultCount"] as? Int) > 0 {
                    
                    let items = (json?["results"] as? [[NSObject:AnyObject]])?.reduce([StoreItem](), combine: { (items, child) -> [StoreItem] in
                        var items = items
                        items.append(StoreItem(json: child))
                        return items
                    })
                    
                    let result = Result.Success(items: items ?? [])
                    self.resultBlock?(result)
                    self.finish()
                } else {
                   
                    self.resultBlock?(Result.Success(items:[]))
                    self.finish()
                }
            } else {
                self.resultBlock?(Result.Success(items:[]))
                self.finish()
            }
        }
        
        donwloadTask.resume()
    }
    
    override var ready:Bool {
        get { return _ready }
        set {
            willChangeValueForKey("isReady")
            _ready = newValue
            didChangeValueForKey("isReady")
        }
    }
    
    override var executing:Bool {
        get { return _executing }
        set {
            willChangeValueForKey("isExecuting")
            _executing = newValue
            didChangeValueForKey("isExecuting")
        }
    }
    
    override var finished:Bool {
        get { return _finished }
        set {
            willChangeValueForKey("isFinished")
            _finished = newValue
            didChangeValueForKey("isFinished")
        }
    }
    
    override var cancelled:Bool {
        get { return _cancelled }
        set {
            willChangeValueForKey("isCancelled")
            _cancelled = newValue
            didChangeValueForKey("isCancelled")
        }
    }
    
    override var concurrent : Bool {
        return true
    }
    
    override var asynchronous : Bool {
        return true
    }
    
    override func start() {
        
        ready = true
        executing = false
        finished = false
        cancelled = false
        
        main()
    }
    
    override func main() {
        
        if self.cancelled {
            finish()
            return
        }
        
        self.execute()
    }
    
    override func cancel() {
        
        ready = false
        executing = false
        cancelled = true
        finished = false
    }
    
    // MARK: - Execute main block
    private func execute() {
        
        ready = false
        executing = true
        finished = false
        
        if self.cancelled {
            finish()
            return
        }
        
        downloadDataFromAPI(endPoint, params: params)
        
    }
    
    private func finish() {
        ready = false
        executing = false
        finished = true
    }
}

public struct StoreItem {
    
    let json : [NSObject:AnyObject]
    
    public var artistId : String? {
        
        return json["artistId"] as? String
    }
    
    public var artistLinkUrl : String? {
        
        return json["artistLinkUrl"] as? String
    }
    
    public var artistName : String? {
        
        return json["artistName"] as? String
    }
    
    public var artistType : String? {
        
        return json["artistType"] as? String
    }
    
    public var artistViewUrl : String? {
        
        return json["artistViewUrl"] as? String
    }
    
    public var artworkUrl100 : String? {
        
        return json["artworkUrl100"] as? String
    }
    
    public var artworkUrl512 : String? {
        
        return json["artworkUrl512"] as? String
    }
    
    public var artworkUrl60 : String? {
        
        return json["artworkUrl60"] as? String
    }
    
    public var bundleId : String? {
        
        return json["bundleId"] as? String
    }
    
    public var collectionCensoredName : String? {
        
        return json["collectionCensoredName"] as? String
    }
    
    public var collectionExplicitness : String? {
        
        return json["collectionExplicitness"] as? String
    }
    
    public var collectionName : String? {
        
        return json["collectionName"] as? String
    }
    
    public var collectionViewUrl : String? {
        
        return json["collectionViewUrl"] as? String
    }
    
    public var contentAdvisoryRating : String? {
        
        return json["contentAdvisoryRating"] as? String
    }
    
    public var copyright : String? {
        
        return json["copyright"] as? String
    }
    
    public var country : String? {
        
        return json["country"] as? String
    }
    
    public var currency : String? {
        
        return json["currency"] as? String
    }
    
    public var descriptionStr : String? {
        
        return json["description"] as? String
    }
    
    public var features : String? {
        
        return json["features"] as? String
    }
    
    public var formattedPrice : String? {
        
        return json["formattedPrice"] as? String
    }
    
    public var kind : String? {
        
        return json["kind"] as? String
    }
    
    public var previewUrl : String? {
        
        return json["previewUrl"] as? String
    }
    
    public var primaryGenreId : String? {
        
        return json["primaryGenreId"] as? String
    }
    
    public var primaryGenreName : String? {
        
        return json["primaryGenreName"] as? String
    }
    
    public var radioStationUrl : String? {
        
        return json["radioStationUrl"] as? String
    }
    
    public var releaseNotes : String? {
        
        return json["releaseNotes"] as? String
    }
    
    public var sellerName : String? {
        
        return json["sellerName"] as? String
    }
    
    public var trackCensoredName : String? {
        
        return json["trackCensoredName"] as? String
    }
    
    public var trackContentRating : String? {
        
        return json["trackContentRating"] as? String
    }
    
    public var trackExplicitness : String? {
        
        return json["trackExplicitness"] as? String
    }
    
    public var trackId : String? {
        
        return json["trackId"] as? String
    }
    
    public var trackName : String? {
        
        return json["trackName"] as? String
    }
    
    public var trackViewUrl : String? {
        
        return json["trackViewUrl"] as? String
    }
    
    public var version : String? {
        
        return json["version"] as? String
    }
    
    public var wrapperType : String? {
        
        return json["wrapperType"] as? String
    }
    
    public var averageUserRating : Double? {
        
        return (json["averageUserRating"] as? NSNumber)?.doubleValue
    }
    
    public var averageUserRatingForCurrentVersion : Double? {
        
        return (json["averageUserRatingForCurrentVersion"] as? NSNumber)?.doubleValue
    }
    
    public var collectionPrice : Int? {
        
        return (json["collectionPrice"] as? NSNumber)?.integerValue
    }
    
    public var discCount : Int? {
        
        return (json["discCount"] as? NSNumber)?.integerValue
    }
    
    public var discNumber : Int? {
        
        return (json["discNumber"] as? NSNumber)?.integerValue
    }
    
    public var fileSizeBytes : Double? {
        
        return (json["fileSizeBytes"] as? NSNumber)?.doubleValue
    }
    
    public var minimumOsVersion : Double? {
        
        return (json["minimumOsVersion"] as? NSNumber)?.doubleValue
    }
    
    public var price : Double? {
        
        return (json["price"] as? NSNumber)?.doubleValue
    }
    
    public var trackCount : Int? {
        
        return (json["trackCount"] as? NSNumber)?.integerValue
    }
    
    public var trackNumber : Int? {
        
        return (json["trackNumber"] as? NSNumber)?.integerValue
    }
    
    public var trackTimeMillis : [String]? {
        
        return json["trackTimeMillis"] as? [String]
    }
    
    public var genreIds : [String]?  {
        
        return json["genreIds"] as? [String]
    }
    
    public var genres : [String]? {
        
        return json["genres"] as? [String]
    }
    
    public var ipadScreenshotUrls : [String]? {
        
        return json["ipadScreenshotUrls"] as? [String]
    }
    
    public var languageCodesISO2A : [String]? {
        
        return json["languageCodesISO2A"] as? [String]
    }
    
    public var screenshotUrls : [String]? {
        
        return json["screenshotUrls"] as? [String]
    }
    
    public var isIsGameCenterEnabled : Bool? {
        
        return json["isIsGameCenterEnabled"] as? Bool
    }
    
    public var releaseDate : NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let str = json["releaseDate"] as? String else { return nil }
        return formatter.dateFromString(str)
    }
    
}
