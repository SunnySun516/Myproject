//
//  Home.swift
//  clockin
//
//  Created by Sunny Sun on 2023/3/2.
//

import SwiftUI
import AnimatedImage

struct Home: View {
    //current tab
    @State var currentTab : Tab = .Home
    @State var showPage = false
    @State var isAnimating = false
    
    
    
    //定义一个整数数组，模拟从后台获取的数据
    let buttonCountData = [1,2,3,4,5]
    
    //hiding native one
    init(size: CGSize,bottomEdge: CGFloat){
        self.size = size
        self.bottomEdge = bottomEdge
        UITabBar.appearance().isHidden = true
    }
    
    //for matched geometry effect
    @Namespace var animation
    var size: CGSize
    var bottomEdge: CGFloat
    
    var body: some View {
        
        ZStack(alignment:.bottom)
        {
            //native tab view
            TabView(selection: $currentTab) {
                //tab views
                
                //Family Page
                ZStack {
                    Image("FamilyBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        if isAnimating{
                            GIFPlayer(gifName: "bear")
                                .scaledToFit()
                                .animation(.default)
                                .onAppear{
                                    self.isAnimating = true
                                        }
                                .onDisappear{
                                    self.isAnimating = false
                                        }
                                .onTapGesture{
                                    self.isAnimating.toggle()
                                            }
                        }else{
                            Image(Image(systemName: "play.circle.fill"))
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.blue)
                                .onTapGesture{
                                    self.isAnimating.toggle()
                                            }
                            }
                            }
                .tag(Tab.Home)
                
                
                //Plan Page
                ZStack {
                    Image("PlanBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        
                        Text("test")
                        Text("test")
                    }
                }
                .tag(Tab.Plan)
                
                //Concentration Page
                ZStack {
                    Image("FamilyBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        
                        Text("test")
                        Text("test")
                    }
                }
                .tag(Tab.Concentration)
                
                //Countdown Page
                ZStack {
                    Image("CountdownBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        HStack(spacing: 20) {
                            Spacer()
                            Button(action:{
                                self.showPage.toggle()
                            }){
                                Image(systemName: "star")
                                //处理按钮点击事件
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            
                            Button(action:{
                                self.showPage.toggle()
                            }){
                                Image(systemName: "plus")
                                    .frame(height: 30)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                        }
                        
                        
                        VStack{
                            ForEach(buttonCountData, id:  \.self){
                                count in Button("Countdown \(count)"){
                                    
                                }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical,10)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                            }
                        }
                        
                        
                        
                        Spacer()
                    }
                    if showPage{
                        AddCountdownDetail()
                                }
                    
                }
            
                    .tag(Tab.Countdown)
   
                //Mine Page
                Text("Mine").frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea())
                    .tag(Tab.Mine)
            }
            
                //custom tab bar
                CustomTabBar(animation: animation,size:size, bottomEdge: bottomEdge,currentTab: $currentTab)
                .background(Color.white)
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 //tab enum
enum Tab: String,CaseIterable{
    case Home = "house.fill"
    case Plan = "checkmark"
    case Concentration = "clock"
    case Countdown = "flag"
    case Mine = "person.fill"
}

