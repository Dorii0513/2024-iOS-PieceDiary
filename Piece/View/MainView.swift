//
//  MainView.swift
//  Piece
//
//  Created by 김예림 on 4/14/24.
//

import SwiftUI

struct MainView: View {
    
    @State var showSheet: Bool = true
    @State var pieceList: [Piece] = []
    @State var currentIndex: Int?
    @State private var isShowingAlert = false
    
    @Binding var selectedUIImage: [UIImage?]
    
    var body: some View {
        ZStack {
            NavigationStack{
                
                //MARK: - List
                //list의 index 값을 어떻게 얻어올 수 있는지??
                List(pieceList.indices, id: \.self) { index in
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text(pieceList[index].time)
                                .font(.pretendardSemiBold15)
                                .foregroundStyle(Color(hexColor: "2D2B24", opacity: 0.3))
                                .tracking(-0.5)
                            
                            Spacer()
                            
                            Button(action: {
                                currentIndex = index
                                isShowingAlert = true
                            }, label: {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(Color(hexColor: "2D2B24", opacity: 0.3))
                                    .scaledToFit()
                                    .frame(width: 20)
                            })
                            
                        }.padding(.vertical,2)
                        
                        Text(pieceList[index].content)
                            .padding(.vertical,2)
                            .foregroundStyle(Color(hexColor: "474641"))
                            .font(.pretendardMediuim18)
                        
                        ForEach(pieceList[index].imagesString.indices, id: \.self) { imgIndex in
                            if let decodedImage = decodeBase64Image(pieceList[index].imagesString[imgIndex]) {
                                            Image(uiImage: decodedImage)
                                                .resizable()
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 200, height: 200, alignment: .leading)
                                        }
                                    }
                        //Image(pieceList[index].imagesString)
                        
                    }.listRowBackground(Color(hexColor: "474641", opacity: 0.1))
                }
                //❗️backgroundColor 변경 : NavigationStack이 ZStack 제일 아래에 깔려있는 뷰
                //ZStack에서 배경색 변경이 아니라 List가 쌓여있는 뷰에서 색 변경이 필요함!
                .background(LinearGradient(gradient: Gradient(colors: [Color(hexColor: "A9C9C9"), Color(hexColor:"E3E0DA")]), startPoint: .top, endPoint: .bottom))
                .scrollContentBackground(.hidden)
                
                //MARK: - NavigationTitle
                .navigationTitle("4월19일 금요일")
                .navigationBarTitleTextColor(Color(hexColor: "474641"))
                .navigationBarTitleDisplayMode(.inline)
                .frame(alignment: .trailing)
                
                //MARK: - Alert
                //List modifier로 뺌 (오류발생)
                .alert("조각을 삭제할까요?", isPresented: $isShowingAlert) {
                    Button("삭제") {
                        //optional 값 밖으로 빼기
                        if let curIndex = currentIndex {
                            delete(at: curIndex)
                        }
                    }
                    Button("아니오") {
                        showSheet = true
                    }
                } message: {
                    Text("삭제하면 이전으로 돌아갈 수 없어요")
                }
                
                //MARK: - NavigationBar Custom
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarLeading){
                        Button(action: {
                            //action
                        }, label: {
                            ZStack{
                                Circle().frame(width: 50, height: 50)
                                    .foregroundStyle(Color(hexColor: "474641", opacity: 0.1))
                                Image(systemName: "rectangle.stack.fill")
                                    .resizable()
                                    .frame(width:22, height: 18)
                                    .foregroundStyle(Color(hexColor: "616662"))
                            }
                        })
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button(action: {
                            //action
                        }, label: {
                            Text("완료")
                                .font(.pretendardSemiBold18)
                                .foregroundStyle(Color(hexColor: "474641"))
                        })
                    }
                    
                    //MARK: - BottomSheet
                }.sheet(isPresented: $showSheet, content: {
                    BottomView(pieceList: $pieceList)
                    
                    //❗️sheet 고정하기
                        .interactiveDismissDisabled()
                        .ignoresSafeArea()
                    
                    //❗️sheet 최소 높이 설정
                        .presentationDetents([.height(10), .fraction(0.37)])
                    
                    //❗️sheet뒤에 view와 상호작용하기
                    //(enable : 프레젠테이션 뒤의 보기와 상호작용이 가능하다)
                        .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.37)))
                        .presentationCornerRadius(45)
                        .presentationBackground {
                            Color(hexColor: "474641")
                        }
                })
            }
        }.onAppear(){
            loadPieceList()
            print(pieceList)
        }
        
    }
    
    func delete(at index: Int) {
        pieceList.remove(at: index)
        save()
        showSheet = true
    }
    func save() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("piece.json")
        if let encodedData = try? JSONEncoder().encode(pieceList) {
            try? encodedData.write(to: fileURL)
        }
    }
    //MARK: - Userdefaults save
    func loadPieceList() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("piece.json")
        if let data = try? Data(contentsOf: fileURL) {
            if let decoded = try? JSONDecoder().decode([Piece].self, from: data) {
                self.pieceList = decoded
            }
        }
    }
    
    func decodeBase64Image(_ encodedImage: String) -> UIImage? {
            guard let imageData = Data(base64Encoded: encodedImage),
                  let image = UIImage(data: imageData) else {
                return nil
            }
            return image
        }
    
}

#Preview {
    MainView( selectedUIImage: .constant([]))
}
