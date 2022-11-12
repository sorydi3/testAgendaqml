import QtQuick
//import QtQuick.LocalStorage 2.0

Window {

    width: 640
    height: 480
    visible: true
    title: qsTr("Agenda")

    property var db;


    Rectangle {
        id:ventana
        anchors.fill: parent
        color: "#b0ff57"


        gradient: Gradient {
            GradientStop { position: 0.0; color: "#b0ff57" }
            GradientStop { position: 1.0; color: "#32cb00" }
        }


        MyButton{

            id : sButton
            titleButton : "Buscar"


            anchors{
             right:agenda.right
             bottom: agenda.top
             bottomMargin: 10
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    console.log("mouse clicked");

                     if(nombre.inputText === ""){
                         console.log("no hay nombre");
                     }else{
                         serchElement();
                     }

            }
         }

        }

        MyButton{
           id:idGuardar
           width: 250
           anchors{
               top: agenda.bottom
               left: agenda.left
               topMargin: 10
           }


        }

        Text {
               id: title
               text: qsTr("AGENDA")
               font.family: "Segoe UI Black"
               font.pointSize: 15
               anchors{
                    top: ventana.top
                    left: ventana.left
                    margins: 15
               }
           }

        Column {

               id:agenda
               y:60
               width: parent.width-30


               anchors.margins: 5

               spacing: 15

               anchors.centerIn: parent


               LabelAndInput{
                   id : nombre
                   z:1
               }

               Rectangle{
                   color: "#b0ff57"
                   height: 30
                   width: parent.width

               }

               LabelAndInput{
                   id : contacto


               }

               LabelAndInput{
                  id: address

               }

           }

  /*
        function createDataBase() {
       //create the database
       db = LocalStorage.openDatabaseSync("evendatabase","1.0","this database store data related to events",2000)

       // create the database where the data will be stored
       db.transaction((tx) =>{
           var sentencia = 'CREATE TABLE IF NOT EXIST eventtable(nombre TEXT,address TEXT,number TEXT)';
           tx.executeSql(sentencia);
       });
   }


   function insertEvent (){

       var sentencia = "INSERT INTO even VALUES(?,?,?)";

       var object;
       object.name = nombre.inputText
       object.contact = contacto.inputText
       object.address = address.inputText

         db.transaction((tx) => {
              tx.executeSql(sentencia,[nombre.text,contacto.text,address.text]);
         });
  }


   function deleteEvent(){
       var sentecia = "DELETE FROM eventtable WHERE nombre = ?"
       db.transaction((tx)=>{tx.executeSql(sentencia,[nombre.text])})

   }

   function serchElement() {
        var sentencia = "SELECT * FROM eventtable WHERE nombre = ?";
        var result = db.transactionSql(sentencia,[nombre.text]);

        if(result.rows.length > 0){
            var row = result.rows.item(0);
            nombre.inputText = row.nombre;
        }else{
            address.visible =  true
            address.visible =  true
            console.log("no se encontro el elemento");
        }

   }

   function updateEvent(){
         var sentencia = "UPDATE eventtable SET nombre = ?, address = ?, number = ? WHERE nombre = ?";
         db.transaction((tx) => {
              tx.executeSql(sentencia,[nombre.text,contacto.text,address.text,nombre.text]);
         });
    }


    Component{
        //progress: real
        //status: enumeration
        //url: url
        onCompleted: { 
            //initialize the database
            createDataBase();
        }
        //onDestruction: { }
     }
     */

    }



}

