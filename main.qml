import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Agenda")


    Rectangle {
        id:ventana
        anchors.fill: parent
        color: "#b0ff57"


        Text {
               id: title
               text: qsTr("AGENDA")
               font.family: "Segoe UI Black"
               font.pointSize: 30
               anchors{
                    top: vantana.top
                    left: ventana.left
                    margins: 15
               }
           }

           Rectangle{

               width: 100
               height: 50
               radius: 10
               color: "#ba2d65"

               anchors{

                   bottom: agenda.top
                   right: agenda.right
                   margins: 10



               }


               Text {
                   id: bText
                   text: qsTr("Buscar")
                   anchors.centerIn: parent
                   font.pointSize: 15
                   color: "white"
               }

               MouseArea {
                   anchors.fill: parent

                   onClicked: {
                       console.log("mouse clicked");
                       contacto.visible = !contacto.visible
                       address.visible = !address.visible
                   }

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
    }

}
