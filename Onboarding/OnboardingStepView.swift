//
//  OnboardingStepView.swift
//  Onboarding
//
//  Created by Augustinas Malinauskas on 06/07/2020.
//  Copyright © 2020 Augustinas Malinauskas. All rights reserved.
//

import SwiftUI

struct OnboardingStepView: View {
    var data: OnboardingDataModel
    
    var body: some View {
        VStack(){
            Spacer()
            Image(data.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
            Text(data.heading)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .padding()
            Text(data.text)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60.0)
                .foregroundColor(.accentColor)
            Spacer()
        }
    .padding()
    }
}

struct OnboardingStepView_Previews: PreviewProvider {
    static var data = OnboardingDataModel.data[0]
    static var previews: some View {
        OnboardingStepView(data: data)
    }
}
