//
//  ToolsAndSupplies.swift
//  Project
//
//  Created by Christian Hernandez on 11/1/24.
//
import SwiftUI

struct ToolsAndSupplies: View {
    @Binding var isSubSidebarOpen: Bool
    @Binding var subSidebarOpen: Bool
    @Binding var selectTheOption: String
    
    //creating an array of names to loop from
    let toolsAndSuppliesItems: [ToolsAndSuppliesSidebarItem] = [
        ToolsAndSuppliesSidebarItem(name: "FOR SEWING"),
        ToolsAndSuppliesSidebarItem(name: "FOR EMBROIDERY"),
        ToolsAndSuppliesSidebarItem(name: "FOR CRAFTING"),
        ToolsAndSuppliesSidebarItem(name: "FOR OFFICE/SHIPPING"),
        ToolsAndSuppliesSidebarItem(name: "FOR ORGANIZATION"),
        ToolsAndSuppliesSidebarItem(name: "FOR PHOTOGRAPHY")
    ]
    
    var body: some View {
        ZStack{
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 10) {
                //will return to the main sub view
                Button(action: {
                    subSidebarOpen = false
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("BACK")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 10)
                    
                }
                //now loop throught the options starting at index[0]...index[n]
                ForEach(toolsAndSuppliesItems) { item in
                    Button(action: {
                        //set the paramter to the name the user picked
                        selectTheOption = item.name
                        //now flag the isSubSidebarOpen-> we don't want it open
                        isSubSidebarOpen = false
                        subSidebarOpen = false
                    }) {
                        Text(item.name)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    }
                }
                Spacer()
            }
        }
    }
}
//precondition: NONE
//postcondition: this struct takes in name that carries the sub sidebar information
struct ToolsAndSuppliesSidebarItem: Identifiable {
    var id: String { name }
    var name: String
}

//precondition: NONE
//postcondition: this struct will keep track of the image with the url
struct ItemsOfSupplies: Identifiable {
    //passing two parameters
    var id: String { imageName }
    var imageName: String
    var url: URL
}
//precondition: call the ItemsOfSupplies struct
//postcondition: this will print the information if user clicks on for sewing option
struct ForSewing: View {
    //create an array->will be easier to print the information of the sewing with url
    let sewingItems: [ItemsOfSupplies] = [
        ItemsOfSupplies(imageName: "sewingimage1", url: URL(string:"https://www.amazon.com/gp/product/B074PXC61F/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B074PXC61F&linkCode=as2&tag=yeseniadesign-20&linkId=b656fd244a867b16a84eaeef98ed55e1&th=1")!),
        ItemsOfSupplies(imageName: "sewingimage2", url: URL(string:"https://www.amazon.com/gp/product/B01MRJ8BR7/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B01MRJ8BR7&linkCode=as2&tag=yeseniadesign-20&linkId=a1c27b6b310c8e1e8166d75f7013442e")!),
        ItemsOfSupplies(imageName: "sewingimage3", url: URL(string:"https://www.amazon.com/gp/product/B091JVT5HX/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B091JVT5HX&linkCode=as2&tag=yeseniadesign-20&linkId=f628fae60dee4c52d0e7dd9f1dacb21a")!),
        ItemsOfSupplies(imageName: "sewingimage4", url: URL(string:"https://www.amazon.com/gp/product/B07NC138FQ/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07NC138FQ&linkCode=as2&tag=yeseniadesign-20&linkId=40e8e9cb42f16225642efa8bcebd1b87")!),
        ItemsOfSupplies(imageName: "sewingimage5", url: URL(string:"https://www.amazon.com/MXBAOHENG-Electric-Rechargeable-Thickness-Batteries/dp/B09M9SC5BK?crid=2IDQOTPHIEYAK&keywords=electric%2Brotary%2Bcutter%2Bfor%2Bfabric&qid=1681188081&sprefix=Electric%2Brotary%2B%2Caps%2C188&sr=8-28&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=9d9a2114c485f7cc61492b562e4e207e&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "sewingimage6", url: URL(string:"https://www.amazon.com/Specialty-Products-734-PTSP-Turner-Needles/dp/B07TTR6G1R?crid=1KLVUCIMQFS9Q&keywords=ez%2Bpoint%2Band%2Bturner%2Btool%2Bfor%2Bsewing&qid=1681188374&sprefix=Ez%2Bpoint%2B,aps,158&sr=8-3&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=8084c9318e4f04e0e2a7ceaad808f471&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "sewingimage7", url: URL(string:"https://www.amazon.com/Hui-Tong-Scissors-Serrated-Scalloped/dp/B06WP56WXD?crid=2K3F1UTDF1GZI&keywords=hui%2Btong%2Bpinking%2Bshears%2B5mm&qid=1681189484&sprefix=hui%2Btong%2Bpinking%2Bshears%2B5mm,aps,191&sr=8-2&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=75bd693dd05690692dcb7266644bac44&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "sewingimage8", url: URL(string:"https://www.amazon.com/Automatic-Machine-Electric-Babylock-Accessory/dp/B07SQXKR9S?crid=1ONC9U4BSK7QT&keywords=automatic+bobbin+winder&qid=1681190507&sprefix=Automatic+bobb,aps,158&sr=8-7&linkCode=sl1&tag=yeseniadesign-20&linkId=5ebc32be7ef0838e8676eb1977153143&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "sewingimage9", url: URL(string:"https://www.amazon.com/Handmade-Setting-Machine-Nailheads-Accessories/dp/B0BKLPN6RW?crid=IRV1H602SOVN&dib=eyJ2IjoiMSJ9.2PBUpqlcVUHwz91fg7ZA_gQNQjbyXpn5vfcwxvKasrQfRqk4wwUDECIlEGzvqAM_ei00Ct5rEcFQk8gxaZvSb4wRcmuO8eiiT76zu7X9WtV2gA89zrZFJZEt3aSEbq55e4dwPrlqtjR3qw49dsy36Au6TqfIRMi4GDLqGJrtDivR7PTZTPg29YT7B51VAR8Kftfu9fGNbEY95mquHnNtMoYErRPKWEtNbLmMdPuDAviIW7Iw6sKO1cKj9eNb4ZkIbnu5YRXQyCN0Nyz07jHrlVn2t76k8EacO9J2uGLl1_o.R979RnE1xi7-_3npQolyr4NAlFtEQ0mSSeTa_azwbqk&dib_tag=se&keywords=pearl+setting+machine&qid=1712450676&sprefix=Pearl+setting+,aps,207&sr=8-7&linkCode=sl1&tag=yeseniadesign-20&linkId=b83286adee663c2bcff2d1ff014f2846&language=en_US&ref_=as_li_ss_tl")!)
    ]
    var body: some View {
        ScrollView {
            //vertical since sewing goes first then we want the images to be top to bottom
            VStack {
                Text("SEWING")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.top, 35)
                //loop through the array-> index[0]...index[n]
                ForEach(sewingItems) { item in
                    //if user clicks the url then the button will have an action
                    Button(action: {
                        UIApplication.shared.open(item.url)
                    }) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 150)
                    }
                }
                Text("(affiliate)")
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            .padding()
            //another divider for the second line
            Divider()
                .frame(height: 6)
                .background(Color.gray.opacity(0.3))
                .padding(.top, 5)
            //add the instagram link and youtube link-> has to be side to side so use HStack-> horizontal
            HStack{
                //call the struct (from the MainContentView)-> pass in the two parameters which are image and url
                InstagramAndYoutubeLink(socialMediaImage: "instagramimage", url: URL(string: "https://www.instagram.com/yeseniadesigns/")!)
                    .padding(.top, 100)
                    .padding(.bottom, 20)
                InstagramAndYoutubeLink(socialMediaImage: "youtubeimage", url: URL(string: "https://www.youtube.com/@yeseniadesigns")!)
                    .padding(.top, 100)
                    .padding(.bottom, 20)
            }
            //lastly just place the information of her company
            Text("© 2012-2024 YESENIA DESIGNS. ALL RIGHTS RESERVED.")
                .font(.caption)
                //.regular doesn't make it as bold
                .fontWeight(.regular)
                .foregroundColor(.black)
                //have to center the text
                .multilineTextAlignment(.center)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
        }
    }
}
//precondition: call the ItemsOfSupplies struct
//postcondition: this will print the information if user clicks on for embroidery option
struct ForEmbroidery: View {
    //create an array->will be easier to print the information of the sewing with url
    let embroideryItems: [ItemsOfSupplies] = [
        ItemsOfSupplies(imageName: "embroideryimage1", url: URL(string:"https://www.amazon.com/Stainless-Steel-Applique-Duckbill-Embroidery/dp/B071S7F9LK?crid=1S0P1KLEESXKA&keywords=6+inch+appliqué+duckbill+scissors&qid=1681188545&sprefix=6+inch+appliqué+duckbill+scissors+,aps,166&sr=8-2&linkCode=sl1&tag=yeseniadesign-20&linkId=70f853a3343e3866095354bf08739ad6&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage2", url: URL(string:"https://www.amazon.com/Tool-Sidehopper-Stitch-Scissor-Assorted-Colors/dp/B003ILWK8S?crid=1T4ZTQ0WBMXLV&dib=eyJ2IjoiMSJ9.PuquKSOInb9oj5I-BOHjFSiLuMF0zzxjziZldhlqbfKUesaQu3cBWfIr7Z58W_suk9frPMPsIiSlUUvplEmbp5m85CgX-cRLnifjAlaYo6Cnp-yZFmV4gdSCZfA4qjifzOiYU1C-4ZNsym8KXnJgD9qGW0Camd1dRqcGbrPRKWBvZnVv2-LTmku5TJrYCPRwgqwV7mT2etV4ilrDZQ5EoZ0kdB6I494cwW7uDWGDRB_ffbVJHzZi6mPfsqKQqrvCYucPxjLy3x-EIbKOZZGFgYTxA2f771m4HNWtmBjRlfc.dYkDXEmDBahSK0FkSdS0KPXN7I551uYC5Y5qcC3ORBg&dib_tag=se&keywords=jump+stitch+scissors+for+embroidery&qid=1717839345&sprefix=Jump+stitch+,aps,152&sr=8-5&linkCode=sl1&tag=yeseniadesign-20&linkId=3d24216d15d31fed0df4a5e72e68ea0f&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage3", url: URL(string:"https://www.amazon.com/Therm-Web-Spray-Basting-Adhesive/dp/B007POWZGG?crid=3U4Q4ZOFTD3XR&dib=eyJ2IjoiMSJ9.SfMMXy-4Gr6RkUHzrBITmr41Len6_FMTw_nHlsWmQBMh9mZ2J4xYnmFvnMfvKJJPpLvIh80dXs-4kLMbLHpaxHOFc6kIPx7q-ppZfGMek7ga_EBz-muK8jQuLaZH3SufrmoXfgEG9OaF4OVjN9UINtDxU2YifOX_juh7Z9ie76Oo8O7wHhLMWCoKj3lEHUqof925Lpel8ouv0QUPVMkdf8Ixs7tdaEfgqHw3KYmVFNlFiPryAFd0tLTbwY5sJHZZraKeGj-lRVBdOaMUO2l0HGglbc4uyk7QnX31q69i3RM.IineSOf93lDyi2hwCO66EO2xApLwyQ5xspe85hbSLck&dib_tag=se&keywords=basting%2Badhesive%2Bspray&qid=1712904901&sprefix=Basting%2Bad,aps,148&sr=8-2&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=cbf512a051bc6fbda3ec35f54ec3dda9&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage4", url: URL(string:"https://www.amazon.com/SUPVOX-Elastic-Barbed-Stretch-Fastener/dp/B07KNS3GMG?crid=NFKI41XXWNXG&dib=eyJ2IjoiMSJ9.gnk_E9ty6FJFaz7zx1Tjrsmm2vu1Z1rOSWh7YTDd_V8UZl3TvpXxs_JQJyJ5wSKG2GIwhkja0fupFzdFw8S_zZ0KCk39sMfnE5UOm4BeXPoM645aUVK1iY1PXgNQVLlRmi94kBp4leHCbxa8CvJ4savhxInwbZxEhhHLZsft1Qv38P5VjeG6oo2vT2wG5TjGCoktVGipiwOK4M3RF16B9hsGEVmSyJKX50Ks2Z-1T0H8agvODryAeZ63zu6hzfm0oQErI7tvbk4fJ_Jx8EFO7tYtOKTVD4uGvmWW5KdPyp4.DHJBCtrd6oD2O_aaX8gEHnB7wyL3oJwN2st-oQ97_To&dib_tag=se&keywords=elastic+bands+for+crafts+mask&qid=1712904973&sprefix=elastic+bands+for+crafts+mask,aps,145&sr=8-12-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9tdGY&psc=1&linkCode=sl1&tag=yeseniadesign-20&linkId=c8f76e4d82f81ade3e13cde342d7229d&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage5", url: URL(string:"https://www.amazon.com/Soluble-Machine-Embroidery-Stabilizer-Standing/dp/B079R5B7KF?crid=2VE20RSJC36ZD&dib=eyJ2IjoiMSJ9.92k5BFY4II_ypamKkjp1xXejOIGHCUCXnlidQHn-xujiYrUPAfouvABu6jQtmUqMPgTtx3fo5okmS_AXsH1aBuCgeL2hmblC8kwl__QKU55aDLoDqPKJe6zAJSaXXk1A9DUsDRJzRnvu-BEqxZvRdAOo9vRYuQCAz9KnbNH8sh8trLddBEck5qzgS10snAOhKEOsNo9BAGdvpyCi04v-9Z1CEcyh3Mjfge3q-LW5VG_A3rKsHBBaE3eXH9WWx01N5RZDb73EQcQACQAkw4TIRsCiAhKsnQj5CPrSGjuJ2GI.vE4poqxXujq6plW0twuIfjJp0jZ7Pc_n7H8cciglB5Q&dib_tag=se&keywords=FSL+Non+Woven+Water+Soluble+Wash+Away+Embroidery+Stabilizer:&qid=1717838965&sprefix=fsl+non+woven+water+soluble+wash+away+embroidery+stabilizer+,aps,203&sr=8-1&linkCode=sl1&tag=yeseniadesign-20&linkId=5feb1f2a7da0bbcd4ad2e84a49b04aef&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage6", url: URL(string:"https://www.amazon.com/New-brothread-Luminary-Embroidery-Quilting/dp/B09GVKYX7G?&linkCode=sl1&tag=yeseniadesign-20&linkId=32f523b9e63a130b01d94f3fa5e9f6e1&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage7", url: URL(string:"https://www.amazon.com/New-brothread-Changing-Embroidery-Quilting/dp/B09GVL1KVW?&linkCode=sl1&tag=yeseniadesign-20&linkId=56ac36ac9ffa4e168b988e50b54bfdd5&language=en_US&ref_=as_li_ss_tl")!)
    ]
    var body: some View {
        ScrollView {
            //vertical since sewing goes first then we want the images to be top to bottom
            VStack {
                Text("EMBROIDERY")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.top, 35)
                //loop through the array-> index[0]...index[n]
                ForEach(embroideryItems) { item in
                    //if user clicks the url then the button will have an action
                    Button(action: {
                        UIApplication.shared.open(item.url)
                    }) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 150)
                    }
                }
                Text("(affiliate)")
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            .padding()
            //another divider for the second line
            Divider()
                .frame(height: 6)
                .background(Color.gray.opacity(0.3))
                .padding(.top, 5)
            //add the instagram link and youtube link-> has to be side to side so use HStack-> horizontal
            HStack{
                //call the struct (from the MainContentView)-> pass in the two parameters which are image and url
                InstagramAndYoutubeLink(socialMediaImage: "instagramimage", url: URL(string: "https://www.instagram.com/yeseniadesigns/")!)
                    .padding(.top, 100)
                    .padding(.bottom, 20)
                InstagramAndYoutubeLink(socialMediaImage: "youtubeimage", url: URL(string: "https://www.youtube.com/@yeseniadesigns")!)
                    .padding(.top, 100)
                    .padding(.bottom, 20)
            }
            //lastly just place the information of her company
            Text("© 2012-2024 YESENIA DESIGNS. ALL RIGHTS RESERVED.")
                .font(.caption)
                //.regular doesn't make it as bold
                .fontWeight(.regular)
                .foregroundColor(.black)
                //have to center the text
                .multilineTextAlignment(.center)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
        }
    }
}

//preview
struct ToolsAndSupplies_Previews: PreviewProvider {
    @State static var isSubSidebarOpen = true
    @State static var subSidebarOpen = true
    @State static var selectTheOption: String = ""
    static var previews: some View {
        ToolsAndSupplies(isSubSidebarOpen: $isSubSidebarOpen, subSidebarOpen: $subSidebarOpen,selectTheOption: $selectTheOption)
    }
}

