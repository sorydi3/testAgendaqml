import QtQuick
import QtQuick.LocalStorage 2.0
import QtQuick.Controls


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

        property int currentMonth:0

        property int  currentYear: 0

        property var months: ["January","February","March","April","May","June","July",
            "August","September","October","November","December"];




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
                         ventana.serchElement(nombre.inputText);
                     }

                     //idDialogo.open()

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

                 function insertEvent (){

                     var sentencia = "INSERT INTO eventtable VALUES(?,?,?);";

                     console.log(sentencia);

                     console.log("nombre--->" + nombre.inputText)
                         var idResult
                     ventana.db.transaction( function (tx) {
                        idResult = tx.executeSql(sentencia,[nombre.inputText,contacto.inputText,address.inputText])
                       });

                     console.log("ID OF THE ISERTED ROW =>" + idResult);
                }

                 insertEvent();

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

                   clickeable: false




               }

               LabelAndInput{
                  id: address
                  labeltext: "Numero"

               }


               LabelAndInput{
                  id: foto
                  labeltext: "ArchivoFoto"
               }

           }


   function createTableCoordinates () {

       db.transaction((tx) =>{
           var sentencia = 'CREATE TABLE IF NOT EXISTS coordinates(name TEXT,value TEXT)';
           tx.executeSql(sentencia);
                          console.log("creating table coordinates");
       });

   }



   function guardarPosition() {

           if(!dB) return

           dB.transaction ((tx) => {

                               var sentencia = "SELECT name FROM data WHERE name = 'posRect'";
                               var resultadao = tx.executeSql(sentencia);
                               var objecto = {
                               x : cuadrado.x,
                                   y:cuadrado.y
                               };

                               if(resultadao.rows.length===1){
                                   console.log("tenemos un row por lo menos");
                                   resultadao = tx.executeSql("UPDATE data set value=? WHERE  name = 'posRect'",[JSON.stringify(objecto)]);
                               }else{
                                   console.log("todavia no hay datos en la taula");
                                   resultadao = tx.executeSql("INSERT INTO data VALUES (?,?)",["posRect",JSON.stringify(objecto)])
                               }

        });

   }

   function leerPosition (){

       if (!dB) return

       dB.transaction((tx) => {
                      var sentencia = "SELECT * FROM data WHERE name='posRect'";
         var resultado = tx.executeSql(sentencia);
                          if(resultado.rows.length ===1){

                          var valor = resultado.rows[0].value;

                              var objeto = JSON.parse(valor);
                              cuadrado.x = objeto.x;
                              cuadrado.y = objeto.y;
                          }


       });


 }





   function createDataBase() {
       //create the database
       db = LocalStorage.openDatabaseSync("evendatabase","1.0","this database store data related to events",2000)

       // create the database where the data will be stored
       db.transaction((tx) =>{
                          var sentencia = 'DROP TABLE IF EXISTS';
                          tx.executeSql(sentencia)
                      });

       db.transaction((tx) =>{
           var sentencia = 'CREATE TABLE IF NOT EXISTS eventtable(nombre TEXT,address TEXT,number TEXT)';
           tx.executeSql(sentencia);
                          console.log("database created");
       });
   }


   function deleteEvent(){
       var sentecia = "DELETE FROM eventtable WHERE nombre = ?"
       db.transaction((tx)=>{tx.executeSql(sentencia,[nombre.text])})

   }

   function serchElement(nombree) {
      var sentencia = "SELECT * FROM eventtable WHERE nombre = '"+nombree+"';";
       console.log(sentencia);

       if(!db){

           console.log("DATABASE DOES NOT EXIST!");

           return;
       }

        var result;
       db.transaction((tx)=>{ result = tx.executeSql(sentencia)})

        console.log( "result ==>"+ result.rows.length);
       if(!result){
        ventana.state = "Guardar"
           return
       }
        if(result.rows.length > 0){
            var row = result.rows.item(0);
            nombre.inputText = row.nombre;

        }else{
            address.visible =  true
            ventana.state = "Guardar"
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

   function populateModel(){
        var fechaLocal = new Date(currentYear,currentMonth,1);
        var modelLocal=[]
       fechaLocal.setDate(1);

       if(fechaLocal.getDay()>1){

            fechaLocal.setTime(fechaLocal.getTime()-24+3600*1000*(fechaLocal.getDay()-1));
       }else if(fechaLocal.getDay()<1){

        fechaLocal.setTime(fechaLocal.getTime()-24*3600*1000*6);
       }

    for(var i = 0;i< 42;i++){
        modelLocal.push(fechaLocal.getDate());
        fechaLocal.setTime(fechaLocal.getTime()+24*3600000);
    }

    calendario.model = modelLocal
   }

   Component.onCompleted: {
       createDataBase()
        //anim.restart();
       timer.restart()

       var fecha = new Date()

       currentMonth = fecha.getMonth()
       currentYear = 2022
       ventana.populateModel();
   }



   Timer{

        id:timer

        interval:ventana.duration

        repeat:true

        running:true

        onTriggered : anim.restart();

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
           PropertyChanges { target: foto; visible : false}
       },

       State {
           name: "Guardar"
           PropertyChanges { target: address;visible : true}
           PropertyChanges { target: contacto; visible : true}
           PropertyChanges { target: idGuardar; visible : true}
           PropertyChanges { target: foto; visible : true}
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


   Dialog{

       id:idDialogo

       Rectangle{

           id: idContainerButtons

           anchors.top: ventana.top
           anchors.right: ventana.right

           width: ventana.width/3
           height: ventana.height/14
           z:1
           radius: 10

           color: "yellow"

           anchors.margins: 10


           Rectangle{

               id:leftButton
               anchors.top: parent.top
               anchors.left: parent.left
               anchors.leftMargin: 10
               anchors.topMargin: 10
               color: "#b0ff57"

               width: idContainerButtons.width/4
               height: idContainerButtons.height/2

               radius: 10


               Text{
                   anchors.centerIn: parent
                   text: "<"
                   font.bold: true
                   font.pointSize: 12
                   //color: "red"

               }

               MouseArea{

                   anchors.fill: parent

                   onClicked: {

                       if(ventana.currentMonth>=0){

                        ventana.currentMonth--
                       }else{

                           ventana.currentMonth=11
                           ventana.currentYear--;

                       }

                       ventana.populateModel();

                   }
               }

           }



          Column{

              anchors.centerIn: parent
              Text {
                  id: month
                  text: ventana.months[ventana.currentMonth]
              }

              Text {
                  id: date
                  text: ventana.currentYear
              }

          }


           Rectangle{
               anchors.right: parent.right
               anchors.top: parent.top
               anchors.margins: 10
               color: "#b0ff57"
               width: idContainerButtons.width/4
               height: idContainerButtons.height/2

               radius: 10


               id:idRightButton
               Text{
                   anchors.centerIn: parent
                   text: ">"
                   font.bold: true
                   font.pointSize: 12
               }


               MouseArea{

                   anchors.fill: parent

                   onClicked: {

                       if(ventana.currentMonth<11){

                        ventana.currentMonth++
                       }else{

                           ventana.currentMonth=0
                           ventana.currentYear++;

                       }

                       ventana.populateModel();
                   }
               }

           }



       }

       Rectangle{

           id:rectanguloCalendario

           anchors.top: idContainerButtons.bottom
           anchors.right: ventana.right
           radius: 5

           anchors.topMargin: 10
           anchors.rightMargin: 10

            z:1

            height: ventana.height/4
            width: ventana.width/3

            //color: ""



           GridView{

               anchors.fill: parent

               id:calendario


                //model: 42

                cellWidth : calendario.width/7
                cellHeight: calendario.height/6





                delegate: Rectangle{

                    id:rectangleDelegate
                    color: "green"
                    width: calendario.cellWidth
                    height: calendario.cellHeight

                    radius: 5
                    //border.color: "black"

                    required property var modelData

                    Rectangle{

                        id: irectangle


                        anchors.margins: calendario.cellWidth



                        anchors.fill: parent


                        Text {
                            id: delegate
                            color: "white"
                            text: rectangleDelegate.modelData
                            anchors.centerIn: parent
                            font.bold:true
                        }


                        MouseArea{

                                id: idMouseAreadelegate


                                anchors.fill: parent


                                onClicked: {

                                    //if()
                                        

                                }

                        }


                    }

                }
           }



      }
}

   }
}

