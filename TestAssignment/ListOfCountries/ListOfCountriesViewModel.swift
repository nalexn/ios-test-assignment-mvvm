//
//  ListOfCountriesViewModel.swift
//  TestAssignment
//
//  Created by Alexey Naumov on 19/07/2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation

struct ListOfCountries { }

protocol ListOfCountriesViewModel {
    var countries: Property<Loadable<[Country]>> { get }
    func loadMoreCountries()
}

extension ListOfCountries {
    class ViewModel: ListOfCountriesViewModel {

        private(set) var countries = Property<Loadable<[Country]>>(value: .notRequested)

        private let service: CountriesServiceProtocol
        private var nextPage: Pagination?

        init(service: CountriesServiceProtocol) {
            self.service = service
        }

        func loadMoreCountries() {
            countries.value = .isLoading(prevValue: countries.value.value)
            service.loadCountries(page: nextPage) { [weak self] response in
                self?.handleCountriesListResponse(response)
            }
        }

        private func handleCountriesListResponse(_ response: ListOfCountries.Response) {
            switch response {
            case let .success(countriesOnPage, nextPage):
                self.nextPage = nextPage
                var loadedCountries = countries.value.value ?? []
                loadedCountries.append(contentsOf: countriesOnPage)
                countries.value = .loaded(loadedCountries)
            case let .failure(error):
                countries.value = .failed(error: error, prevValue: countries.value.value)
            }
        }
    }
}
