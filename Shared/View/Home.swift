//
//  Home.swift
//  NotesMac (iOS)
//
//  Created by Mac on 25/10/2021.
//

import SwiftUI

struct Home: View {
    //showing card color on button click
    @State var showColor :Bool = false
    //button animation
    @State var animateButton :Bool = false
    var body: some View {
        HStack(spacing:0){
            //side bar creation
            if isMacOS(){
                Group{
            SideBar()
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.15))
                        .frame(width:1)
                }
        }
            //main content
           MainContent()
            
            
        }
        #if os(macOS)
        .ignoresSafeArea()
         #endif
        
        .frame(width: isMacOS() ? getReact().width / 1.7 : nil, height: isMacOS() ? getReact().height - 180 : nil,alignment: .leading)
        .background(Color("BG")).ignoresSafeArea()
        #if os(iOS)
        .overlay(SideBar())
            #endif
        .preferredColorScheme(.light)


    }
    @ViewBuilder
    func MainContent()->some View{
        VStack(spacing:6){
            //search bar
            HStack(spacing:8){
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                TextField("Search", text: .constant(""))
                
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            .padding(.bottom ,isMacOS() ? 0:10)
            .padding(.top,isMacOS() ? 0:40)
            .overlay(
                Rectangle().fill(Color.gray.opacity(0.8))
                    .padding(.horizontal,-25)
                    .frame(height:1)
                    .offset(y:6),alignment:.bottom
                
            )
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:13){
                    Text("Notes")
                        .font(isMacOS() ? .system(size: 33,weight: .bold):.largeTitle.bold())
                        .frame(maxWidth:.infinity,alignment: .leading)
                    
                    
                    //.columns
                    let colums = Array(repeating:GridItem(.flexible(), spacing: isMacOS() ? 25:15 ), count: isMacOS() ? 3:1)
                    
                    LazyVGrid(columns: colums , spacing: 25){
                        //notes
                        ForEach(notes){
                            note in
                            //cardview
                            CardView(note: note)
                        }
                    }
                    .padding(.top,30)
                }
                .padding(.top ,isMacOS() ? 45:30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top,isMacOS() ? 40 :15)
        .padding(.horizontal,25)
    }
    @ViewBuilder
    func CardView(note:Note)-> some View{
        VStack{
            Text(note.note)
                .font(isMacOS() ? .title3:.body )
                .multilineTextAlignment(.leading)
                .frame(maxWidth:.infinity,alignment: .leading)
            HStack{
                Text(note.date ,style: .date)
                    .foregroundColor(.black)
                    .opacity(0.8)
                
                Spacer(minLength: 0)
                
                //eidt buttton
                
                Button{
                    
                }label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 15,weight: .bold))
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                }
            }
            .padding(.top,55)
        }
        .padding()
        .background(note.cardcolor)
        .cornerRadius(18)
    }
    
    @ViewBuilder
    func SideBar()-> some View{
        VStack{
            if isMacOS(){
                Text("Pocket")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            //adding buttons
            if isMacOS(){
                AddButton()
                    .zIndex(1)
            }
           
            
            VStack(spacing:15){
                //Color....
                let colors = [Color("Skin"),Color("Blue"),Color("Orange"),Color("Purple"),Color("Green")]
                
                ForEach (colors , id :\.self){
                    color in
                    Circle()
                        .fill(color)
                        .frame(width: isMacOS() ?  20 : 25, height: isMacOS() ?  20 : 25)
                }
                
            }
                .padding(.top,20)
                .frame(height: showColor ? nil :0)
                .opacity(showColor ? 1:0 )
                .zIndex(0)
            
            if !isMacOS(){
                AddButton()
                    .zIndex(1)
            }
            
            
        }
        #if os(macOS)
            .frame(maxHeight:.infinity,alignment: .top)
            .padding(.vertical)
            .padding(.horizontal , 22)
            .padding(.top,35)
        #else
            .frame(maxWidth:.infinity,maxHeight:.infinity,alignment: .bottomTrailing)
            .padding()
            .background(
                BlurView(style: .systemUltraThinMaterialDark)
                    .opacity(showColor ? 1:0)
                    .ignoresSafeArea()
            )
        #endif
        
    }
    func AddButton()-> some View{
        Button{
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                showColor.toggle()
                animateButton.toggle()
            }
            //reseting the button
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                    animateButton.toggle()
                }
                
            }
        }label: {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .scaleEffect(showColor ? 1.1:1)
                .padding(isMacOS() ? 12 :15)
                .background(Color.black)
                .clipShape(Circle())
            
        }
        .rotationEffect(.init(degrees: showColor ? 135: 0))
        .scaleEffect(showColor ? 1.1:1)
        .padding(.top,30)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


//Extending View
extension View{
    func getReact() -> CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #else
        NSScreen.main!.visibleFrame
        #endif
    }
    
    func isMacOS() -> Bool{
        #if os(iOS)
        return false
        #endif 
        return true
    }
}


//hiding focusing ring
#if os(macOS)
extension NSTextField{
    open override var focusRingType: NSFocusRingType{
        get{.none}
        set{}
    }
}
#endif

