//
//  OnboardingView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import SwiftUI
import User
import Core

struct OnboardingView: View {

  @Environment(\.presentationMode) private var presentation
  
//  @ObservedObject var onboardingPresenter: OnboardingPresenter
//  @ObservedObject var onboardingPresenter: GetDetailPresenter<UserDomainModel, UserDomainModel, Interactor<UserDomainModel, UserDomainModel, UpdateUserRepository<GetUserLocaleDataSource, UserTransformer>>>
//  @ObservedObject var onboardingPresenter: GetDetailPresenter

  @ObservedObject var onboardingPresenter: UserEditPresenter<Interactor<UserDomainModel, UserDomainModel, UpdateUserRepository<GetUserLocaleDataSource, UserTransformer>>>

  @Binding var isUserExist: Bool
  @State private var activeImage = 0
  @State private var images: [String] = ["onboarding", "onboarding2", "onboarding3"]

  private let timerShowcase = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ZStack {
      Image(images[activeImage])
        .resizable()
        .aspectRatio(contentMode: .fill)
        .animation(.spring())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(
          Rectangle()
            .fill(
              LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom))
            .opacity(0.7)
        )
        .onReceive(timerShowcase) { _ in
          self.activeImage = (self.activeImage + 1) % self.images.count
        }
      
      HStack {
        VStack {
          Text("Find your best game")
            .foregroundColor(.white)
            .font(.title)
            .bold()
          
          Text("Explore - Discover - Play")
            .foregroundColor(Color.init(.systemGray3))
            .font(.subheadline)
            .padding(.top, 5)
          
          Button(action: {
            UserDefaults.standard.setValue(true, forKey: "UserExist")
            
            /// insert data dummy
            onboardingPresenter.updateUser(request: UserDomainModel(id: "0", name: "Dimas Nugroho Putro", email: "dimasnugroho673@gmail.com", phoneNumber: "082285592029", website: "dimasnugroho673.github.io", githubUrl: "https://github.com/dimasnugroho673", profilePicture: Data()))
            
            self.isUserExist = true
            self.presentation.wrappedValue.dismiss()
          }, label: {
            Text("Get started")
              .font(.body)
              .fontWeight(.bold)
          })
            .buttonStyle(StartOnboardingButtonStyle())
            .padding(.top, 20)
        }
        .padding()
      }
      .padding(.bottom, 20)
      .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .bottom)
    }
    .ignoresSafeArea(.all)
  }
}
