import QtQuick

Item {
    width: parent.width
    height: containerlabeText.height
    id:mainid
    property alias labeltext : labelNombre.text
    property alias inputText : nombre.text
    property bool clickeable: true
    signal campoSeleccionado();
    Rectangle{



          width: parent.width
          height: 80
          color: "#32cb00"
          anchors.margins: 10
          radius: 10
          id:containerlabeText

              Text {
                  id: labelNombre
                  text: qsTr("Nombre")
                  anchors.top: containerlabeText.top
                  anchors.left: containerlabeText.left
                  anchors.leftMargin: 10
                   anchors.topMargin: 5

                  //width: agenda.width-10
                   color: "#37474f"
              }

            Rectangle{
                id:textInput
                width: agenda.width-20
                height: 30
                anchors{
                    top: labelNombre.bottom
                    //left: agenda.left
                    //right: agenda.right
                    margins: 5
                    centerIn: parent
                }

                border.color: "black"

                radius: 5

                TextInput{
                    anchors.fill:parent
                    //width: parent.width
                    //height: 30
                    id : nombre

                    text: ""
                    anchors.margins: 5

                    MouseArea{
                        id:mouserear

                        anchors.fill: parent



                        hoverEnabled: true


                        cursorShape: Qt.IBeamCursor


                        onClicked: {
                            nombre.focus=mainid.clickeable;
                            //containerlabeText.campoSeleccionado();
                        }



                    }



                }

            }
    }


}
