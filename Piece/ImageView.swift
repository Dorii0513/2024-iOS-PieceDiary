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
    @Binding var selectedUIImage: [UIImage?] //바인딩 되어야 함
    @State var imageArr = [Image?]()
    
    @Binding var imageCount: Int
    
    let columns = [
        //카메라 버튼까지 포함해서 4개의 아이템이 들어감
        GridItem(.fixed(75), spacing: 10, alignment: nil),
        GridItem(.fixed(75), spacing: 10, alignment: nil),
        GridItem(.fixed(75), spacing: 10, alignment: nil),
        GridItem(.fixed(75), spacing: 10, alignment: nil)
    ]
    
    //some이 뭘까?
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
                            
                            
                            Text("\(imageCount) / 3")
                                .tracking(-1.5)
                                .foregroundColor(imageCount == 3 ? .kuroPink : Color(hexColor: "86847C"))
                                .font(.pretendardSemiBold14)
                            
                        }
                    }
                })
                
                //MARK: - imageArr
                // 내가 선택한 이미지를 배열에 넣기
                // 배열에 들어있는 이미지를 반복해서 부르기
                // 반복해서 부른 이미지를 표시하기
                // [내가선택한이미지1, 내가선택한이미지2, 내가선택한이미지3]
                ForEach(0..<3, id: \.self) { index in
                    ZStack {
                        // <- 이 자리에 내가 선택한 이미지
                        // 내가선택한이미지[index]
                        if index < selectedUIImage.count, let uiImage = selectedUIImage[index] {
                            Image(uiImage: uiImage)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: 75, height: 75)
                        }
                        //var index = 0
                    }
                    .onChange(of: selectedUIImage.count) {
                        print("selectedUI: \(selectedUIImage.count)")
                        imageCount = selectedUIImage.count
                    }
                    //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                }
            }
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedUIImage).ignoresSafeArea()
            //            PhotosPicker()
        }
        
    }
    //.border(Color.red)
    //    func loadImage() {
    //        guard let inputImage = selectedUIImage else { return }
    //        image = Image(uiImage: inputImage)
    //    }
}//.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
//MARK: - LoadImage


#Preview {
    ImageView(selectedUIImage: .constant([]), imageCount: .constant(0))
}
