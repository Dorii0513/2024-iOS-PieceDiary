//
//  ImageView.swift
//  Piece
//
//  Created by 김예림 on 4/18/24.
//

import SwiftUI
import PhotosUI

struct ImageView: View {
    //image
    @State var showImagePicker = false
    @State var image: Image?
    @State var selectedUIImage: UIImage?
    @State var imageArr = [Image?]()
    
    let columns = [
        //카메라 버튼까지 포함해서 4개의 아이템이 들어감
        GridItem(.fixed(75), spacing: 10, alignment: nil),
        GridItem(.fixed(75), spacing: 10, alignment: nil),
        GridItem(.fixed(75), spacing: 10, alignment: nil),
        GridItem(.fixed(75), spacing: 10, alignment: nil)
    ]
    
    var body: some View {
        ScrollView() {
            LazyVGrid(
                columns: columns,
                alignment: .leading,
                spacing: 0
            ) {
                
                //MARK: - CameraBtn
                Button(action: {
                    showImagePicker.toggle()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 75, height: 75)
                            .foregroundStyle(Color(hexColor: "53514B"))
                        //.border(Color.red)
                        
                        VStack(spacing:3.3) {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .frame(width: 22, height: 16)
                                .foregroundStyle(Color(hexColor: "86847C"))
                            Text("0 / 3")
                                .tracking(-1.5)
                                .foregroundColor(Color(hexColor: "86847C"))
                                .font(.pretendardSemiBold14)
                        }
                    }
                })
                //MARK: - imageArr
                // 내가 선택한 이미지를 배열에 넣기
                // 배열에 들어있는 이미지를 반복해서 부르기
                // 반복해서 부른 이미지를 표시하기
                // [내가선택한이미지1, 내가선택한이미지2, 내가선택한이미지3]
                ForEach(0...2, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 75, height: 75)
                            .foregroundStyle(Color(hexColor: "53514B"))
                        Image(systemName: "heart")
                            .frame(width: 75, height: 75) // <- 이 자리에 내가 선택한 이미지
                        // 내가선택한이미지[index]
                        /*
                        if imageArr.count == 1, index == 0 {
                            if let image = imageArr[0] {
                                image
                                    .resizable()
                                    .frame(width: 75, height: 75)
                            }
                        }*/
                        
                        if let image = image{
                            image.resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: 75, height: 75)
                                .foregroundStyle(Color(hexColor: "53514B"))
                        }
                    }
                    //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                }
            }
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.image = Image(uiImage: image)
                
                imageArr.append(self.image)
            }
            
        }.ignoresSafeArea()
        //.border(Color.red)
    }//.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    
    //MARK: - LoadImage
}

#Preview {
    ImageView()
}
