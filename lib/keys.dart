String kConsumerKey = "iOjLX3RL3rAuTDzc3Zh2TYCyFbIejq3v";
String kConsumerSecret = "kfEopLleq4Jshrsx";

// const functions = require('firebase-functions');

//  exports.hello = functions.https.onCall((data, context) => {
//   return {
//       response : "hello " + data.message,
//   }
// });

// const functions = require('firebase-functions');

//  exports.splitdeliverycost = functions.https.onCall((data, context) => {

//     var depotname =data.get('depotname');

// var shippmenttype =newdata[1];
// var deliveryday =newdata[2];
// var userid =newdata[3];
// var newfee;

// console.log(data);
// console.log(depotname);

// return {
//             response: 'received well and good',
//         }

// console.log(shippmenttype);
// console.log(depotname);

// if(shippmenttype == 'FD'){

//     const  depotsRef = db.collection('depots');
//     const querydepots = depotsRef.where('depotname', '==', depotname).get();
//     console.log (querydepots);
//     var fixedprice = querydepots.get('fixedprice');
//     console.log (fixedprice);
//     return {
//         response: fixedprice,
//     }
// }else{
// const sharedordersRef =db.collection('sharedorders');

// const querysharedorders= sharedordersRef.where('depotname','==',depotname).
// where('shippmenttype','==',shippmenttype).
// where('deliveryday','==',deliveryday).
// where('sharedstatus','==',NA).get();

// console.log(querysharedorders);

// if(querysharedorders = null)
// {
//     console.log('There are no similar orders')
//     return {
//         response : 'No similar order found'
//     }
// }else{
//     var thedepotname = querysharedorders.get('depotname');
//     var theuserid = querysharedorders.get('userid');

//     const  depotsRef = db.collection('depots');

//     const queryingdepots = depotsRef.where('depotname', '==', thedepotname).get();

//     var thefixedprice = queryingdepots.get('fixedprice');

//     console.log(thefixedprice);

//     //Start updating the orders

//     var newfee= thefixedprice /2 ;

//     return {
//         response : newfee,
//     }
// }
//     return {
//         response: fixedprice,
//     }
// }

// });

// const functions = require ('firebase-functions');

// const admin = require ('firebase-admin');
// admin.initializeApp();

// exports.paymentCallback =functions.https.onRequest(async(req, res) =>{

//         const callbackData = req.body.Body.stkCallback;

//         console.log("Received payload:", callbackData);

//         const responseCode =callbackData.ResultCode;
//         const mCheckoutRequestID = callbackData.mCheckoutRequestID;

//         if(responseCode === 0){
//             const details = callbackData.CallbackMetadata.Item

//             var mReceipt;
//             var mPhonePaidFrom;
//             var mAmountPaid;

//             await details.forEeach(entry =>{
//                 switch (entry.Name){
//                     case "MpesaReceiptNumber":
//                         mReceipt =entry.Value
//                         break;

//                     case "PhoneNumber":
//                         mPhonePaidFrom =entry.Value
//                         break;

//                     case "Amount":
//                         mAmountPaid =entry.Value;
//                         break;

//                     default:
//                         break;

//                 }
//             })

//             const mEntryDetails ={
//                 "receipt": mReceipt,
//                 "phone": mPhonePaidFrom,
//                 "amount":mAmountPaid

//             }

//             var matchingCheckoutID = admin.firestore().collectionGroup('deposit').where('CheckoutRequestID','==',mCheckoutRequestID);
//             const queryResults = await matchingCheckoutID.get();

//             if(!queryResults.empty){

//                 var documentMatchingID = queryResults.docs[0];

//                 const mail =documentMatchingID.ref.path.split('/')[1]

//                 documentMatchingID.ref.update(mEntryDetails);

//                 admin.firestore().collection('payments').doc(mail).collection('balance').doc('account').get().then(async (account) =>{
//                     if(account.data() !== undefined){

//                         var balance = account.data().wallet
//                         const newBalance =balance + mAmountPaid
//                         console.log("Account found updating with balance", newBalance, "from", balance);

//                         return account.ref.update(
//                             {wallet:newBalance}

//                         )
//                     }else{
//                         console.log("No account found..Creating with new balance", mAmountPaid);

//                         try{
//                             return admin.firestore().collection('payments')
//                             .doc(mail).collection('balance').doc('account').set({
//                                 wallet: mAmountPaid
//                             });
//                         }catch(err){
//                             console.log("Error creating account when not found", err);
//                             return 1;
//                         }
//                     }

//                 }).catch((exc) =>{
//                     console.log("Exception getting account", exc);
//                     return {"data": exc}
//                 })
//                 console.log("Updated document :", documentMatchingID.ref.path);

//             }else{
//                 console.log("No document found matching the checkoutRequestID: ",mCheckoutRequestID);

//                 admin.firestore().doc('lost_found_receipts/deposit_info/all/' + mCheckoutRequestID).set(mEntryDetails);
//             }
//         }else{
//             console.log("Failed transaction.");

//         }

//         res.json(
//             {
//                 'result': 'Payment for ${mCheckoutRequestID} response received.'
//             }
//         );
// }

// );

// Payload
// {"Body"=>{"stkCallback"=>{"MerchantRequestID"=>"3968-94214-1", "CheckoutRequestID"=>"ws_CO_160620191218268004", "ResultCode"=>0, "ResultDesc"=>"The service request is processed successfully.",
// "CallbackMetadata"=>{"Item"=>[{"Name"=>"Amount", "Value"=>"05"}, {"Name"=>"MpesaReceiptNumber", "Value"=>"OFG4Z5EE9Y"}, {"Name"=>"TransactionDate", "Value"=>20190616121848},
// {"Name"=>"PhoneNumber", "Value"=>254711222333}]}}}, "push"=>{"Body"=>{"stkCallback"=>{"MerchantRequestID"=>"3968-94214-1", "CheckoutRequestID"=>"ws_CO_160620191218268004", "ResultCode"=>0,
// "ResultDesc"=>"The service request is processed successfully.", "CallbackMetadata"=>{"Item"=>[{"Name"=>"Amount", "Value"=>"05"}, {"Name"=>"MpesaReceiptNumber", "Value"=>"OFG4Z5EE9Y"}, {"Name"=>"TransactionDate",
// "Value"=>20190616121848}, {"Name"=>"PhoneNumber", "Value"=>254711222333}]}}}}}

// const functions = require ('firebase-functions');
// const cors =require('cors')({origin: true});
// const Busboy = require('busboy');
// const os = require('os');
// const path =require('path');
// const fs =require('fs');
// // The Firebase Admin Sdk to access cloud Firestore
// const admin = require ('firebase-admin');
// const { brotliDecompress } = require('zlib');
// const { compileFunction } = require('vm');
// admin.initializeApp();

// exports.shareDeliveryCost =functions.https.onRequest(async(req, res) =>{
// return cors(req, res, ()=>{
// if (req.method !=='POST'){
//     return res.status(500).json({message: "Not allowed"});
// }
// //check if is authorised user
// if(!req.headers.authorisation || !req.headers.authorisation.startsWith('Bearer')){
//     return res.status(401).json({error:'Unauthorsied'});
// }
// //retrieve the ID token of user..Not necessary
// let idToken;
// idToken = req.headers.authorisation.split('Bearer')[1];
// //Accepting the incoming file   ---- INSTALL THESE PACKAGES busboy for extracting incoming files and uuid used to create a unique which we need to generate a link to te file

// const busboy = new Busboy({headers: req.headers});
// let uploadData;
// let oldImagePath;

// busboy.on('file', (fieldname,file,filename,encoding,mimitype)=>{
//   const filePath =path.join(os.tmpdir(), filename);
//   uploadData ={filePath: filePath,type: mimeType, name: filename};
//   file.pipe(fs.createWriteStream(filePath));

// }
// );
// busboy.on('field',(fieldname,value)=>{
//     oldImagePath =decodeURIComponent(value);
// });
// busboy.on('finish',()=>{

// });
// }

// );

// }

// );

//  if (depotresult.empty) {
//                 console.log('No matching documents.');
//                 return;
//               }  else{

//                 depotresult.forEach(doc => {
//                     console.log(doc.id, '=>', doc.data());
//                     var fixedprice=doc.data().price;
//                     console.log(fixedprice);
//                     return{
//                       response: fixedprice
//                     }
//                   });

//               }

// async function getshareableorders() {
//   const sharedordersRef =db.collection('sharedorders')
//   const querysharedorders= sharedordersRef.where('depotname','==',depotname).
//   where('shippmenttype','==',shippmenttype).
//   where('deliveryday','==',deliveryday).
//   where('sharedstatus','==',NA).limit(1).get();
//   console.log(querysharedorders);
//   if (querysharedorders.empty){
//     console.log('No similiar order available');
//     return{
//       response: 'No user avaailable to share cost at the moment'
//     }
//   }else{

//     return{

//       response: 'A shareable order has been found'
//   }
//     // const  depotsRef = db.collection('depots');
//     // const querydepots = depotsRef.where('depotname', '==', depotname).get();

//   }

// }

// getshareableorders();
