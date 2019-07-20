//
//  CountriesService.swift
//  TestAssignment
//
//  Created by Alexey Naumov on 19/07/2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation

// MARK: - CountriesService

protocol CountriesServiceProtocol {
    func loadCountries(page: Pagination?, completion: @escaping (ListOfCountries.Response) -> Void)
}

class CountriesService: CountriesServiceProtocol {

    private let baseURL: String
    private let urlSession: URLSession

    init(urlSession: URLSession, baseURL: String = "https://restcountries.eu/rest/v2") {
        self.urlSession = urlSession
        self.baseURL = baseURL
    }

    func loadCountries(page: Pagination?, completion: @escaping (ListOfCountries.Response) -> Void) {
        var urlRequest = URLRequest(url: URL(string: baseURL + "/all?fields=name;capital;currencies")!)
        urlRequest.httpMethod = "GET"
        urlSession.dataTask(with: urlRequest) { (data, _, error) in
            do {
                if let error = error { throw error }
                let countries = try JSONDecoder().decode([Country].self, from: data ?? Data())
                let page = page ?? .firstPage
                let boundsLow = min(page.offset, countries.count)
                let boundsHigh = min(page.offset + page.pageSize, countries.count)
                let countriesOnPage = Array(countries[boundsLow ..< boundsHigh])
                let nextPage: Pagination? = boundsHigh == countries.count ? nil : page.nextPage
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    completion(.success(countries: countriesOnPage, nextPage: nextPage))
                })
            } catch let error {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    completion(.failure(error))
                })
            }
        }.resume()
    }
}

// MARK: - ListOfCountries.Response

extension ListOfCountries {
    enum Response {
        case success(countries: [Country], nextPage: Pagination?)
        case failure(Error)

        var countries: [Country]? {
            switch self {
            case let .success(countries, _): return countries
            default: return nil
            }
        }

        var nextPage: Pagination? {
            switch self {
            case let .success(_, nextPage): return nextPage
            default: return nil
            }
        }

        var error: Error? {
            switch self {
            case let .failure(error): return error
            default: return nil
            }
        }
    }
}
