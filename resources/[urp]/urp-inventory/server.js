let DroppedInventories = [];
let InUseInventories = [];
let DataEntries = 0;
let hasBrought = [];
let CheckedDeginv = [];

function db(string) {
    exports.ghmattimysql.execute(string,{}, function(result) {
    });
}


RegisterServerEvent('stores:pay:cycle')
onNet('store:pay:cycle', async (storeList) => {

   storeList = JSON.parse(storeList)
   for (let key in storeList) {

       if (storeList[key].house_model == 4) {
           let trap = storeList[key]["trap"]
           let id = storeList[key]["dbid"]
           let name = storeList[key]["stash"]
           let storeName = storeList[key]["name"]
           let reputation = storeList [key]["reputation"]
           let luckyslot = 1
           let luckroll = mathrandom(1,100)
           let amount = 1
           let inventoryType = 'house_information'

           if (trap) {
               inventoryType = 'trap_houses'
           }

           let itemid = 0 
           let rolled = reputation + luckroll
           if (rolled > 96) {

           if (rolled > 120) {
               amount = 2
           }
           if (rolled > 150) {
               amount = 3
           }
           if (rolled > 180) {
               amount = 4
           }
           if (rolled > 149) {
               amount = 7
           }

           if (amount > 0) {
               let slot = mathrandom(1,2)
               let string = `SELECT item_id FROM user_inventory2 WHERE name = '${name}' and slot = '${slot}'`;
               exports.ghmattimysql.execute(string,{}, function(inventory) {
                   if (inventory.length > 0) {
                       emitNet("ai:storewalkout",-1,key)
                       if (amount > inventory.length) {
                           amount = inventory.length
                       }

                       let string = `DELETE FROM user_inventory2 WHERE name='${name}' and slot = '${slot}' LIMIT ${amount}`;

                       exports.ghmattimysql.execute(string,{}, function() {});

                       let itemid = inventory[0].item_id
                       let sellValue = itemList[itemid].price * amount

                       if (reputation < 10) {
                           sellValue = sellValue * 0.5
                       } else if (reputation < 20) {
                        sellValue = sellValue * 0.55
                       } else if (reputation < 30) {
                        sellValue = sellValue * 0.6
                       } else if (reputation < 50) {
                        sellValue = sellValue * 0.65
                       } else if (reputation < 70) {
                        sellValue = sellValue * 0.75
                       } else if (reputation < 80) {
                        sellValue = sellValue * 0.8
                       } else if (reputation < 90) {
                        sellValue = sellValue * 0.9

                       }

                       sellValue = Math.ceil(sellValue)

                       payStore(name,sellValue,itemid)
                       if (rolled == 100 && itemList[itemid].illegal) {
                           reputation = reputation + 1
                           if (reputation < 100) {
                               let string = `UPDATE ${inventoryType} SET reputation='${reputation}' WHERE id='${id}'`
                               exports.ghmattimysql.execute(string,{}, function() {});
                           }
                       }
                   } else {
                       if (reputation > 0 && mathrandom(1,100) > 98) {
                           reputation = reputation - 1
                            let string = `UPDATE ${inventoryType} SET reputation='${reputation}' WHERE id='${id}'`
                           exports.ghmattimysql.execute(string,{},function() {});
                       }
                   }
//
               });
           }
       }
   }
}
});


RegisterServerEvent("server-remove-item")
onNet("server-remove-item", async (player,itemidsent,amount,openedInv) => {
    functionRemoveAny(player, itemidsent, amount, openedInv)
});

RegisterServerEvent("server-update-item")
onNet("server-update-item", async (player, itemidsent,slot,data) => {
    let src = source
    let playerinvname = player
    let string = `UPDATE user_inventory2 SET information='${data}' WHERE item_id='${itemidsent}' and name='${playerinvname}' and slot='${slot}'`

    exports.ghmattimysql.execute(string,{}, function() {
        emit("server-request-update-src",player,src)
    });
});

function functionRemoveAny(player, itemidsent, amount, openedInv) {
    let src = source
    let playerinvname = player
    let string = `DELETE FROM user_inventory2 WHERE name='${playerinvname}' and item_id='${itemidsent}' LIMIT ${amount}`

    exports.ghmattimysql.execute(string,{},function() {
        emit("server-request-update-src",player,src)
    });
}

RegisterServerEvent("request-dropped-items")
onNet("request-dropped-items", async (player) => {
    let src = source;
    emitNet("requested-dropped-items", src, JSON.stringify(Object.assign({},DroppedInventories)));
});

RegisterServerEvent("server-request-update")
onNet("server-request-update", async (player) => {
    let src = source
    let playerinvname = player
    let string = `SELECT count(item_id) as amount, name, item_id, information, slot, dropped, creationDate FROM user_inventory2 where name= '${player}' group by slot`;// slot
    exports.ghmattimysql.execute(string, {}, function(inventory) {

    emitNet("inventory-update-player", src, [inventory,0,playerinvname]);
    // emitNet('inv:sendItemList',src,itemList)
    });
});

RegisterServerEvent("server-request-update-src")
onNet("server-request-update-src", async (player,src) => {
    let playerinvname = player // or < or *
    let string = `SELECT count(item_id) as amount, name, item_id, information, slot, dropped, creationDate FROM user_inventory2 where name= '${player}' group by slot`; // slot
    exports.ghmattimysql.execute(string, {}, function(inventory) {

    emitNet("inventory-update-player", src, [inventory,0,playerinvname]);
    });
});

function makeid(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghikjlmnopqrstuvwxyz'; //abcdef
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

// checked above 1 hour 2 minutes

function GenerateInformation(player,itemid,itemdata) {
    let data = Object.assign({}, itemdata);
    let returnInfo = "{}"

    return new Promise((resolve, reject) => {
    if (itemid == "") return resolve(returninfo);

    let timeout = 0;
    if (itemid == "") {
        var identifier = player.toString()
        if(itemdata && itemdata.fakeWeaponData) {
            identifier = Math.floor((Math.random() * 99999) + 1)
            identifier = identifier.toString()
        }

        let cartridgeCreated = player + "-" + makeid(3) + "-" + Math.floor((Math.random() * 999) + 1);
        returnInfo = JSON.stringify({ cartridge: cartridgeCreated, serial: identifier, quality: "Good"})
        timeout = 1;
        clearTimeout(timeout)
        return resolve(returnInfo);
    } else {
        switch(itemid.toLowerCase()) {
            case "idcard":
                let string = `SELECT first_name, last_name, dob, gender, id FROM __characters WHERE id = '${player.replace('ply-', '')}'`;
                exports.ghmattimysql.execute(string,{}, function(result) {
                    if (result[0].gender === 0) {
                        result[0].gender = "Male"
                    } else {
                        result[0].gender = "Female"
                    }
                    returnInfo = JSON.stringify({
                        Name: result[0].first_name.replace(/[^\w\s]/gi, ''),
                        Surname: result[0].last_name.replace(/[^\w\s]/gi, ''),
                        Sex: result[0].gender,
                        DOB: result[0].dob,
                        Identifier: result[0].id })
                        timeout = 1
                        clearTimeout(timeout)
                        return resolve(returnInfo);
                    });
                    break;
            case "casing":
                returnInfo = JSON.stringify({ Identifier: itemdata.identifier, type: itemdata.eType, other: itemdata.other})
                timeout = 1
                clearTimeout(timeout)
                return resolve(returnInfo);
            case "evidence":
                returnInfo = JSON.stringify({ Identifier:itemdata.identifier, type: itemdata.eType, other: itemdata.other })
                timeout = 1;
                clearTimeout(timeout)
                return resolve(returnInfo);
            case "backpack":
                returnInfo = JSON.stringify({ serial:player.replace("steam:", "") })
                timeout = 1;
                clearTimeout(timeout)
                return resolve(returnInfo);
            case "drivingtest":
                if (data.id) {
                    let string = `SELECT * FROM driving_tests WHERE id = '${data.id}'`;
                    exports.ghmattimysql.execute(string, {}, function(result) {
                        if (result[0]) {
                            let ts = new Date(parseInt(result[0].timestamp) * 1000)
                            let testDate = ts.getFullYear() + "-" + ("0"+(ts.getMonth()+1)).slice(-2) + "-" + ("0" + ts.getDate()).slice(-2)
                            returninfo = JSON.stringify({ ID: result[0].id, CID: result[0].cid, Instructor: result[0].instructor, Date: testdata })
                            timeout = 1;
                            clearTimeout(timeout)
                        }
                        return resolve(returninfo);
                    });
                } else {
                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                }
                break;
            default:
                timeout = 1
                clearTimeout(timeout)
                return resolve(returnInfo);
            }

            setTimeout(() => {
                if (timeout == 0) {
                    return resolve(returnInfo);
                }
            },500)
        }
    });
}
// checked
RegisterServerEvent("server-inventory-give")
onNet("server-inventory-give", async (player, itemid, slot, amount, generateInformation, itemdata, openedInv) => {
    let src = source
    let playerinvname = player
    let information = "{}"
    let creationDate = Date.now()
      if (generateInformation) {
          information = await GenerateInformation(player,itemid,itemdata)
      }
      let values = `('${playerinvname}','${itemid}','${information}','${slot}','${creationDate}')`
         if (amount > 1) {
             for (let i = 2; i <= amount; i++) {
                 values = values + `,('${playerinvname}','${itemid}','${information}','${slot}','${creationDate}')`
             }
         }

         let query = `INSERT INTO user_inventory2 (name,item_id,information,slot,creationDate) VALUES ${values};`
         exports.ghmattimysql.execute(query,{},function() {
             emit("server-request-update-src",player,src)
         });
});


RegisterServerEvent("server-inventory-open")
onNet("server-inventory-open", async ( coords, player, secondInventory, targetName, itemToDropArray, sauce) => {
    let src = source

    if (!src) {
        src = sauce 
    }
    let playerinvname = player

    if ( InUseInventories[targetName] || InUseInventories[playerinvname] ) {
        if (InUseInventories[playerinvname]) {
            if ( ( InUseInventories[playerinvname] != player ) ) {
                return
            } else {
               
            }
        }
        if (InUseInventories[targetName]) {
            if (InUseInventories[targetName] == player) {

            } else {
                secondInventory = "69"
            }
        }
    }
    sendClientItemList(src)
    let string = `SELECT count(item_id) as amount, name, item_id, information, slot, dropped, creationDate FROM user_inventory2 where name= '${player}' group by slot`;

    exports.ghmattimysql.execute(string,{}, function(inventory) {

        var invArray = inventory;
        var i;
        var arrayCount = 0;

           InUseInventories[playerinvname] = player;

           if(secondInventory == "1") {
               var targetinvname = targetName

               let string = `SELECT count(item_id) as amount, name, item_id, information, slot, dropped, creationDate FROM user_inventory2 WHERE name = '${targetinvname}' group by slot`;
               exports.ghmattimysql.execute(string,{}, function(inventory2) { 
                       emitNet("inventory-open-target", src, [invArray, arrayCount,playerinvname,inventory2,0,targetinvname,500,true]);
                       InUseInventories[targetinvname] = player
               });

           } else if (secondInventory == "3") {
               let Key = ""+DataEntries+"";
               let NewDroppedName = 'Drop-' + Key;

               DataEntries = DataEntries + 1
               var invArrayTarget = [];
               DroppedInventories[NewDroppedName] = { position: { x: coords[0], y: coords[1], z: coords[2] }, name: NewDroppedName, used: false, lastUpdated: Date.now() }


               InUseInventories[NewDroppedName] = player;
               invArrayTarget = JSON.stringify(invArrayTarget)
               emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,invArrayTarget,0,NewDroppedName,500,false]);
            //   db(`UPDATE user_inventory2 SET slot='${i+1}', name='${NewDroppedName}', dropped='1' WHERE name ='${Key}' and slot = ${objectToDrop.faultyslot} and item_id ='${objectToDrop.faultyItem}' `);
           
            // let Key = ""+DataEntries+"";
            // let objectToDrop = itemToDropArray[Key][i];
            // db(`UPDATE user_inventory2 SET slot='${i+1}', name='${NewDroppedName}', dropped='1' WHERE name ='${Key}' and slot = ${objectToDrop.faultyslot} and item_id ='${objectToDrop.faultyItem}' `);
            // console.log("We are dropping here???????????????")
}
 else if (secondInventory == "13")
{   
 
     let Key = ""+DataEntries+"";
     let NewDroppedName = 'Drop-'  + Key;
     DataEntries = DataEntries + 1
       for (let Key in itemToDropArray) {
           for (let i = 0; i < itemToDropArray[Key].length; i++) {
               let objectToDrop = itemToDropArray[Key][i];
               db(`UPDATE user_inventory2 SET slot='${i+1}', name='${NewDroppedName}', dropped='1' WHERE name='${Key}' and slot='${objectToDrop.faultySlot}' and item_id='${objectToDrop.faultyItem}' `);
          
            }
       }
       
      DroppedInventories[NewDroppedName] = { position: { x: coords[0], y: coords[1], z: coords[2] }, name: NewDroppedName, used: false, lastUpdated: Date.now() }
      emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[NewDroppedName] )
    } else if(secondInventory == "2") {
        var targetinvname = targetName;
        var shopArray = ConvenienceStore();
        var shopAmount = 17;
        emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
      //  console.log(invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname)
    }
    else if(secondInventory == "4")
{
    var targetinvname = targetName;
    var shopArray = HardwareStore();
    var shopAmount = 15;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}
    else if(secondInventory == "5")
    {
        var targetinvname = targetName;
        var shopArray = GunStore();
        var shopAmount = 14;
        emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}
    else if(secondInventory == "9")
{
    var targetinvname = targetName;
    var shopArray = GangStore();
    var shopAmount = 2;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}   
    else if(secondInventory == "10")
{
    var targetinvname = targetName;
    var shopArray = PoliceArmory();
    var shopAmount = 19;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}    
    else if(secondInventory == "12")
{
    var targetinvname = targetName;
    var shopArray = BurgieStore();
    var shopAmount = 2;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}    
   else if(secondInventory == "11")
{
    emitNet("inventory-open-target-NoInject", src, [invArray.arrayCount,playerinvname]);
}  else if(secondInventory == "14") {
    var targetinvname = targetName;
    var shopArray = CourtHouse();
    var shopAmount = 1;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}    
   else if(secondInventory == "15")
{
    var targetinvname = targetName;
    var shopArray = MedicArmory();
    var shopAmount = 7;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  
   else if(secondInventory == "29")
{
    var targetinvname = targetName;
    var shopArray = MedicArmoryCiv();
    var shopAmount = 1;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  
   else if(secondInventory == "16")
{
    var targetinvname = targetName;
    var shopArray = Workshop();
    var shopAmount = 2;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  
   else if(secondInventory == "17")
{
    var targetinvname = targetName;
    var shopArray = Smelting();
    var shopAmount = 1;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  
   else if(secondInventory == "18")
{
    var targetinvname = targetName;
    var shopArray = TacoTruck();
    var shopAmount = 14;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  
   else if(secondInventory == "22")
{
    var targetinvname = targetName;
    var shopArray = JailFood();
    var shopAmount = 2;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  
   else if(secondInventory == "23")
{
    var targetinvname = targetName;
    var shopArray = JailCraft();
    var shopAmount = 1;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  
   else if(secondInventory == "24")
{
    var targetinvname = targetName;
    var shopArray = JailWeapon();
    var shopAmount = 1;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  
   else if(secondInventory == "25")
{
    var targetinvname = targetName;
    var shopArray = JailMeth();
    var shopAmount = 1;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  
   else if(secondInventory == "26")
{
    var targetinvname = targetName;
    var shopArray = JailPhone();
    var shopAmount = 1;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}
   else if(secondInventory == "27")
{
    var targetinvname = targetName;
    var shopArray = JailSlushy();
    var shopAmount = 1;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}
   else if(secondInventory == "28")
{
    var targetinvname = targetName;
    var shopArray = InmateLottery();
    var shopAmount = 7;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
} else if(secondInventory == "30") {
    var targetinvname = targetName;
    var shopArray = MechCraft();
    var shopAmount = 6;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
} else if(secondInventory == "31") {
    var targetinvname = targetName;
    var shopArray = DrugShop();
    var shopAmount = 1;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
} else if(secondInventory == "32") {
    var targetinvname = targetName;
    var shopArray = BurgerShot();
    var shopAmount = 6;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
} else if(secondInventory == "33") {
    var targetinvname = targetName;
    var shopArray = CraftRifleCivilians();
    var shopAmount = 27;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
} else if(secondInventory == "34") {
    var targetinvname = targetName;
    var shopArray = PlantShop();
    var shopAmount = 7;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
} else if(secondInventory == "35") {
    var targetinvname = targetName;
    var shopArray = MaterialShop();
    var shopAmount = 8;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}

// drop an item for a player to pickup
   else if(secondInventory == "7")
{
    var targetinvname = targetName;
    var shopArray = DroppedItem(itemToDropArray);
    
    itemToDropArray = JSON.parse(itemToDropArray)
    var shopAmount = itemToDropArray.length;
     
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}
else {
    emitNet("inventory-update-player", src, [invArray,arrayCount,playerinvname]);
}
});
});

// checked below 

RegisterServerEvent("server-inventory-close")
onNet("server-inventory-close", async (player, targetInventoryName) => {
    let src = source
    //line 647
    if(targetInventoryName.startsWith("Trunk"))
       emitNet("toggle-animation", src, false);
    InUseInventories = InUseInventories.filter(item => item != player);
    if (targetInventoryName.indexOf("Drop") > -1 && DroppedInventories[targetInventoryName]) {
        if (DroppedInventories[targetInventoryName].used === false ) {
             delete DroppedInventories[targetInventoryName];
        } else {
            let string = `SELECT count(item_id) as amount, item_id, name, information, slot, dropped FROM user_inventory2 WHERE name='${targetInventoryName}' group by item_id `;
            exports.ghmattimysql.execute(string,{}, function(result) {
                if (result.length == 0 && DroppedInventories[targetInventoryName]) {
                    delete DroppedInventories[targetInventoryName];
                    emitNet("Inventory-Dropped-Remove", -1, [targetInventoryName])
                }
            });
        }
    }
    sendClientItemList(src)
    emit("server-request-update-src", player, src) 
});


RegisterServerEvent("server-request.removeCraftItems")
onNet("server-inventory.removeCraftItems", async (player, data, coords, openedInv) => {
    // remove items here from crafting
});

let IllegalSearchString = `'weedoz', 'weed5oz', 'coke50g', 'thermite', 'weedq', 'weed12oz', 'oxy', '1gcrack', '1gcocaine', 'joint'`

// checked below

RegisterServerEvent("sniffAccepted")
onNet("sniffAccepted", async (t) => {
    let src = source 
     emitNet('sniffAccepted', t, src)
});


RegisterServerEvent("SniffCID")
onNet("SniffCID", async (cid,src) => {
   
    let name = cid;
    let string = `SELECT count(item_id) as amount, item_id, name, information, slot, dropped FROM user_inventory2 WHERE name='${name}' and item_id IN (${IllegalSearchString}) group by item_id`;

    exports.ghmattimysql.execute(string, {}, function(items) {
        if (item.length > 0) {
            emitNet("k9:SniffConfirmed", src)
        } else {
            emitNet("k9:SniffConfirmedFail", src)
        }
    });
});

// all checked below all correct!
RegisterServerEvent("sniffLicensePlateCheck") 
onNet("sniffLicensePlateCheck", async (plate) => {
     let src = source
     let car = 'Truck-'+plate 
     let glovebox = 'Glovebox-'+plate

     let string = `SELECT count(item_id) as amount, item_id, name, information, slot, dropped FROM user_inventory2 WHERE name='${car}' OR name='${glovebox}') and item_id IN (${IllegalSearchString}) group by item_id`;

     exports.ghmattimysql.execute(string,{}, function(item) {
         if (item.lenth > 0) {
            emitNet("k9:SniffConfirmed", src)
        } else {
            emitNet("k9:SniffConfirmedFail", src)
          }
     });
}); // done an checked 44.45 on stream.

RegisterServerEvent("inv:delete")
onNet("inv:delete", async (inv) => {
    db(`DELECT FROM user_inventory2 WHERE name='${inv}'`);
});

RegisterServerEvent("server-inventory-remove")
onNet("server-inventory-remove-slot", async (player, itemidsent,amount,slot) => {
    var playerinvname = player
    db(`DELETE FROM user_inventory2 WHERE name='${playerinvname}' and item_id='${itemidsent}' and slot='${slot}' LIMIT ${amount}`);
});

RegisterServerEvent("server-ragdoll-items") 
onNet("server-ragdoll-items", async (player) => {
     let currInventoryName = `${player}`
     let newInventoryName = `wait-${player}`

     db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="mobilephone" `);
     db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="idcard" `);

    await db(`DELETE FROM user_inventory2 WHERE name='${currInventoryName}'`);

    db(`UPDATE user_inventory2 SET name='${currInventoryName}', WHERE name='${newInventoryName}' and dropped=0`);
});


RegisterServerEvent('server-jail-item')
onNet("server-jail-item", async (player,isSentToJail) => {
    let currInventoryName = `${player}`
    let newInventoryName = `${player}`

    if(!isSentToJail) {
        currInventoryName = `${player}`
        newInventoryName = `jail-${player}`
    } else {
        currInventoryName = `jail-${player}`
        newInventoryName = `${player}`
    }

    db(`UPDATE user_inventory2 SET name='${currInventoryName}', WHERE name='${newInventoryName}' and dropped=0`);
});

function removecash(src,amount) {
    emit('cash:remove',src,amount)
}

onNet("onResourceStart", async (resource) => {
    if (resource == GetCurrentResourceName()) {
        CleanDroppedInventory()
    }
})


function sendClientItemList(src)
{
    emitNet('inv:sendItemList',src,itemList)
}


function DroppedItem(itemArray) {
    itemArray = JSON.parse(itemArray)
    var shopItems = [];

    shopItems[0] = { item_id: itemArray[0].itemid, id: 0, name: "shop", information: "{}", slot: 1, amount: itemArray[0].amount};

    return JSON.stringify(shopItems);
}
function BuildInventory(Inventory) {
    let buildInv = Inventory
    let invArray = {};
    itemCount = 0;
    for (let i = 0; i < buildInv.length; i++) {
        invArray[itemCount] = { item_id: buildInv[i].item_id, id: buildInv[i].id, name: buildInv[i].name, information: buildInv[i], slot: buildInv[i].slot};
        itemCount = itemCount + 1
    }
    return [JSON.stringify(invArray),itemCount]
}

function mathrandom(min, max) {
    return Math.floor(Math.random() * (max+1 - min) ) + min;
}


const DEGREDATION_INVENTORY_CHECK = 1000 * 60 * 60;
const DEGREDATION_TIME_BROKEN = 1000 * 60 * 40320;
const DEGREDATION_TIME_WORN = 1000 * 60 * 201000;


function payStore(storeName,amount,itemid) {

   if (storeName.indexOf("Traphouse") > -1 ) {
       let id = storeName.split('|')

       id = id[0].split('-')[1]

       emit('traps:pay',id,amount)
   } else {
       
       let cid = storeName.split('|')
       let name = cid[1]
       if (itemList[itemid].illegal && mathrandom(1,100) > 80) {
     //      emitNet('IllegalSale',"Store Owner", name)
       }
       cid = cid[0].split('-')[1]
       emit('server:PayStoreOwner', cid, amount)
   }
}//



RegisterServerEvent("server-inventory-move")
onNet("server-inventory-move", async (player, data, coords) => {
    let targetslot = data[0]
    let startslot = data[1]
    let targetname = data[2].replace(/"/g, "");
    let startname = data[3].replace(/"/g, "");
    let purchase = data[4]
    let itemCosts = data[5]
    let itemidsent = data[6]
    let amount = data[7]
    let crafting = data[8]
    let isWeapon = data[9]
    let PlayerStore = data[10]
    let creationDate = Date.now()

    if ((targetname.indexOf("Drop") > -1 || targetname.indexOf("hidden") > -1) && DroppedInventories[targetname]) {
        if (isWeapon) {
            emitNet('actionbar:setEmptyHanded', source)
        }

        if (DroppedInventories[targetname].used === false) {

            DroppedInventories[targetname] = { position: { x: coords[0], y: coords[1], z: coords[2]}, name: targetname, used: true, lastUpdated: Date.now() }
            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[targetname] )
        }
    }

    let info = "{}"

    if (purchase) {
        if(isWeapon) {

        }
        info = await GenerateInformation(player,itemidsent)
        removecash(source,itemCosts)
        emit("inventory:takeMyCash", source,itemCosts)
        if (!PlayerStore) {
            for (let i = 0; i < parseInt(amount); i++) {
                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetname}','${info}','${targetslot}','${creationDate}' );`);
            }
        } else if (PlayerStore) { // ! at the start 
            // payStore(startname, itemCosts, itemidsent)
             payStore(startname,itemCosts,itemidsent)
                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetname}','${info}','${targetslot}','${creationDate}' );`);

            for (let i = 0; i < parseInt(amount); i++) {
                db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetname}', dropped='0' WHERE slot='${startslot}' and name='${startname}'`);
            }
        } else if (crafting) {
            info - await GenerateInformation(player,itemidsent)
            for (let i = 0; i < parseInt(amount); i++) {
                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetname}','${info}','${targetslot}','${creationDate}' );`);
            }
        } else {
            if (targetname.indexOf("Drop") > -1 || targetname.indexOf("hidden") > -1) {   
            db(`INSERT INTO user_inventory2 SET slot='${targetslot}', name='${targetname}', dropped='1' WHERE slot='${startslot}' AND name='${startname}'`);
            if (isWeapon) {
                emitNet('actionbar:setEmptyHanded', source)
            }
           } else {
            db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetname}', dropped='1' WHERE slot='${startslot}' and name='${startname}'`);
           }
        }
     } else if (targetname.indexOf("Drop") > -1 || targetname.indexOf("hidden") > -1) { 
        db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetname}', dropped='1' WHERE slot='${startslot}' and name='${startname}'`);
        if (isWeapon) {
            emitNet('actionbar:setEmptyHanded', source)
        }

     } else
        {
            // db(`UPDATE user_inventory2 SET slot='${targetSlot}', name='${targetInventory}', dropped='0' WHERE slot='${originSlot}' and name='${originInventory}'`);
            db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetname}', dropped='0' WHERE slot='${startslot}' and name='${startname}'`);
        }
});
const DROPPED_ITEM_KEEP_ALIVE = 1000 * 60 * 15; // 15 MINUTES
// check above and all right 

function clean() {
    for (let Row in DroppedInventories) {
        if (new Date(DroppedInventories[Row].lastUpdated + DROPPED_ITEM_KEEP_ALIVE).getTime() < Date.now() && DroppedInventories[Row].used && !InUseInventories[DroppedInventories[Row].name]) {
               emitNet("Inventory-Dropped-Remove", -1, [DroppedInventories[Row].name])
               delete DroppedInventories[Row];
        }
    }
}

setInterval(clean, 20000)

function CleanDroppedInventory() {
    db(`DELETE FROM user_inventory2 WHERE dropped='1'`);
    db(`DELETE FROM user_inventory2 WHERE name='trash-1'`);
};


RegisterServerEvent("server-inventory-stack")
onNet("server-inventory-stack", async (player, data, coords) => {
    let targetslot = data[0]
         let moveAmount = data[1]
    let targetName = data[2].replace(/"/g, "");
    let src = source
     let originSlot = data[3]

     let originInventory = data[4].replace(/"/g, "");

     let purchase = data[5]
     let itemCosts = data[6]
    let itemidsent = data[7]
     let amount = data[8]
     let crafting = data[9]
     let isWeapon = data[10]
     let PlayerStore = data[11]
     let creationDate = Date.now()

     if ( (targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) && DroppedInventories[targetName] ) {
        if (isWeapon) {
            emitNet('actionbar:setEmptyHanded', source)
        }

         if (DroppedInventories[targetName].used === false ) {
             DroppedInventories[targetName] =  { position: { x: coords[0], y: coords[1], z: coords[2] }, name: targetName, used: true, lastUpdated: Date.now() }
             emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[targetName] )
         }
     }

     let info = "{}"

     if (purchase) {

         if (isWeapon) {
         }
         info = await GenerateInformation(player,itemidsent)
         removecash(source,itemCosts)

         if (!PlayerStore) {
             for (let i = 0; i < parseInt(amount); i++) {

              db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}')`);

             }
         }
    

         if (PlayerStore) {
             let string = `SELECT item_id FROM user_inventory2 WHERE slot='${originSlot}' and name='${originInventory}'`; //LIMIT ${moveAmount}
             payStore(originInventory,itemCosts,itemidsent)
             exports.ghmattimysql.execute(string,{}, function(startid) {
                for (let i = 0; i < parseInt(amount); i++) {
                    db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
                }
           
             });
         }


     } else if (crafting) {
         info = await GenerateInformation(player,itemidsent)
         for (let i = 0; i < parseInt(amount); i++) {

             db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
         }
     } else {
         let string = `SELECT item_id, creationDate FROM user_inventory2 WHERE slot='${originSlot}' and name='${originInventory}'`;

         exports.ghmattimysql.execute(string,{}, function(result) {

             if (targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) {
                db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='1' WHERE slot='${originSlot}' and name='${originInventory}' LIMIT ${moveAmount}`);
                if (isWeapon) {
                    emitNet('actionbar:setEmptyHanded', source)
                }

             } else {
                db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='0' WHERE slot='${originSlot}' and name='${originInventory}' LIMIT ${moveAmount}`);

             }
         });
     }
 });

RegisterServerEvent("server-inventory-swap")
onNet("server-inventory-swap", (player, data, coords) => {
    let targetSlot = data[0]
    let targetName = data[1].replace(/"/g, "");

    let originSlot = data[2]
    let originInventory = data[3].replace(/"/g, "")
    if (targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) {
        let string = `SELECT item_id FROM user_inventory2 WHERE slot='${targetSlot}' and name='${targetName}'`;
        let string2 = `SELECT item_id FROM user_inventory2 WHERE slot='${originSlot}' and name='${originInventory}'`;
        exports.ghmattimysql.execute(string,{}, function(result) {
            let string2 = `UPDATE user_inventory2 SET slot='${originSlot}', name='${originInventory}', dropped='0' WHERE slot='${targetSlot}' and name='${targetName}' and item_id='${result[0].item_id}'`
            exports.ghmattimysql.execute(string2,{}, function(result) {
            })
        });
        exports.ghmattimysql.execute(string2,{}, function(result) {
        let string3 = `UPDATE user_inventory2 SET slot='${targetSlot}', name='${targetName}', dropped='0' WHERE slot='${originSlot}' and name='${originInventory}' and item_id='${result[0].item_id}'`
            exports.ghmattimysql.execute(string3,{}, function(result) {
            })
        });
    } else {
        let string = `SELECT item_id FROM user_inventory2 WHERE slot='${targetSlot}' and name='${targetName}'`;
        let string2 = `SELECT item_id FROM user_inventory2 WHERE slot='${originSlot}' and name='${originInventory}'`;
        exports.ghmattimysql.execute(string,{}, function(result) {
            let string2 = `UPDATE user_inventory2 SET slot='${originSlot}', name='${originInventory}', dropped='0' WHERE slot='${targetSlot}' and name='${targetName}' and item_id='${result[0].item_id}'`
            exports.ghmattimysql.execute(string2,{}, function(result) {
            })
        });
        exports.ghmattimysql.execute(string2,{}, function(result) {
        let string3 = `UPDATE user_inventory2 SET slot='${targetSlot}', name='${targetName}', dropped='0' WHERE slot='${originSlot}' and name='${originInventory}' and item_id='${result[0].item_id}'`
            exports.ghmattimysql.execute(string3,{}, function(result) {
            })
        });
    }
});

function PoliceArmory() {
    var shopItems = [
        { item_id: "-1075685676", id: 0, name: "Shop", information: "{}", slot: 1, amount: 1 },
        { item_id: "-771403250", id: 0, name: "Shop", information: "{}", slot: 2, amount: 1 },
        { item_id: "-2084633992", id: 0, name: "Shop", information: "{}", slot: 3, amount: 1 },
        { item_id: "-86904375", id: 0, name: "Shop", information: "{}", slot: 4, amount: 1 },
        { item_id: "1432025498", id: 0, name: "Shop", information: "{}", slot: 5, amount: 1 },
        { item_id: "2024373456", id: 0, name: "Shop", information: "{}", slot: 6, amount: 1 },
        { item_id: "2210333304", id: 0, name: "Shop", information: "{}", slot: 7, amount: 1 },
        { item_id: "3219281620", id: 0, name: "Shop", information: "{}", slot: 8, amount: 1 },
        { item_id: "487013001", id: 0, name: "Shop", information: "{}", slot: 9, amount: 1 },
        { item_id: "736523883", id: 0, name: "Shop", information: "{}", slot: 10, amount: 1 },
        { item_id: "911657153", id: 0, name: "Shop", information: "{}", slot: 11, amount: 1 },
        { item_id: "2343591895", id: 0, name: "Shop", information: "{}", slot: 12, amount: 1 },
        { item_id: "shotgunammo", id: 0, name: "Shop", information: "{}", slot: 13, amount: 50 },
        { item_id: "pistolammo", id: 0, name: "Shop", information: "{}", slot: 14, amount: 50 },
        { item_id: "subammo", id: 0, name: "Shop", information: "{}", slot: 15, amount: 50 },
        { item_id: "rifleammo", id: 0, name: "Shop", information: "{}", slot: 16, amount: 50 },
        { item_id: "IFAK", id: 0, name: "Shop", information: "{}", slot: 17, amount: 50 },
        { item_id: "armor", id: 0, name: "Shop", information: "{}", slot: 18, amount: 50 },
        { item_id: "radio", id: 0, name: "Shop", information: "{}", slot: 19, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function MedicArmory() {
    var shopItems = [
        { item_id: "bandage", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
        { item_id: "radio", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
        { item_id: "oxy", id: 0, name: "Shop", information: "{}", slot: 3, amount: 50 },
        { item_id: "MedicalBag", id: 0, name: "Shop", information: "{}", slot: 4, amount: 50 },
        { item_id: "chips", id: 0, name: "Shop", information: "{}", slot: 5, amount: 50 },
        { item_id: "donut", id: 0, name: "Shop", information: "{}", slot: 6, amount: 50},
        { item_id: "coffee", id: 0, name: "Shop", information: "{}", slot: 7, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function MedicArmoryCiv() {
    var shopItems = [
        { item_id: "bandage", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function InMateLottery() {
    var shopItems = [
        { item_id: "idcard", id: 0, name: "Craft", information: "{}", slot: 1, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function JailFood() {
    var shopItems = [
        { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function JailWeapon() {
    var shopItems = [
        { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function JailMeth() {
    var shopItems = [
        { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function JailPhone() {
    var shopItems = [
        { item_id: "idcard", id: 0, name: "Craft", information: "{}", slot: 1, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function JailSlushy() {
    var shopItems = [
        { item_id: "idcard", id: 0, name: "Craft", information: "{}", slot: 1, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function Smelting() {
    var shopItems = [
        { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

// stores
function ConvenienceStore() {
    var shopItems = [
        { item_id: "water", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50, price: 3 },
        { item_id: "mobilephone", id: 0, name: "Shop", information: "{}", slot: 2, amount: 1, price: 3 },
        { item_id: "bandage", id: 0, name: "Shop", information: "{}", slot: 3, amount: 50, price: 3 },
        { item_id: "sandwich", id: 0, name: "Shop", information: "{}", slot: 4, amount: 50, price: 3 },
        { item_id: "ciggy", id: 0, name: "Shop", information: "{}", slot: 5, amount: 50, price: 3 },
        { item_id: "chips", id: 0, name: "Shop", information: "{}", slot: 6, amount: 50, price: 3 },
        { item_id: "donut", id: 0, name: "Shop", information: "{}", slot: 7, amount: 50, price: 3 },
        { item_id: "coffee", id: 0, name: "Shop", information: "{}", slot: 8, amount: 50, price: 3 },
        { item_id: "rollingpaper", id: 0, name: "Shop", information: "{}", slot: 9, amount: 50, price: 3 },
        { item_id: "foodingredient", id: 0, name: "Shop", information: "{}", slot: 10, amount: 10, price: 3 },
        { item_id: "glucose", id: 0, name: "Shop", information: "{}", slot: 11, amount: 50, price: 50 },
        { item_id: "bakingsoda", id: 0, name: "Shop", information: "{}", slot: 12, amount: 50, price: 50 },
        { item_id: "beer", id: 0, name: "Shop", information: "{}", slot: 13, amount: 50, price: 3 },
        { item_id: "vodka", id: 0, name: "Shop", information: "{}", slot: 14, amount: 50, price: 50 },
        { item_id: "whiskey", id: 0, name: "Shop", information: "{}", slot: 15, amount: 50, price: 50 },
        { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 16, amount: 50, price: 50 },
        { item_id: "notepad", id: 0, name: "Shop", information: "{}", slot: 17, amount: 50, price: 50 },
    ];
    return JSON.stringify(shopItems);
}

function HardwareStore() {
    var shopItems = [
        { item_id: "repairkit", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
        { item_id: "oxygentank", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
        { item_id: "binoculars", id: 0, name: "Shop", information: "{}", slot: 3, amount: 50 },
        { item_id: "cuffs", id: 0, name: "Shop", information: "{}", slot: 4, amount: 50 },
        { item_id: "keya", id: 0, name: "Shop", information: "{}", slot: 5, amount: 50 },
        { item_id: "mk2usbdevice", id: 0, name: "Shop", information: "{}", slot: 6, amount: 50 },
        { item_id: "shotgunammo", id: 0, name: "Shop", information: "{}", slot: 7, amount: 50 },
        { item_id: "armor", id: 0, name: "Shop", information: "{}", slot: 8, amount: 50 },
        { item_id: "pistolammo", id: 0, name: "Shop", information: "{}", slot: 9, amount: 50 },
        { item_id: "bandage", id: 0, name: "Shop", information: "{}", slot: 10, amount: 50 },
        { item_id: "lsdtab", id: 0, name: "Shop", information: "{}", slot: 11, amount: 50 },
        { item_id: "radio", id: 0, name: "Shop", information: "{}", slot: 12, amount: 50 },
        { item_id: "badlsdtab", id: 0, name: "Shop", information: "{}", slot: 13, amount: 50 },
        { item_id: "heavydutydrill", id: 0, name: "Shop", information: "{}", slot: 14, amount: 50 },
        { item_id: "fishingrod", id: 0, name: "Shop", information: "{}", slot: 15, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function BurgiesStore() {
    var shopItems = [
         { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
        { item_id: "bandage", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function BurgerShot() {
    var shopItems = [
         { item_id: "fries", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
        { item_id: "bleederburger", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
        { item_id: "heartstopper", id: 0, name: "Shop", information: "{}", slot: 3, amount: 50 },
        { item_id: "torpedo", id: 0, name: "Shop", information: "{}", slot: 4, amount: 50 },
        { item_id: "meatfree", id: 0, name: "Shop", information: "{}", slot: 5, amount: 50 },
        { item_id: "moneyshot", id: 0, name: "Shop", information: "{}", slot: 6, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function GangStore() {
    var shopItems = [
          { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
        { item_id: "bandage", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function GangRepStore() {
    var shopItems = [
          { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
        { item_id: "bandage", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
    ];
    return JSON.stringify(shopItems);
};

function TacoTruck() {
    var shopItems = [
          { item_id: "icecream", id: 0, name: "craft", information: "{}", slot: 1, amount: 50 },
          { item_id: "hotdog", id: 0, name: "craft", information: "{}", slot: 2, amount: 50 },
          { item_id: "water", id: 0, name: "craft", information: "{}", slot: 3, amount: 50 },
          { item_id: "greencow", id: 0, name: "craft", information: "{}", slot: 4, amount: 50 },
          { item_id: "donut", id: 0, name: "craft", information: "{}", slot: 5, amount: 50 },
          { item_id: "eggsbacon", id: 0, name: "craft", information: "{}", slot: 6, amount: 50 },
          { item_id: "hamburger", id: 0, name: "craft", information: "{}", slot: 7, amount: 50 },
          { item_id: "burrito", id: 0, name: "craft", information: "{}", slot: 8, amount: 50 },
          { item_id: "coffee", id: 0, name: "craft", information: "{}", slot: 9, amount: 50 },
          { item_id: "sandwich", id: 0, name: "craft", information: "{}", slot: 10, amount: 50 },
          { item_id: "fishtaco", id: 0, name: "craft", information: "{}", slot: 11, amount: 50 },
          { item_id: "mshake", id: 0, name: "craft", information: "{}", slot: 12, amount: 50 },
          { item_id: "taco", id: 0, name: "craft", information: "{}", slot: 13, amount: 50 },
          { item_id: "churro", id: 0, name: "craft", information: "{}", slot: 14, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function Workshop() {
    var shopItems = [
          { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
        { item_id: "bandage", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
    ];
    return JSON.stringify(shopItems);
};

function GunStore() {
    var shopItems = [
        { item_id: "453432689", id: 0, name: "Shop", information: "{}", slot: 1, amount: 1 },
        { item_id: "pistolammo", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
        { item_id: "2343591895", id: 0, name: "Shop", information: "{}", slot: 3, amount: 1 },
        { item_id: "2508868239", id: 0, name: "Shop", information: "{}", slot: 4, amount: 1 },
        { item_id: "2227010557", id: 0, name: "Shop", information: "{}", slot: 5, amount: 1 },
        { item_id: "4192643659", id: 0, name: "Shop", information: "{}", slot: 6, amount: 1 },
        { item_id: "4191993645", id: 0, name: "Shop", information: "{}", slot: 7, amount: 1 },
        { item_id: "-1810795771", id: 0, name: "Shop", information: "{}", slot: 8, amount: 1 },
        { item_id: "1141786504", id: 0, name: "Shop", information: "{}", slot: 9, amount: 1 },
        { item_id: "1317494643", id: 0, name: "Shop", information: "{}", slot: 10, amount: 1 },
        { item_id: "2460120199", id: 0, name: "Shop", information: "{}", slot: 11, amount: 1 },
        { item_id: "3713923289", id: 0, name: "Shop", information: "{}", slot: 12, amount: 1 },
        { item_id: "419712736", id: 0, name: "Shop", information: "{}", slot: 13, amount: 1 },
        { item_id: "940833800", id: 0, name: "Shop", information: "{}", slot: 14, amount: 1 },

    ];
    return JSON.stringify(shopItems);
};

function MechCraft() {
    var shopItems = [
        { item_id: "advrepairkit", id: 0, name: "craft", information: "{}", slot: 1, amount: 50 },
        { item_id: "lockpick", id: 0, name: "craft", information: "{}", slot: 2, amount: 50 },
        { item_id: "advlockpick", id: 0, name: "craft", information: "{}", slot: 3, amount: 50 },
        { item_id: "repairtoolkit", id: 0, name: "craft", information: "{}", slot: 4, amount: 50 },
        { item_id: "nitrous", id: 0, name: "craft", information: "{}", slot: 5, amount: 50 },
        { item_id: "tuner", id: 0, name: "craft", information: "{}", slot: 6, amount: 50 },

    ];
    return JSON.stringify(shopItems);
};

function DrugShop() {
    var shopItems = [
        { item_id: "usbdevice", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },

    ];
    return JSON.stringify(shopItems);
};

function MaterialShop() {
    var shopItems = [
        { item_id: "aluminium", id: 0, name: "Craft", information: "{}", slot: 1, amount: 50 },
        { item_id: "plastic", id: 0, name: "Craft", information: "{}", slot: 2, amount: 50 },
        { item_id: "copper", id: 0, name: "Craft", information: "{}", slot: 3, amount: 50 },
        { item_id: "electronics", id: 0, name: "Craft", information: "{}", slot: 4, amount: 50 },
        { item_id: "rubber", id: 0, name: "Craft", information: "{}", slot: 5, amount: 50 },
        { item_id: "scrapmetal", id: 0, name: "Craft", information: "{}", slot: 6, amount: 50 },
        { item_id: "steel", id: 0, name: "Craft", information: "{}", slot: 7, amount: 50 },
        { item_id: "backpack", id: 0, name: "Craft", information: "{}", slot: 8, amount: 50 },

    ];
    return JSON.stringify(shopItems);
};

function CraftRifleCivilians() {
    var shopItems = [
        { item_id: "-1121678507", id: 0, name: "Craft", information: "{}", slot: 1, amount: 50 },
        { item_id: "2017895192", id: 0, name: "Craft", information: "{}", slot: 2, amount: 50 },
        { item_id: "1593441988", id: 0, name: "Craft", information: "{}", slot: 3, amount: 50 },
        { item_id: "subammo", id: 0, name: "Craft", information: "{}", slot: 4, amount: 50 },
        { item_id: "584646201", id: 0, name: "Craft", information: "{}", slot: 5, amount: 50 },
        { item_id: "-771403250", id: 0, name: "Craft", information: "{}", slot: 6, amount: 50 },
        { item_id: "1649403952", id: 0, name: "Craft", information: "{}", slot: 7, amount: 50 },
        { item_id: "rifleammo", id: 0, name: "Craft", information: "{}", slot: 8, amount: 50 },
        { item_id: "-619010992", id: 0, name: "Craft", information: "{}", slot: 9, amount: 50 },
        { item_id: "137902532", id: 0, name: "Craft", information: "{}", slot: 10, amount: 50 },
        { item_id: "-2066285827", id: 0, name: "Craft", information: "{}", slot: 11, amount: 50 },
        { item_id: "rifleammo", id: 0, name: "Craft", information: "{}", slot: 12, amount: 50 },
        { item_id: "extended_ap", id: 0, name: "Craft", information: "{}", slot: 13, amount: 50 },
        { item_id: "extended_micro", id: 0, name: "Craft", information: "{}", slot: 14, amount: 50 },
        { item_id: "extended_sns", id: 0, name: "Craft", information: "{}", slot: 15, amount: 50 },
        { item_id: "extended_tec9", id: 0, name: "Craft", information: "{}", slot: 16, amount: 50 },
        { item_id: "silencer_l", id: 0, name: "Craft", information: "{}", slot: 17, amount: 50 },
        { item_id: "silencer_l2", id: 0, name: "Craft", information: "{}", slot: 18, amount: 50 },
        { item_id: "silencer_s", id: 0, name: "Craft", information: "{}", slot: 19, amount: 50 },
        { item_id: "silencer_s2", id: 0, name: "Craft", information: "{}", slot: 20, amount: 50 },
        { item_id: "SmallScope", id: 0, name: "Craft", information: "{}", slot: 21, amount: 50 },
        { item_id: "1627465347", id: 0, name: "Craft", information: "{}", slot: 22, amount: 50 },
        { item_id: "2937143193", id: 0, name: "Craft", information: "{}", slot: 23, amount: 50 },
        { item_id: "2144741730", id: 0, name: "Craft", information: "{}", slot: 24, amount: 50 },
        { item_id: "heavyammo", id: 0, name: "Craft", information: "{}", slot: 25, amount: 50 },
        { item_id: "615608432", id: 0, name: "Craft", information: "{}", slot: 26, amount: 50 },
        { item_id: "rifleammo", id: 0, name: "Craft", information: "{}", slot: 27, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function PlantShop() {
    var shopItems = [
        { item_id: "plantpot", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
        { item_id: "wateringcan", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
        { item_id: "purifiedwater", id: 0, name: "Shop", information: "{}", slot: 3, amount: 50 },
        { item_id: "lowgradefert", id: 0, name: "Shop", information: "{}", slot: 4, amount: 50 },
        { item_id: "highgradefert", id: 0, name: "Shop", information: "{}", slot: 5, amount: 50 },
        { item_id: "dopebag", id: 0, name: "Shop", information: "{}", slot: 6, amount: 50 },
        { item_id: "drugscales", id: 0, name: "Shop", information: "{}", slot: 7, amount: 50 },
    ];
    return JSON.stringify(shopItems);
}

function CraftBikerStoreGangs() {
    var shopItems = [
          { item_id: "idcard", id: 0, name: "Shop", information: "{}", slot: 1, amount: 50 },
        { item_id: "bandage", id: 0, name: "Shop", information: "{}", slot: 2, amount: 50 },
    ];
    return JSON.stringify(shopItems);
};
