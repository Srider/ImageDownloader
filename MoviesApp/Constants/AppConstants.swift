//
//  AppConstants.swift
//  Symbio_Countries
//
//  Created by Honeywell on 18/11/17.
//  Copyright © 2017 Honeywell. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Controllers {
        static let kTopRatedMoviesViewController = "TopRatedMoviesViewController"
        static let kPopularMoviesViewController = "PopularMoviesViewController"
        static let kDiscoverMoviesViewController = "DiscoverMoviesViewController"
    }
    
    struct Titles {
        static let kCountrySearchTitle = "Country Search"
    }
    
    struct Alerts {
        static let kCountrySearchTitle = "Movie Search"
        static let NETWORK_ALERT = "Network alert"
        static let kNoNetworkMessage = "Network not available."
        static let kNetworkAvailableMessage = "Internet is available."
        
        static let kOkayButtontitle = "Okay"
        
        static let NO_COUNTRIES_ALERT = "No movies alert"
        static let kNoCountriesMessage = "No movies available for the given name."
        
        static let COUNTRIES_SEARCH_ALERT = "Search movie alert."
        static let kCountrySearchOperationFailed = "Movie search operation failed !!!"
        
        static let COUNTRY_DETAILS_ALERT = "Movie details alert."
        static let kCountryDetailOperationFailed = "Movie details fetch operation failed !!!"
        
        static let SEARCH_ALERT = "Search alert"
        static let kEmptySearchMessage = "Please enter a valid movie name to search "
    }
    
    struct Timeout {
        static let kNetworkTimeout = 5.0
    }
    
    struct URLS {
        static let k_GENERIC_URL_PREFIX = "https://api.themoviedb.org/3/movie/"
        static let k_DISCOVER_URL_PREFIX = "https://api.themoviedb.org/3/"
        static let k_POSTER_URL_PREFIX = "https://image.tmdb.org/t/p/w500/"
    }
    
    struct ENDPOINTS {
        static let k_LATEST = "latest?"
        static let k_DISCOVER = "discover/movie?"
        static let k_TOPRATED = "top_rated?"
        static let k_POPULAR = "popular?"
        static let k_NOW_PLAYING = "now_playing?"
        
    }
    
    struct APIKey {
        static let k_API_KEY = "d35b3f824d6cce5f7278699a5ca483ec"
    }
    
    struct RequestParam {
        static let kURLRequestType = "GET"
        static let kURLRequestContentValue = "application/json"
        static let kURLRequestContentType = "Content-Type"
    }
    

    
    struct Notifications {
        static let kNetworkReachable = "Reachable"
        static let kNetworkNotReachable = "NotReachable"
        static let kNetworkOperationSuccess = "SuccessNotification"
        static let kNetworkOperationFailure = "FailureNotification"
    }
    
    struct ButtonTitles {
        static let kBackButtonText = "Back"
    }
    
    struct ResponseKeys {
        static let kCountryName = "name"                  /* Response Key :- Country Name */
        static let kCountryDomain = "topLevelDomain"      /* Response Key :- Country Domain */
        static let kCountryAlpha2Code = "alpha2Code"      /* Response Key :- Country Alpha2Code */
        static let kCountryAlpha3Code = "alpha3Code"      /* Response Key :- Country Alpha3Code */
        static let kCountryCallingCode = "callingCodes"   /* Response Key :- Country CallingCode */
        static let kCountryCapital = "capital"            /* Response Key :- Country Capital */
        static let kCountryAltSpellings = "altSpellings"  /* Response Key :- Country CountryAltSpellings */
        static let kCountryRegion = "region"              /* Response Key :- Country Region */
        static let kCountrySubregion = "subregion"        /* Response Key :- Country Subregion */
        static let kCountryPopulation = "population"      /* Response Key :- Country Population */
        static let kCountryLatLong = "latlng"             /* Response Key :- Country LatLong */
        static let kCountryDemonym = "demonym"            /* Response Key :- Country Demonym */
        static let kCountryArea = "area"                  /* Response Key :- Country Area */
        static let kCountryGini = "gini"                  /* Response Key :- Country Gini */
        static let kCountryTimezones = "timezones"        /* Response Key :- Country Timezones */
        static let kCountryBorders = "borders"            /* Response Key :- Country Borders */
        static let kCountryNativeName = "nativeName"      /* Response Key :- Country NativeName */
        static let kCountryNumericCode = "numericCode"    /* Response Key :- Country NumericCode */
        static let kCountryCurrencies = "currencies"      /* Response Key :- Country Currencies */
        static let kCurrencyCode = "code"                 /* Response Key :- Currency Code */
        static let kCurrencyName = "name"                 /* Response Key :- Currency Name */
        static let kCurrencySymbol = "symbol"             /* Response Key :- Currency Symbol */
        static let kCountryLanguages = "languages"        /* Response Key :- Country Languages */
        static let kLanguagesISO_1 = "iso639_1"           /* Response Key :- Languages iso639_1 */
        static let kLanguagesISO_2 = "iso639_2"           /* Response Key :- Languages iso639_2 */
        static let kLanguageName = "name"                 /* Response Key :- Language Name */
        static let kLanguageNativeName = "nativeName"     /* Response Key :- Language NativeName */
        static let kLanguageTranslations = "translations" /* Response Key :- Language Translations */
        static let kLanguageGerman = "de"                 /* Response Key :- Language Code German */
        static let kLanguageSpanish = "es"                /* Response Key :- Language Code Spanish */
        static let kLanguageFrench = "fr"                 /* Response Key :- Language Code French */
        static let kLanguageJapan = "ja"                  /* Response Key :- Language Code Japan */
        static let kLanguageItalian = "it"                /* Response Key :- Language Code Italian */
        static let kLanguageBrazillian = "br"             /* Response Key :- Language Code Brazillian */
        static let kLanguagePortugeese = "pt"             /* Response Key :- Language Code Portugeese */
        static let kLanguageDutch = "nl"                  /* Response Key :- Language Code Dutch */
        static let kLanguageCroatian = "hr"               /* Response Key :- Language Code Croatian */
        static let kLanguagePersian = "fa"                /* Response Key :- Language Code Persian */
        static let kCountryFlag = "flag"                  /* Response Key :- Country Flag */
    }
    
    struct ResponseStatusKeys {
        static let kJSONResponseStatus = "status"
        static let kJSONResponseData = "data"
        static let kJSONResponseCode = "code"
        static let kJSONResponseSuccess = "Success"
        static let kJSONResponseResult = "result"
        static let kJSONResponseMessage = "message"
        static let kJSONResponseNotFound = "Not Found"
        static let kJSONRequestTimedout = "Request Timed Out"
        static let kJSONResponseSuccessStatus = 200
        static let kJSONResponseFailedStatus = 404
        static let kNoResponseText = "Not Available"
    }
    
    struct CellAttributes {
        static let kDataName = "Name"
        static let kDataNativeName = "Native Name"
        static let kDataRegion = "Region"
        static let kDataCapital = "Capital"
        static let kDataLanguages = "Languages"
        static let kDataTranslations = "Translations"
        static let kNoDataText = "Not Available"
    }
    
    struct Caching {
        static let kURLCachedDate = "Cached Date"
        static let kCachedURLType = "https"
    }
    
    struct Cells {
        static let kTabCell = "TabCell"
        static let kImageInfoCell = "ImageInfoCell"
        static let kDetailCell = "Detail"
        static let kImageCell = "ImageCell"
        static let kTextCell = "TextCell"
    }
    
    struct AccessibilityIdentifier {
        static let kAccessIdentifierResultCell = "ResultCell"
    }
    
    struct ActivityIndicator {
        static let kLoading = "Loading..."
    }
}

/*!
 @enum ServiceType
 */
enum ServiceType{
    case kMovies
    case kMovieDetail
}
