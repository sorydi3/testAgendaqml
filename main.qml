import QtQuick
import QtQuick.LocalStorage 2.0

Window {

    width: 640
    height: 480
    visible: true
    title: qsTr("Agendav.0")




    Rectangle {
        id:ventana
        anchors.fill: parent
        color: "#b0ff57"


        property int duration: 5000

        property var db;


        gradient: Gradient {
            GradientStop { position: 0.0; color: "#b0ff57" }
            GradientStop { position: 1.0; color: "#32cb00" }
        }

        Rectangle {
             id: ball

             width: 900
             height: 900

             gradient: Gradient {
                 GradientStop { position: 0.0; color: "#b0ff57" }
                 GradientStop { position: 1.0; color: "#32cb00" }
             }

             x : 0
             y : ventana.height - ball.height





             radius: width/2

             MouseArea {

                 anchors.fill: parent
                 drag.target: ventana

                 onClicked: {

                     ball.x = 0
                     ball.y = ventana.height - ball.height
                     ball.rotation = 0

                     anim.restart();
                 }

             }
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
                         ventana.state = "Guardar"
                     }else{
                         ventana.serchElement()
                     }

            }
         }

        }

        MyButton{
           id:idGuardar
           width: 250
           titleButton: "Guardar"
           anchors{
               top: agenda.bottom
               left: agenda.left
               topMargin: 10
           }

           MouseArea{
             anchors.fill: parent

             onClicked: {

                 ventana.state = "Search"

             }
           }

        }

        Text {
               id: title
               text: qsTr("AGENDA1.0")
               font.family: "Segoe UI Emoji"
               font.bold: true
               horizontalAlignment: Text.AlignHCenter
               font.pointSize: 15
               color: "#37474f"
               anchors{
                    top: ventana.top
                    left: ventana.left
                    margins: 20
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
                   radius: 50

               }

               LabelAndInput{
                   id : contacto
                   labeltext: "Dirección"
               }

               LabelAndInput{
                  id: address
                  labeltext: "Numero"

               }

           }


        function createDataBase() {
       //create the database
       db = LocalStorage.openDatabaseSync("evendatabase","1.0","this database store data related to events",2000)

       // create the database where the data will be stored
       db.transaction((tx) =>{
           var sentencia = 'CREATE TABLE IF NOT EXISTS eventtable(nombre TEXT,address TEXT,number TEXT)';
           tx.executeSql(sentencia);
                          console.log("database created");
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

       var object={};
       object.nombre='ibrahima';
      var result = db.transaction((tx)=>{tx.executeSql(sentencia,JSON.stringify([object]))})

        console.log(result);
        if(result.rows.length > 0){
            var row = result.rows.item(0);
            nombre.inputText = row.nombre;
        }else{
            address.visible =  true
            address.visible =  true
            console.log("no se encontro el elemento");
        }

        const hello = () =>{

        }

   }

   function updateEvent(){
         var sentencia = "UPDATE eventtable SET nombre = ?, address = ?, number = ? WHERE nombre = ?";
         db.transaction((tx) => {
              tx.executeSql(sentencia,[nombre.text,contacto.text,address.text,nombre.text]);
         });
    }

   Component.onCompleted: {
       createDataBase()
        anim.restart();
   }
   ParallelAnimation{

            id:anim

            SequentialAnimation{

                NumberAnimation {
                    target: ball
                    property: "y"
                    to:20
                    duration: ventana.duration * 0.4

                    easing.type: Easing.OutCirc


                }


                NumberAnimation {
                    target: ball
                    property: "y"
                    to:ventana.height-ball.height
                    duration: ventana.duration * 0.6

                    easing.type: Easing.OutBounce

                }






            }

            RotationAnimation {
                target: ball
                properties: "rotation"
                to: ventana.width
                duration: ventana.duration
            }


            NumberAnimation {
                target: ball
                property: "x"
                duration: ventana.duration
                to:ventana.width-ball.width
            }


        }

   state: "Search"

   states: [

       State {
           name: "Search"
           PropertyChanges { target: address;visible : false}
           PropertyChanges { target: contacto; visible : false}
           PropertyChanges { target: idGuardar; visible : false}
       },

       State {
           name: "Guardar"
           PropertyChanges { target: address;visible : true}
           PropertyChanges { target: contacto; visible : true}
           PropertyChanges { target: idGuardar; visible : true}
       }
   ]

   transitions: [

       Transition {
           from: "*"
           to: "*"



           ColorAnimation {
               target: idGuardar
               properties: "color"
           }

           ColorAnimation {
               target: address
               properties: "color"
           }

           ColorAnimation {
               target: contacto
               properties: "color"
           }
       }

   ]

    }
}

