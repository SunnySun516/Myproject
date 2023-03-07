//
//  CustomTabBar.swift
//  clockin
//
//  Created by Sunny Sun on 2023/3/2.
//

import SwiftUI

struct CustomTabBar: View {
    var animation: Namespace.ID
    
    //extracting screen size and bottom safe area
    var size: CGSize
    var bottomEdge: CGFloat
    
    @Binding var currentTab: Tab
    
    //adding animation
    @State var startAnimation: Bool = false
    
    var body: some View {
        
        HStack(spacing:0 ){
            //tabbuttons
            //iterating tab enum
            ForEach(Tab.allCases,id:  \.rawValue){tab in
                
                TabButton(tab: tab, animation: animation,currentTab: $currentTab){pressedTab in
                    
                    //updating gtab
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.8)){
                        startAnimation = true
                    }
                    //after some delay starting tab animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                        
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.8)){
                            currentTab = pressedTab
                        }
                    }
                    //after Tab animation finished resetting main animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45){
                        
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.8)){
                            startAnimation = false
                        }
                    }
                }
            }
        }
        //custom elastic shape
        .background(
            
            ZStack{
                let animationOffset: CGFloat = (startAnimation ? 15 : (bottomEdge == 0 ? 26 : 27))
                let offset : CGSize = bottomEdge == 0 ?
                CGSize(width: animationOffset, height: 31) :
                CGSize(width: animationOffset, height: 36)
                
                Rectangle()
                    .fill(Color("purple"))
                    .frame(width: 45,height: 45)
                    .offset(y: 40)
                // same size with button
                
                //adding two circles to create elastic shape
                Circle()
                    .fill(.white)
                    .frame(width: 45,height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 :1)
                //trail and error method
                    .offset(x: offset.width, y: offset.height)
                
                Circle()
                    .fill(.white)
                    .frame(width: 45,height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 :1)
                //trail and error method
                    .offset(x: -offset.width, y: offset.height)
            }
            .offset(x:getStartOffset())
            .offset(x: getOffset())
            
            //moving to start
            ,alignment: .leading
        )
        .padding(.horizontal,15)
        .padding(.top,7)
        .padding(.bottom,bottomEdge == 0 ? 23 : bottomEdge)
    }
            
    //getting start offset
    func getStartOffset() -> CGFloat {
        //padding
        let reduced = (size.width - 30)/5
        //45 = button size
        let center = (reduced - 45)/2
        
        return center
        
    }
    
    //moving elastic shape
    func getOffset()->CGFloat{
        let reduced = (size.width - 30)/5
        //getting index and multiplying with that
        let index = Tab.allCases.firstIndex{ checkTab in
            return checkTab == currentTab
        } ?? 0
        
        return reduced * CGFloat(index)
    }
}
        
struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //checking for small devices
    }
}
    
struct TabButton: View{
    var tab: Tab
    var animation: Namespace.ID
    @Binding var currentTab: Tab
    //sending back the result
    var onTap:(Tab)->()
    
    var body: some View{
        //Since we dont neet ripple effect while clicking the button
        //so we re using ontap
        Image(systemName: tab.rawValue)
            .foregroundColor(currentTab == tab ? .white : .gray)
        //default Frame
            .frame(width:45,height: 45)
            .background(
                //using matched geometry circle)
                
                ZStack{
                    
                    if currentTab == tab{
                        Circle()
                            .fill(Color("purple"))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
            .frame(maxWidth:.infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                if currentTab != tab{
                    onTap(tab)
                }
            }
    }
}
