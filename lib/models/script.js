const functions = require ('firebase-functions');


const admin = require ('firebase-admin');
admin.initializeApp();

exports.paymentCallback =functions.https.onRequest(async(req, res) =>{
    //get data from the request .
  const getData = req.body.Body.UserDepotAndShippmentType;
  //look for where there is similar order for same depot same shipment type and same delivery window
  // look for amount of fixed price from depot collection
  //deiviide the price into two
  //put this particular order and previous order as status is shared
  //return the response to the user as the fixed delivery cost divided by two.

})
