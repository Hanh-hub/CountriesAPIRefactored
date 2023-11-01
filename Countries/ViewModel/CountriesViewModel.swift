//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Omar Hesham on 9/18/23.
//

import Foundation



//class CountriesViewModel {
//    @Published var countries: [CountriesModel] = []
//    
//    private var networkApi = NetworkApi()
//    
//    func fetchCountries() async throws {
//        do {
//            let countriesResponse: [CountriesModel] = try await networkApi.fetchData(url: AppConstant.countries)
//            await MainActor.run {
//                self.countries = countriesResponse
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}


class CountriesViewModel{
    @Published var countries: [CountriesModel] = []
    @Published var filteredCountries: [CountriesModel] = []
    @Published var errorMessage: String?
   
    private var debounceWorkItem: DispatchWorkItem?
    private var networkApi: NetworkApi
    
    init(networkApi: NetworkApi = NetworkApi()) {
        self.networkApi = networkApi
    }

    func fetchCountries() async {
        
        do {
            let countriesResponse: [CountriesModel] = try await networkApi.fetchData(url: AppConstant.countries)
            await MainActor.run {
                self.countries = countriesResponse
                self.filteredCountries = self.countries
            }
        } catch let error as APIError {
            self.errorMessage = error.errorDescription
        } catch {
            self.errorMessage = "An unexpected error occurred. Please try again later."
        }
    }
    
    func filterCountriesBy(name: String?){
        debounceWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            guard let searchText = name, !searchText.isEmpty else {
                self.filteredCountries = self.countries
                return
            }
            
            self.filteredCountries = self.countries.filter({ countriesInfo in
                return countriesInfo.name?.lowercased().contains(searchText.lowercased()) ?? false
            })
        }
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: workItem)
    }
    
    deinit {
        debounceWorkItem?.cancel()
    }

}
