import 'dart:math';

import 'package:chatbot/pages/news/news.dart';
import 'package:chatbot/pages/organisation/controller/organisationPageController.dart';
import 'package:chatbot/pages/organisation/model/organisation_details.dart';
import 'package:chatbot/serives/backEnd.dart';
import 'package:chatbot/utils/logger.dart';
import 'package:chatbot/utils/textUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class OrganisationPage extends StatefulWidget {
  const OrganisationPage({super.key});

  @override
  State<OrganisationPage> createState() => _OrganisationPageState();
}

class _OrganisationPageState extends State<OrganisationPage> {
  List<dynamic> sections = [];
  List<Map<String, dynamic>> allData = [];
  List<OrganisationDetails> departmentDetails = [];
  BackendServices _backendServices = BackendServices();
  Future<void> loadJsonData() async {
    final String jsonContent =
        await rootBundle.loadString('assets/jsons/organisations.json');
    final dynamic jsonData = json.decode(jsonContent);
    sections = jsonData['sections'];
  }

  void loadDepartmentDetails() async {
    for (int i = 0; i < sections.length; i++) {
      Logger.logA("${sections[i]['items'].length}");
      for (int j = 0; j < sections[i]['items'].length; j++) {
        OrganisationDetails temp = OrganisationDetails(
            imageUrl: sections[i]['items'][j]['imageurl'],
            name: sections[i]['items'][j]['name'],
            description: sections[i]['items'][j]['description']);
        departmentDetails.add(temp);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadJsonData().then((_) {
      loadDepartmentDetails();
      setState(() {}); // Trigger a rebuild after data is loaded.
    });
  }

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;

    List<Color> colorList = [
      const Color(0xFFFFA69E),
      const Color(0xFFB8F2E6),
      const Color(0xFFAED9E0),
      const Color(0xFFFAF3DD),
    ];
    List<String> category = [
      "All",
      "Health Care",
      "Security",
      "Hospitality",
      "Services",
      "Research",
      "Development",
    ];

    Random random = Random();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.abc,
          color: Colors.white,
          size: 30,
        ),
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Center(
          child: txt("Organisations", size: 26, weight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var response = await _backendServices.getNew();
              List<String> newsTitle = [
                "என் கணவரே எங்களை மறுபடியும்",
                "கோடி வசூலை நெருங்கும் ஜவான் படத்திற்கு முன்னணி",
                "அதே மாதிரி விக்கெட் கீப்பர்.. அதே மாதிரி கேப்டன்.. அதே மாதிரி"
              ];
              List<String> newsArticle = [
                "உதவி இயக்குநர் டு இயக்குநர்: அஜித்தின் வாலி படத்தில் ஒரு காட்சியில் நடித்த மாரிமுத்து இயக்குநர் மிஷ்கின் இயக்கிய யுத்தம் செய் படத்தில் நடிகராக அறிமுகமானார். பிரசன்னாவை வைத்து கண்ணும் கண்ணும் படத்தை இயக்கி இயக்குநராக மாறிய மாரிமுத்து புலிவால் படத்திற்கு பிறகு சினிமாவை இயக்கும் ஆசையையே விட்டுவிட்டார்",
                "வெளியான ஜவான் திரைப்படம் வசூல் ரீதியாக மிகப்பெரிய சாதனை படைத்து வருகிறது. இப்படம் உலகளவில் 1000 கோடி வசூல் நெருங்கியுள்ள நிலையில், இப்படத்தில் நடித்த பிரபலங்கள் இப்படத்திற்காக பெற்ற சம்பள விவரங்கள் இங்கு பட்டியலிடப்பட்டுள்ளது. முழு விவரங்கள் இதோ.",
                "அதே மாதிரி விக்கெட் கீப்பர்.. அதே மாதிரி கேப்டன்.. அதே மாதிரி"
              ];
              List<String> newImageUrl = [];
              List<dynamic> articles = response['articles'];
              for (var article in articles) {
                String title = article['title'];
                newsTitle.add(title);
                String art = article['description'];
                newsArticle.add(art);
                String data = article["publishedAt"];
                newImageUrl.add(data);
              }
              // for (var article in articles) {
              // }
              // for (var article in articles) {
              //   String title = article['urlToImage'];
              //   newImageUrl.add(title);
              // }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewPage(
                          newsTitle: newsTitle,
                          newsArticle: newsArticle,
                          newsImageUrl: newImageUrl,
                        )),
              );
            },
            icon: Icon(
              Icons.newspaper,
              color: Color.fromARGB(255, 13, 90, 96),
              size: 30,
            ),
          )
        ],
      ),
      body: FutureBuilder<void>(
        future: loadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Data has been loaded, you can access sections here.
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Consumer<OrganisationPageController>(
                          builder: (context, data, child) {
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 5,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: sections.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () => data.changeSelectedIndex(index),
                                  child: Container(
                                    height: 35,
                                    padding: const EdgeInsets.only(
                                      top: 0,
                                      bottom: 0,
                                      left: 20,
                                      right: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Color.fromARGB(255, 13, 90, 96),
                                      ),
                                      color: data.selectedIndex == index
                                          ? Color.fromARGB(255, 13, 90, 96)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: txt(sections[index]['title'],
                                          size: 14,
                                          color: data.selectedIndex == index
                                              ? Colors.white
                                              : Color.fromARGB(
                                                  255, 13, 90, 96)),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 654,
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: category.length,
                            itemBuilder: (BuildContext context, int ind) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      txt(sections[ind]['title'], size: 24),
                                      const Icon(
                                        Icons.arrow_right_alt,
                                        color: Color.fromARGB(255, 13, 90, 96),
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    // color: Colors.grey,
                                    // width: 180,
                                    height: 0.225 * sizeH,
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              width: 15,
                                            ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            sections[ind]['items'].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Logger.logA(
                                              "${sections[ind]['items'].length}");
                                          int randomIndex =
                                              random.nextInt(colorList.length);
                                          return Container(
                                            padding: const EdgeInsets.all(10),
                                            height: 226,
                                            width: 160,
                                            decoration: BoxDecoration(
                                                color: colorList[randomIndex],
                                                borderRadius:
                                                    BorderRadius.circular(17)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // padding: const EdgeInsets.only(
                                                  //     top: 10, left: 20),
                                                  height: 75,
                                                  width: 65,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          sections[ind]['items']
                                                                  [index]
                                                              ['imageurl']),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                txt(
                                                  sections[ind]['items'][index]
                                                      ['name'],
                                                  textAlign: TextAlign.start,
                                                  isBold: true,
                                                  size: 16,
                                                  // weight: FontWeight.w600,
                                                  maxLine: 2,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                txt(
                                                  sections[ind]['items'][index]
                                                      ['description'],
                                                  size: 12,
                                                  color: Color(0xFF919191),
                                                  textAlign: TextAlign.start,
                                                  // weight: FontWeight.w600,
                                                  maxLine: 2,
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 20,
                //   right: 20,
                //   child: InkWell(
                //     onTap: () => setState(() {}),
                //     child: Container(
                //       padding: const EdgeInsets.all(8),
                //       width: 0.15 * sizeW,
                //       height: 0.055 * sizeH,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(15),
                //         color: const Color.fromARGB(255, 13, 90, 96),
                //       ),
                //       child: const Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(
                //             Icons.refresh,
                //             color: Colors.white,
                //           ),
                //           // SizedBox(
                //           //   width: 0.01 * sizeW,
                //           // ),
                //           // txt("New Chat",
                //           //     size: 14,
                //           //     color: Colors.white,
                //           //     weight: FontWeight.w600),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${snapshot.error}'),
            );
          } else {
            // Data is still loading, you can show a loading indicator here.
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
