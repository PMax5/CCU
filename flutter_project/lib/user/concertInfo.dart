 import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
 import '../models/concert.dart';
 import '../models/user.dart';
 import 'package:flutter_complete_guide/utils/widgets.dart';
 import 'package:flutter_complete_guide/services/ConcertService.dart';
 import 'package:flutter_complete_guide/services/UserService.dart';
 import 'package:tuple/tuple.dart';

 class ConcertInfoPage extends StatefulWidget {
   ConcertInfoPage({Key key}) : super(key: key);

   @override
   ConcertInfoPageState createState() => ConcertInfoPageState();
 }

 class ConcertInfoPageState extends State<ConcertInfoPage> {
   ConcertService concertService = new ConcertService();
   UserService userService = new UserService();
   User userUpdated;
   Concert concertUpdated;
   Widget ExtraButton(User user, Concert concert) {
     return Container(
       width: (user.type == 'FAN' ? 140 : 100),
       height: 40,
       child: RaisedButton(
         shape: RoundedRectangleBorder(
             borderRadius: new BorderRadius.circular(5.0),
             side: BorderSide(color: Colors.black, width: 2)),
         child: Text((user.type == 'FAN' ? 'ARTIST PROFILE' : 'EDIT'),
             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
         onPressed: () {
           if(user.type == "FAN") {
             getArtist(concert.username).then((artistUser) {
               if (artistUser != null)
                 Navigator.pushNamed(
                   context, "/user/userProfile", arguments: ProfileArguments(user,false,artistUser));
               });
                
           }
         
           else //FIXMEPLEASE I WANT TO GO TO THE CREATION WITH INITIAL VALUES PLEASE 
             Navigator.pushNamed(
                 context, "/login");
         },
       ),
     );
   }

   Widget ConcertInfoMenu(BuildContext context, Arguments arguments) {
     Concert concert;
     User user;
     if(concertUpdated == null)
        concert = arguments.concert;
     else
        concert = concertUpdated;
     if(userUpdated == null)
        user = arguments.logged_in;
     else
        user = userUpdated;

     return MainMenu(
         context,
         user,
         Column(children: [
           Padding(
             padding: EdgeInsets.only(top: 10.0),
             child: Image.network(concert.image, fit: BoxFit.fill),
           ),
           Padding(
               padding: const EdgeInsets.all(6.0),
               child: Column(children: [
                 ListTile(
                     title: Text(concert.name,
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                             color: Colors.black)),
                     subtitle: Padding(
                       padding: EdgeInsets.only(top: 6.0),
                       child: Text(concert.date,  
                           style: TextStyle(fontSize: 15, color: Colors.black)),
                     ),
                     trailing: ExtraButton(user, concert)),
                 ListTile(
                   title: Padding(
                     padding: EdgeInsets.only(top: 10.0),
                     child: const Text("About the concert",
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 16,
                             color: Colors.black)),
                   ),
                   subtitle: Padding(
                     padding: EdgeInsets.only(top: 6.0),
                     child: Text(concert.description,
                         textAlign: TextAlign.justify,
                         style: TextStyle(fontSize: 15, color: Colors.black)),
                   ),
                 ),
               ])),
           (user.type == 'FAN'
               ? FanActionButton(concert, user)
               : ArtistActionButtons(concert, user))
         ]));
   }

   Widget FanActionButton(Concert concert, User user) {
     return FutureBuilder(
         future: getFanConcerts(user.username),
         builder: (context, bought_concerts) {
           if (!bought_concerts.hasData) {
             return Center(child: CircularProgressIndicator());
           }
           bool bought = false;
           bought_concerts.data.forEach((c) {
             if (c.id == concert.id) {
               bought = true;
             }
           });
           if (bought) {
              if (concert.status == 1)
                 return BottomButton('GO TO STREAM', () {
                   showDialog(
                       context: context,
                       builder: (_) => ConfirmationDialog(
                               "Voice call with the artist",
                               "By going to the stream, you’re enabled to win a voice call with the \ "
                                   "artist along with other fans at the end of the concert. You’ll receive \ "
                                   "a notification in case this happens.", () {
                             Navigator.of(context).pop();
                             Navigator.pushNamed(context, "/user/concertStream",
                                 arguments: Arguments(user, concert));
                           }, () {
                             Navigator.of(context).pop();
                           }));
                 }, 350);
              else
                return BottomButton('RETURN TICKET', () {
                   showDialog(
                       context: context,
                       builder: (_) => ConfirmationDialog(
                               "Are you sure you want to return the ticket?",
                               "By returning the ticket, the total cost of it will be automatically\ "
                                   "refunded and you won’t have access to the concert stream.", () {
                             Navigator.of(context).pop();
                             returnTicket(user.username,concert.id).then((){ 
                                   if (userResult != null)
                                     setState(() {
                                        userUpdated = userResult;
                                        concertUpdated = concertResult;
                                     }
                                  else
                                    showDialog(
                                        context: context,
                                        builder: (_) => TipDialog("Notice",
                                                "Sorry was impossible to return the ticket try to refresh the page.",
                                                () {
                                                    Navigator.of(context).pop();
                                                  })
                                    );
                             );}
                             );
                           }, () {
                             Navigator.of(context).pop();
                           }));
                 }, 350);
           }
           return BottomButton('BUY TICKET', () {
             Navigator.pushNamed(context, "/payment",
                 arguments: Arguments(user, concert));
           }, 350);
         });
   }

   Widget ArtistActionButtons(Concert concert, User user) {
     return Expanded(
         child: Align(
             alignment: FractionalOffset.bottomCenter,
             child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
               Padding(
                 padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
                 child: Container(
                   width: 165,
                   height: projectSettings.smallButtonHeight,
                   child: RaisedButton(
                     shape: RoundedRectangleBorder(
                         borderRadius: new BorderRadius.circular(5.0),
                         side: BorderSide(color: Colors.black, width: 2)),
                     child: Text('CANCEL CONCERT',
                         style: TextStyle(
                             fontWeight: FontWeight.bold, color: Colors.black)),
                     onPressed: () {
                       showDialog(
                           context: context,
                           builder: (_) => ConfirmationDialog(
                                   "Are you sure you want to cancel this concert?",
                                   "By cancelling this concert, you are deleting the concert info and if people \ "
                                       "already bought tickets for this concert, they will be automatically refunded.",
                                   () {
                                /* cancelConcert(
                                     user.username,
                                     concert
                                         .id);  FIXME this is endConcert not cancel
                                 Navigator.of(context).pop();
                                 Navigator.pushNamed(context,
                                     "/user/main",  TODO create cancel concert page
                                     arguments: user);*/
                               }, () {
                                 Navigator.of(context).pop();
                               }));
                     },
                   ),
                 ),
               ),
             /*  PinkButton('START STREAM', () {
                 showDialog(
                     context: context,
                     builder: (_) => ConfirmationDialog(
                             "Are you sure you want to start the concert?",
                             "By clicking on this button, your stream will start immediately and everyone \ "
                                 " who bought a ticket for it will have access to the stream.",
                             () {
                           startConcert(user.username, concert.id);
                           Navigator.of(context).pop();
                           Navigator.pushNamed(context, "/user/concertStream",
                               arguments: Arguments(user, concert));
                         }, () {
                           Navigator.of(context).pop();
                         }));
               }, 165),*/
             ])));
   }

   Widget BottomButton(String buttonText, Function() onPressed, double width) {
     return Expanded(
         child: Align(
             alignment: FractionalOffset.bottomCenter,
             child: PinkButton(buttonText, onPressed, width)));
   }

   Widget PinkButton(String buttonText, Function() onPressed, double width) {
     return Padding(
       padding: EdgeInsets.only(bottom: 20.0),
       child: Container(
         width: width,
         height: projectSettings.smallButtonHeight,
         child: RaisedButton(
             shape: RoundedRectangleBorder(
               borderRadius: new BorderRadius.circular(5.0),
             ),
             color: projectSettings.mainColor,
             child: Text(buttonText,
                 style: TextStyle(
                     fontWeight: FontWeight.bold, color: Colors.white)),
             onPressed: onPressed),
       ),
     );
   }

   Future<List<Concert>> getFanConcerts(String username) async {
     try {
       List<Concert> concerts = await concertService.getArtistConcerts(username);
       return concerts;
     } catch (e) {
       print(e.toString());
       return null;
     }
   }

   // Future<void> startConcert(String username, int concertId) async {
   //   try {
   //     await concertService.startConcert(username, concertId);
   //   } catch (e) {
   //     print(e.toString());
   //   }
   // }

   // Future<void> cancelConcert(String username, int concertId) async {
   //   try {
   //     await concertService.endConcert(username, concertId);
   //   } catch (e) {
   //     print(e.toString());
   //   }
   // }

   Future<User> getArtist(String username) async {
     try {
       return await userService.getUser(username);
     } catch (e) {
       print(e.toString());
       return null;
     }
   }

   Future<Tuple2<User,Concert>> returnTicket(String username, int concertId) async {
     try {
       return await concertService.returnTicket(username,id);
     } catch (e) {
       print(e.toString());
       return null;
     }
   }

   @override
   Widget build(BuildContext context) {
     Arguments arguments = ModalRoute.of(context).settings.arguments;

     return Scaffold(
         body: SingleChildScrollView(
             child: Column(children: <Widget>[
       BackButtonLogoHeader(context),
       ConcertInfoMenu(context, arguments)
     ])));
   }
 }
