//
//  Dolanan_id_myGame_CatalogueApp.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI
import RealmSwift
import Core
import Game
import User

let gameUseCase: Interactor<String, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>> = Injection.init().provideHome()
let searchUseCase: Interactor<String, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>> = Injection.init().provideSearchGame()
let favoriteUseCase: Interactor<Any, [GameDomainModel], GetFavoriteGameRepository<GetGamesLocaleDataSource, GameTransformer>> = Injection.init().provideFavoriteGame()
let userUseCase: Interactor<Any, UserDomainModel, GetUserRepository<GetUserLocaleDataSource, UserTransformer>> = Injection.init().provideUser()
let onboardingUseCase: Interactor<UserDomainModel, UserDomainModel, UpdateUserRepository<GetUserLocaleDataSource, UserTransformer>> = Injection.init().provideUpdateUser()

@main
struct DolananIdMyGameCatalogueApp: App {

  let homePresenter = GetListPresenter(useCase: gameUseCase)
  let searchGamePresenter = GetListPresenter(useCase: searchUseCase)
  let favoriteGamePresenter = GetListPresenter(useCase: favoriteUseCase)
  let detailUserPresenter = GetDetailPresenter(useCase: userUseCase)
  let onboardingPresenter = UserEditPresenter(userUseCase: onboardingUseCase)
//  let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome(), userUseCase: Injection.init().provideUser())
//  let searchGamePresenter = SearchGamePresenter(searchGameUseCase: Injection.init().provideSearchGame(), userUseCase: Injection.init().provideUser())
//  let favoriteGamePresenter = FavoriteGamePresenter(favoriteGameUseCase: Injection.init().provideFavoriteGame(), userUseCase: Injection.init().provideUser())
//  let onboardingPresenter = OnboardingPresenter(userUseCase: Injection.init().provideOnboarding())
//  let profilePresenter = ProfilePresenter(userUseCase: Injection.init().provideUser())

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(searchGamePresenter)
        .environmentObject(favoriteGamePresenter)
        .environmentObject(onboardingPresenter)
        .environmentObject(detailUserPresenter)
    }
  }
}
