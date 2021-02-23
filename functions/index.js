// const functions = require ('firebase-functions');
// const admin = require ('firebase-admin');
// admin.initializeApp();


// exports.splitdeliverycost = functions.https.onCall((data, context) => {

//     var depotname= (data.depotname);
//     var shippmenttype=(data.shippmenttype);
//     var deliveryday =(data.deliveryday);
//     var userid =(data.userid);

//     switch(shippmenttype){
//       case 'FD':
//         return admin.firestore().collection('depots').doc(depotname).get().then(snapshot => {
//           var fixedprice= snapshot.data().price;
//           return { 
//             price:fixedprice,
//             Dtoken:'.'
//            };
//         });
//         break;
//       case 'CS':     
//         return admin.firestore().collection('sharedorders').where('depotname','==',depotname).       
//         where('sharedstatus','==','false').limit(1).get().then(snapshot => {
//          if(snapshot.empty){
//           return { 
//             price:'Similar Order has not been found ',
//             Dtoken:'.'
//            };
//          }else{
//           var DeviceToken = snapshot.docs[0].data().DeviceToken;
//           var TheUserId = snapshot.docs[0].data().userid
//           return admin.firestore().collection('depots').doc(depotname).get().then(snapshot => {
//             var halfprice= snapshot.data().price; 
//             var newhalfprice = parseInt(halfprice);
//             var divider = 2; 
//             var newhalfprice =newhalfprice / divider;
//             var prixxy = newhalfprice.toString();
//             return {
//               price: prixxy,
//               Dtoken:DeviceToken,
//               Dname:TheUserId,
//             };
//           });
//          }
//         });
//        break;
//       default:
//         return { 
//           price: 'No shippment plan received',
//           Dtoken:'.'
//          };
//     }
//   }
// )



// const functions = require ('firebase-functions');
// const admin = require ('firebase-admin');
// admin.initializeApp();
// exports.updateUserCount = functions.database.ref('users/{userId}').onCreate(() => {
//   return admin.database().ref('userCount').transaction(userCount => (userCount || 0) + 1);
// });