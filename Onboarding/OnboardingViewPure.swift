//
//  OnboardingViewPure.swift
//  Onboarding
//
//  Created by Augustinas Malinauskas on 06/07/2020.
//  Copyright © 2020 Augustinas Malinauskas. All rights reserved.
//

import SwiftUI

struct OnboardingViewPure: View {
    var data: [OnboardingDataModel]
    var doneFunction: () -> ()
    
    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    var distance: CGFloat = UIScreen.main.bounds.size.width
    
    
    func nextButton() {
        if self.curSlideIndex == self.data.count - 1 {
            doneFunction()
            return
        }
        
        if self.curSlideIndex < self.data.count - 1 {
            withAnimation {
                self.curSlideIndex += 1
            }
        }
    }
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Text("Skip")
                    .padding(.trailing)
                    .foregroundColor(.accentColor)
                    .font(.title2)
                    .onTapGesture {
                        doneFunction()
                    }
            }
            ZStack {
                Color(.systemBackground).edgesIgnoringSafeArea(.all)
                
                ZStack(alignment: .center) {
                    ForEach(0..<data.count) { i in
                        OnboardingStepView(data: self.data[i])
                            .offset(x: CGFloat(i) * self.distance)
                            .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                            .animation(.spring())
                            .gesture(DragGesture().onChanged{ value in
                                self.slideGesture = value.translation
                            }
                            .onEnded{ value in
                                if self.slideGesture.width < -50 {
                                    if self.curSlideIndex < self.data.count - 1 {
                                        withAnimation {
                                            self.curSlideIndex += 1
                                        }
                                    }
                                }
                                if self.slideGesture.width > 50 {
                                    if self.curSlideIndex > 0 {
                                        withAnimation {
                                            self.curSlideIndex -= 1
                                        }
                                    }
                                }
                                self.slideGesture = .zero
                            })
                    }
                }
                
                
                VStack {
                    Spacer()
                    self.progressView()
                    //HStack {
                        //Spacer()
                        Button(action: nextButton) {
                            self.arrowView()
                        }.padding(.top, 40.0)
                    //}.padding(.top, 40.0)
                }
                .padding(20)
            }
        }.background((Color(.systemBackground)).edgesIgnoringSafeArea(.all))
    }
    
    func arrowView() -> some View {
        Group {
            if self.curSlideIndex == self.data.count - 1 {
                HStack {
                    Text("Get started")
                        .fontWeight(.semibold)
                        .font(.title3)
                        .frame(minWidth: 200)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.blue))
                        .cornerRadius(40)
                }
            } else {
                HStack{
                    Spacer()
                    Text("Next")
                        .fontWeight(.semibold)
                        .font(.title3)
                        .frame(minWidth: 80)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.blue))
                        .cornerRadius(40)
                }
            }
        }
    }
    
    func progressView() -> some View {
        HStack {
            ForEach(0..<data.count) { i in
                Circle()
                    .frame(width: 10.0, height: 10.0)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal, 2.0)
                    .opacity(self.curSlideIndex == i ? 1 : 0.25)
            }
        }
    }
    
}

struct OnboardingViewPure_Previews: PreviewProvider {
    static let sample = OnboardingDataModel.data
    static var previews: some View {
        OnboardingViewPure(data: sample, doneFunction: { print("done") })
    }
}

