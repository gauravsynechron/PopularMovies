//
//  MovieViewModel.swift
//  MovieTask
//
//  Created by Gaurav R on 12/07/23.
//

import Foundation

protocol movieDataProtocol {
    func getData(completionHandler: @escaping (Bool, String?) -> Void)
    func getNumberOfItems() -> Int
    func getItem(row: Int) -> MovieData?
}

class MovieViewModel: movieDataProtocol {
    var response: ResponseData?
    
    init() {
        
    }
    
    func getData(completionHandler: @escaping (Bool, String?) -> Void) {
        var pageNumber:Int = 1
        if let page = response?.page, let totalPage = response?.total_pages {
            pageNumber = page + 1
            if totalPage < pageNumber {
                return
            }
        }
        
        if pageNumber == 1 && response?.results != nil {
            return 
        }
        
        Network.sharedInstance.getData(page: pageNumber) { [weak self] isSuccess, responseData, errMsg in
            guard let weakSelf = self else { return }
            
            if isSuccess == false {
                completionHandler(false, errMsg)
            } else if responseData?.success == false {
                completionHandler(false, responseData?.status_message)
            } else {
                if weakSelf.response == nil {
                    weakSelf.response = responseData
                } else {
                    weakSelf.response?.page = responseData?.page
                    if let array = responseData?.results {
                        weakSelf.response?.results?.append(contentsOf: array)
                    }
                }
                
                completionHandler(true, nil)
            }
        }
    }
    
    func getNumberOfItems() -> Int {
        if let count = response?.results?.count {
            return count
        }
        return 0
    }
    
    func getItem(row: Int) -> MovieData? {
        if let data = response?.results?[row] {
            return data
        }
        return nil
    }
    
    
}
